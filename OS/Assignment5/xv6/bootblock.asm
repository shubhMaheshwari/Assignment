
bootblock.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
#define CR0_PE    1  // protected mode enable bit

.code16                       # Assemble for 16-bit mode
.globl start
start:
  cli                         # Disable interrupts
    7c00:	fa                   	cli    

  # Set up the important data segment registers (DS, ES, SS).
  xorw    %ax,%ax             # Segment number zero
    7c01:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
    7c03:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
    7c05:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
    7c07:	8e d0                	mov    %eax,%ss

00007c09 <seta20.1>:
  # Enable A20:
  #   For backwards compatibility with the earliest PCs, physical
  #   address line 20 is tied low, so that addresses higher than
  #   1MB wrap around to zero by default.  This code undoes this.
seta20.1:
  inb     $0x64,%al               # Wait for not busy
    7c09:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c0b:	a8 02                	test   $0x2,%al
  jnz     seta20.1
    7c0d:	75 fa                	jne    7c09 <seta20.1>

  movb    $0xd1,%al               # 0xd1 -> port 0x64
    7c0f:	b0 d1                	mov    $0xd1,%al
  outb    %al,$0x64
    7c11:	e6 64                	out    %al,$0x64

00007c13 <seta20.2>:

seta20.2:
  inb     $0x64,%al               # Wait for not busy
    7c13:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c15:	a8 02                	test   $0x2,%al
  jnz     seta20.2
    7c17:	75 fa                	jne    7c13 <seta20.2>

  movb    $0xdf,%al               # 0xdf -> port 0x60
    7c19:	b0 df                	mov    $0xdf,%al
  outb    %al,$0x60
    7c1b:	e6 60                	out    %al,$0x60

  # Switch from real to protected mode, using a bootstrap GDT
  # and segment translation that makes virtual addresses 
  # identical to physical addresses, so that the 
  # effective memory map does not change during the switch.
  lgdt    gdtdesc
    7c1d:	0f 01 16             	lgdtl  (%esi)
    7c20:	78 7c                	js     7c9e <readsect+0x11>
  movl    %cr0, %eax
    7c22:	0f 20 c0             	mov    %cr0,%eax
  orl     $CR0_PE, %eax
    7c25:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
    7c29:	0f 22 c0             	mov    %eax,%cr0
  
  # Jump to next instruction, but in 32-bit code segment.
  # Switches processor into 32-bit mode.
  ljmp    $(SEG_KCODE<<3), $start32
    7c2c:	ea                   	.byte 0xea
    7c2d:	31 7c 08 00          	xor    %edi,0x0(%eax,%ecx,1)

00007c31 <start32>:

.code32                       # Assemble for 32-bit mode
start32:
  # Set up the protected-mode data segment registers
  movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
    7c31:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
    7c35:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
    7c37:	8e c0                	mov    %eax,%es
  movw    %ax, %ss                # -> SS: Stack Segment
    7c39:	8e d0                	mov    %eax,%ss
  movw    $0, %ax                 # Zero segments not ready for use
    7c3b:	66 b8 00 00          	mov    $0x0,%ax
  movw    %ax, %fs                # -> FS
    7c3f:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
    7c41:	8e e8                	mov    %eax,%gs

  # Set up the stack pointer and call into C.
  movl    $start, %esp
    7c43:	bc 00 7c 00 00       	mov    $0x7c00,%esp
  call    bootmain
    7c48:	e8 e5 00 00 00       	call   7d32 <bootmain>

  # If bootmain returns (it shouldn't), trigger a Bochs
  # breakpoint if running under Bochs, then loop.
  movw    $0x8a00, %ax            # 0x8a00 -> port 0x8a00
    7c4d:	66 b8 00 8a          	mov    $0x8a00,%ax
  movw    %ax, %dx
    7c51:	66 89 c2             	mov    %ax,%dx
  outw    %ax, %dx
    7c54:	66 ef                	out    %ax,(%dx)
  movw    $0x8e00, %ax            # 0x8e00 -> port 0x8a00
    7c56:	66 b8 00 8e          	mov    $0x8e00,%ax
  outw    %ax, %dx
    7c5a:	66 ef                	out    %ax,(%dx)

00007c5c <spin>:
spin:
  jmp     spin
    7c5c:	eb fe                	jmp    7c5c <spin>
    7c5e:	66 90                	xchg   %ax,%ax

00007c60 <gdt>:
	...
    7c68:	ff                   	(bad)  
    7c69:	ff 00                	incl   (%eax)
    7c6b:	00 00                	add    %al,(%eax)
    7c6d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c74:	00                   	.byte 0x0
    7c75:	92                   	xchg   %eax,%edx
    7c76:	cf                   	iret   
	...

00007c78 <gdtdesc>:
    7c78:	17                   	pop    %ss
    7c79:	00 60 7c             	add    %ah,0x7c(%eax)
	...

00007c7e <waitdisk>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    7c7e:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c83:	ec                   	in     (%dx),%al

void
waitdisk(void)
{
  // Wait for disk ready.
  while((inb(0x1F7) & 0xC0) != 0x40)
    7c84:	83 e0 c0             	and    $0xffffffc0,%eax
    7c87:	3c 40                	cmp    $0x40,%al
    7c89:	75 f8                	jne    7c83 <waitdisk+0x5>
    ;
}
    7c8b:	f3 c3                	repz ret 

00007c8d <readsect>:

// Read a single sector at offset into dst.
void
readsect(void *dst, uint offset)
{
    7c8d:	57                   	push   %edi
    7c8e:	53                   	push   %ebx
    7c8f:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  // Issue command.
  waitdisk();
    7c93:	e8 e6 ff ff ff       	call   7c7e <waitdisk>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7c98:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c9d:	b8 01 00 00 00       	mov    $0x1,%eax
    7ca2:	ee                   	out    %al,(%dx)
    7ca3:	ba f3 01 00 00       	mov    $0x1f3,%edx
    7ca8:	89 d8                	mov    %ebx,%eax
    7caa:	ee                   	out    %al,(%dx)
  outb(0x1F2, 1);   // count = 1
  outb(0x1F3, offset);
  outb(0x1F4, offset >> 8);
    7cab:	89 d8                	mov    %ebx,%eax
    7cad:	c1 e8 08             	shr    $0x8,%eax
    7cb0:	ba f4 01 00 00       	mov    $0x1f4,%edx
    7cb5:	ee                   	out    %al,(%dx)
  outb(0x1F5, offset >> 16);
    7cb6:	89 d8                	mov    %ebx,%eax
    7cb8:	c1 e8 10             	shr    $0x10,%eax
    7cbb:	ba f5 01 00 00       	mov    $0x1f5,%edx
    7cc0:	ee                   	out    %al,(%dx)
  outb(0x1F6, (offset >> 24) | 0xE0);
    7cc1:	89 d8                	mov    %ebx,%eax
    7cc3:	c1 e8 18             	shr    $0x18,%eax
    7cc6:	83 c8 e0             	or     $0xffffffe0,%eax
    7cc9:	ba f6 01 00 00       	mov    $0x1f6,%edx
    7cce:	ee                   	out    %al,(%dx)
    7ccf:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7cd4:	b8 20 00 00 00       	mov    $0x20,%eax
    7cd9:	ee                   	out    %al,(%dx)
  outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

  // Read data.
  waitdisk();
    7cda:	e8 9f ff ff ff       	call   7c7e <waitdisk>
  asm volatile("cld; rep insl" :
    7cdf:	8b 7c 24 0c          	mov    0xc(%esp),%edi
    7ce3:	b9 80 00 00 00       	mov    $0x80,%ecx
    7ce8:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7ced:	fc                   	cld    
    7cee:	f3 6d                	rep insl (%dx),%es:(%edi)
  insl(0x1F0, dst, SECTSIZE/4);
}
    7cf0:	5b                   	pop    %ebx
    7cf1:	5f                   	pop    %edi
    7cf2:	c3                   	ret    

00007cf3 <readseg>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked.
void
readseg(uchar* va, uint count, uint offset)
{
    7cf3:	57                   	push   %edi
    7cf4:	56                   	push   %esi
    7cf5:	53                   	push   %ebx
    7cf6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
    7cfa:	8b 74 24 18          	mov    0x18(%esp),%esi
  uchar* eva;

  eva = va + count;
    7cfe:	89 df                	mov    %ebx,%edi
    7d00:	03 7c 24 14          	add    0x14(%esp),%edi

  // Round down to sector boundary.
  va -= offset % SECTSIZE;
    7d04:	89 f0                	mov    %esi,%eax
    7d06:	25 ff 01 00 00       	and    $0x1ff,%eax
    7d0b:	29 c3                	sub    %eax,%ebx

  // Translate from bytes to sectors; kernel starts at sector 1.
  offset = (offset / SECTSIZE) + 1;
    7d0d:	c1 ee 09             	shr    $0x9,%esi
    7d10:	83 c6 01             	add    $0x1,%esi

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    7d13:	39 df                	cmp    %ebx,%edi
    7d15:	76 17                	jbe    7d2e <readseg+0x3b>
    readsect(va, offset);
    7d17:	56                   	push   %esi
    7d18:	53                   	push   %ebx
    7d19:	e8 6f ff ff ff       	call   7c8d <readsect>
  for(; va < eva; va += SECTSIZE, offset++)
    7d1e:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d24:	83 c6 01             	add    $0x1,%esi
    7d27:	83 c4 08             	add    $0x8,%esp
    7d2a:	39 df                	cmp    %ebx,%edi
    7d2c:	77 e9                	ja     7d17 <readseg+0x24>
}
    7d2e:	5b                   	pop    %ebx
    7d2f:	5e                   	pop    %esi
    7d30:	5f                   	pop    %edi
    7d31:	c3                   	ret    

00007d32 <bootmain>:
{
    7d32:	55                   	push   %ebp
    7d33:	57                   	push   %edi
    7d34:	56                   	push   %esi
    7d35:	53                   	push   %ebx
    7d36:	83 ec 0c             	sub    $0xc,%esp
  readseg((uchar*)elf, 4096, 0);
    7d39:	6a 00                	push   $0x0
    7d3b:	68 00 10 00 00       	push   $0x1000
    7d40:	68 00 00 01 00       	push   $0x10000
    7d45:	e8 a9 ff ff ff       	call   7cf3 <readseg>
  if(elf->magic != ELF_MAGIC)
    7d4a:	83 c4 0c             	add    $0xc,%esp
    7d4d:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d54:	45 4c 46 
    7d57:	74 08                	je     7d61 <bootmain+0x2f>
}
    7d59:	83 c4 0c             	add    $0xc,%esp
    7d5c:	5b                   	pop    %ebx
    7d5d:	5e                   	pop    %esi
    7d5e:	5f                   	pop    %edi
    7d5f:	5d                   	pop    %ebp
    7d60:	c3                   	ret    
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
    7d61:	a1 1c 00 01 00       	mov    0x1001c,%eax
    7d66:	8d 98 00 00 01 00    	lea    0x10000(%eax),%ebx
  eph = ph + elf->phnum;
    7d6c:	0f b7 35 2c 00 01 00 	movzwl 0x1002c,%esi
    7d73:	c1 e6 05             	shl    $0x5,%esi
    7d76:	01 de                	add    %ebx,%esi
  for(; ph < eph; ph++) {
    7d78:	39 f3                	cmp    %esi,%ebx
    7d7a:	73 3b                	jae    7db7 <bootmain+0x85>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    7d7c:	bd 00 00 00 00       	mov    $0x0,%ebp
    7d81:	eb 07                	jmp    7d8a <bootmain+0x58>
    7d83:	83 c3 20             	add    $0x20,%ebx
    7d86:	39 de                	cmp    %ebx,%esi
    7d88:	76 2d                	jbe    7db7 <bootmain+0x85>
    va = (uchar*)(ph->va & 0xFFFFFF);
    7d8a:	8b 7b 08             	mov    0x8(%ebx),%edi
    7d8d:	81 e7 ff ff ff 00    	and    $0xffffff,%edi
    readseg(va, ph->filesz, ph->offset);
    7d93:	ff 73 04             	pushl  0x4(%ebx)
    7d96:	ff 73 10             	pushl  0x10(%ebx)
    7d99:	57                   	push   %edi
    7d9a:	e8 54 ff ff ff       	call   7cf3 <readseg>
    if(ph->memsz > ph->filesz)
    7d9f:	8b 4b 14             	mov    0x14(%ebx),%ecx
    7da2:	8b 43 10             	mov    0x10(%ebx),%eax
    7da5:	83 c4 0c             	add    $0xc,%esp
    7da8:	39 c1                	cmp    %eax,%ecx
    7daa:	76 d7                	jbe    7d83 <bootmain+0x51>
      stosb(va + ph->filesz, 0, ph->memsz - ph->filesz);
    7dac:	01 c7                	add    %eax,%edi
    7dae:	29 c1                	sub    %eax,%ecx
    7db0:	89 e8                	mov    %ebp,%eax
    7db2:	fc                   	cld    
    7db3:	f3 aa                	rep stos %al,%es:(%edi)
    7db5:	eb cc                	jmp    7d83 <bootmain+0x51>
  entry = (void(*)(void))(elf->entry & 0xFFFFFF);
    7db7:	a1 18 00 01 00       	mov    0x10018,%eax
    7dbc:	25 ff ff ff 00       	and    $0xffffff,%eax
  entry();
    7dc1:	ff d0                	call   *%eax
    7dc3:	eb 94                	jmp    7d59 <bootmain+0x27>

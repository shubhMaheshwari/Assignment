
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <main>:
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  100000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  100004:	83 e4 f0             	and    $0xfffffff0,%esp
  100007:	ff 71 fc             	pushl  -0x4(%ecx)
  10000a:	55                   	push   %ebp
  10000b:	89 e5                	mov    %esp,%ebp
  10000d:	53                   	push   %ebx
  10000e:	51                   	push   %ecx
  mpinit(); // collect info about this machine
  10000f:	e8 4c 29 00 00       	call   102960 <mpinit>
  lapicinit(mpbcpu());
  100014:	e8 27 29 00 00       	call   102940 <mpbcpu>
  100019:	83 ec 0c             	sub    $0xc,%esp
  10001c:	50                   	push   %eax
  10001d:	e8 1e 26 00 00       	call   102640 <lapicinit>
  ksegment();
  100022:	e8 a9 31 00 00       	call   1031d0 <ksegment>
  picinit();       // interrupt controller
  100027:	e8 74 2b 00 00       	call   102ba0 <picinit>
  ioapicinit();    // another interrupt controller
  10002c:	e8 ff 21 00 00       	call   102230 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  100031:	e8 ca 09 00 00       	call   100a00 <consoleinit>
  uartinit();      // serial port
  100036:	e8 c5 51 00 00       	call   105200 <uartinit>
cprintf("cpus %p cpu %p\n", cpus, cpu);
  10003b:	83 c4 0c             	add    $0xc,%esp
  10003e:	65 ff 35 00 00 00 00 	pushl  %gs:0x0
  100045:	68 a0 da 10 00       	push   $0x10daa0
  10004a:	68 0e 62 10 00       	push   $0x10620e
  10004f:	e8 3c 06 00 00       	call   100690 <cprintf>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
  100054:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  10005a:	59                   	pop    %ecx
  10005b:	5b                   	pop    %ebx
  10005c:	0f b6 00             	movzbl (%eax),%eax
  10005f:	50                   	push   %eax
  100060:	68 1e 62 10 00       	push   $0x10621e
  100065:	e8 26 06 00 00       	call   100690 <cprintf>

  kinit();         // physical memory allocator
  10006a:	e8 d1 23 00 00       	call   102440 <kinit>
  pinit();         // process table
  10006f:	e8 6c 30 00 00       	call   1030e0 <pinit>
  tvinit();        // trap vectors
  100074:	e8 27 4e 00 00       	call   104ea0 <tvinit>
  binit();         // buffer cache
  100079:	e8 e2 00 00 00       	call   100160 <binit>
  fileinit();      // file table
  10007e:	e8 bd 0d 00 00       	call   100e40 <fileinit>
  iinit();         // inode cache
  100083:	e8 08 14 00 00       	call   101490 <iinit>
  ideinit();       // disk
  100088:	e8 63 1f 00 00       	call   101ff0 <ideinit>
  if(!ismp)
  10008d:	a1 84 da 10 00       	mov    0x10da84,%eax
  100092:	83 c4 10             	add    $0x10,%esp
  100095:	85 c0                	test   %eax,%eax
  100097:	0f 84 ab 00 00 00    	je     100148 <main+0x148>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  10009d:	e8 1e 33 00 00       	call   1033c0 <userinit>
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1000a2:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
  1000a5:	bb a0 da 10 00       	mov    $0x10daa0,%ebx
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  1000aa:	68 6a 00 00 00       	push   $0x6a
  1000af:	68 34 a7 10 00       	push   $0x10a734
  1000b4:	68 00 70 00 00       	push   $0x7000
  1000b9:	e8 42 3d 00 00       	call   103e00 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
  1000be:	69 05 80 e0 10 00 bc 	imul   $0xbc,0x10e080,%eax
  1000c5:	00 00 00 
  1000c8:	83 c4 10             	add    $0x10,%esp
  1000cb:	05 a0 da 10 00       	add    $0x10daa0,%eax
  1000d0:	39 d8                	cmp    %ebx,%eax
  1000d2:	76 6f                	jbe    100143 <main+0x143>
  1000d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
  1000d8:	e8 53 26 00 00       	call   102730 <cpunum>
  1000dd:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  1000e3:	05 a0 da 10 00       	add    $0x10daa0,%eax
  1000e8:	39 c3                	cmp    %eax,%ebx
  1000ea:	74 3e                	je     10012a <main+0x12a>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
  1000ec:	83 ec 0c             	sub    $0xc,%esp
  1000ef:	68 00 10 00 00       	push   $0x1000
  1000f4:	e8 87 23 00 00       	call   102480 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
  1000f9:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpmain;
  1000fe:	c7 05 f8 6f 00 00 60 	movl   $0x102860,0x6ff8
  100105:	28 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
  100108:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    lapicstartap(c->id, (uint)code);
  10010d:	58                   	pop    %eax
  10010e:	5a                   	pop    %edx
  10010f:	68 00 70 00 00       	push   $0x7000
  100114:	0f b6 03             	movzbl (%ebx),%eax
  100117:	50                   	push   %eax
  100118:	e8 b3 26 00 00       	call   1027d0 <lapicstartap>
  10011d:	83 c4 10             	add    $0x10,%esp

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
  100120:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  100126:	85 c0                	test   %eax,%eax
  100128:	74 f6                	je     100120 <main+0x120>
  for(c = cpus; c < cpus+ncpu; c++){
  10012a:	69 05 80 e0 10 00 bc 	imul   $0xbc,0x10e080,%eax
  100131:	00 00 00 
  100134:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10013a:	05 a0 da 10 00       	add    $0x10daa0,%eax
  10013f:	39 c3                	cmp    %eax,%ebx
  100141:	72 95                	jb     1000d8 <main+0xd8>
  mpmain();
  100143:	e8 18 27 00 00       	call   102860 <mpmain>
    timerinit();   // uniprocessor timer
  100148:	e8 f3 4c 00 00       	call   104e40 <timerinit>
  10014d:	e9 4b ff ff ff       	jmp    10009d <main+0x9d>
  100152:	66 90                	xchg   %ax,%ax
  100154:	66 90                	xchg   %ax,%ax
  100156:	66 90                	xchg   %ax,%ax
  100158:	66 90                	xchg   %ax,%ax
  10015a:	66 90                	xchg   %ax,%ax
  10015c:	66 90                	xchg   %ax,%ax
  10015e:	66 90                	xchg   %ax,%ax

00100160 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
  100160:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
  100163:	68 80 5d 10 00       	push   $0x105d80
  100168:	68 60 a8 10 00       	push   $0x10a860
  10016d:	e8 fe 39 00 00       	call   103b70 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  100172:	c7 05 90 bd 10 00 84 	movl   $0x10bd84,0x10bd90
  100179:	bd 10 00 
  bcache.head.next = &bcache.head;
  10017c:	c7 05 94 bd 10 00 84 	movl   $0x10bd84,0x10bd94
  100183:	bd 10 00 
  100186:	83 c4 10             	add    $0x10,%esp
  100189:	b9 84 bd 10 00       	mov    $0x10bd84,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  10018e:	b8 94 a8 10 00       	mov    $0x10a894,%eax
  100193:	eb 05                	jmp    10019a <binit+0x3a>
  100195:	8d 76 00             	lea    0x0(%esi),%esi
  100198:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
  10019a:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
  10019d:	c7 40 0c 84 bd 10 00 	movl   $0x10bd84,0xc(%eax)
  1001a4:	89 c1                	mov    %eax,%ecx
    b->dev = -1;
  1001a6:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
  1001ad:	8b 15 94 bd 10 00    	mov    0x10bd94,%edx
  1001b3:	89 42 0c             	mov    %eax,0xc(%edx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001b6:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
    bcache.head.next = b;
  1001bc:	a3 94 bd 10 00       	mov    %eax,0x10bd94
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001c1:	81 fa 84 bd 10 00    	cmp    $0x10bd84,%edx
  1001c7:	72 cf                	jb     100198 <binit+0x38>
  }
}
  1001c9:	83 c4 0c             	add    $0xc,%esp
  1001cc:	c3                   	ret    
  1001cd:	8d 76 00             	lea    0x0(%esi),%esi

001001d0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1001d0:	57                   	push   %edi
  1001d1:	56                   	push   %esi
  1001d2:	53                   	push   %ebx
  1001d3:	8b 74 24 10          	mov    0x10(%esp),%esi
  1001d7:	8b 7c 24 14          	mov    0x14(%esp),%edi
  acquire(&bcache.lock);
  1001db:	83 ec 0c             	sub    $0xc,%esp
  1001de:	68 60 a8 10 00       	push   $0x10a860
  1001e3:	e8 a8 39 00 00       	call   103b90 <acquire>
  1001e8:	83 c4 10             	add    $0x10,%esp
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1001eb:	8b 1d 94 bd 10 00    	mov    0x10bd94,%ebx
  1001f1:	81 fb 84 bd 10 00    	cmp    $0x10bd84,%ebx
  1001f7:	75 12                	jne    10020b <bread+0x3b>
  1001f9:	eb 35                	jmp    100230 <bread+0x60>
  1001fb:	90                   	nop
  1001fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100200:	8b 5b 10             	mov    0x10(%ebx),%ebx
  100203:	81 fb 84 bd 10 00    	cmp    $0x10bd84,%ebx
  100209:	74 25                	je     100230 <bread+0x60>
    if(b->dev == dev && b->sector == sector){
  10020b:	3b 73 04             	cmp    0x4(%ebx),%esi
  10020e:	75 f0                	jne    100200 <bread+0x30>
  100210:	3b 7b 08             	cmp    0x8(%ebx),%edi
  100213:	75 eb                	jne    100200 <bread+0x30>
      if(!(b->flags & B_BUSY)){
  100215:	8b 03                	mov    (%ebx),%eax
  100217:	a8 01                	test   $0x1,%al
  100219:	74 68                	je     100283 <bread+0xb3>
      sleep(b, &bcache.lock);
  10021b:	83 ec 08             	sub    $0x8,%esp
  10021e:	68 60 a8 10 00       	push   $0x10a860
  100223:	53                   	push   %ebx
  100224:	e8 67 35 00 00       	call   103790 <sleep>
  100229:	83 c4 10             	add    $0x10,%esp
  10022c:	eb bd                	jmp    1001eb <bread+0x1b>
  10022e:	66 90                	xchg   %ax,%ax
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  100230:	8b 1d 90 bd 10 00    	mov    0x10bd90,%ebx
  100236:	81 fb 84 bd 10 00    	cmp    $0x10bd84,%ebx
  10023c:	75 0d                	jne    10024b <bread+0x7b>
  10023e:	eb 5a                	jmp    10029a <bread+0xca>
  100240:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100243:	81 fb 84 bd 10 00    	cmp    $0x10bd84,%ebx
  100249:	74 4f                	je     10029a <bread+0xca>
    if((b->flags & B_BUSY) == 0){
  10024b:	f6 03 01             	testb  $0x1,(%ebx)
  10024e:	75 f0                	jne    100240 <bread+0x70>
      release(&bcache.lock);
  100250:	83 ec 0c             	sub    $0xc,%esp
      b->dev = dev;
  100253:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  100256:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
  100259:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
  10025f:	68 60 a8 10 00       	push   $0x10a860
  100264:	e8 c7 3a 00 00       	call   103d30 <release>
  100269:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  10026c:	f6 03 02             	testb  $0x2,(%ebx)
  10026f:	75 0c                	jne    10027d <bread+0xad>
    iderw(b);
  100271:	83 ec 0c             	sub    $0xc,%esp
  100274:	53                   	push   %ebx
  100275:	e8 c6 1e 00 00       	call   102140 <iderw>
  10027a:	83 c4 10             	add    $0x10,%esp
  return b;
}
  10027d:	89 d8                	mov    %ebx,%eax
  10027f:	5b                   	pop    %ebx
  100280:	5e                   	pop    %esi
  100281:	5f                   	pop    %edi
  100282:	c3                   	ret    
        release(&bcache.lock);
  100283:	83 ec 0c             	sub    $0xc,%esp
        b->flags |= B_BUSY;
  100286:	83 c8 01             	or     $0x1,%eax
  100289:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
  10028b:	68 60 a8 10 00       	push   $0x10a860
  100290:	e8 9b 3a 00 00       	call   103d30 <release>
  100295:	83 c4 10             	add    $0x10,%esp
  100298:	eb d2                	jmp    10026c <bread+0x9c>
  panic("bget: no buffers");
  10029a:	83 ec 0c             	sub    $0xc,%esp
  10029d:	68 87 5d 10 00       	push   $0x105d87
  1002a2:	e8 69 05 00 00       	call   100810 <panic>
  1002a7:	89 f6                	mov    %esi,%esi
  1002a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  1002b0:	83 ec 0c             	sub    $0xc,%esp
  1002b3:	8b 54 24 10          	mov    0x10(%esp),%edx
  if((b->flags & B_BUSY) == 0)
  1002b7:	8b 02                	mov    (%edx),%eax
  1002b9:	a8 01                	test   $0x1,%al
  1002bb:	74 11                	je     1002ce <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
  1002bd:	83 c8 04             	or     $0x4,%eax
  1002c0:	89 02                	mov    %eax,(%edx)
  iderw(b);
  1002c2:	89 54 24 10          	mov    %edx,0x10(%esp)
}
  1002c6:	83 c4 0c             	add    $0xc,%esp
  iderw(b);
  1002c9:	e9 72 1e 00 00       	jmp    102140 <iderw>
    panic("bwrite");
  1002ce:	83 ec 0c             	sub    $0xc,%esp
  1002d1:	68 98 5d 10 00       	push   $0x105d98
  1002d6:	e8 35 05 00 00       	call   100810 <panic>
  1002db:	90                   	nop
  1002dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001002e0 <brelse>:

// Release the buffer b.
void
brelse(struct buf *b)
{
  1002e0:	53                   	push   %ebx
  1002e1:	83 ec 08             	sub    $0x8,%esp
  1002e4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if((b->flags & B_BUSY) == 0)
  1002e8:	f6 03 01             	testb  $0x1,(%ebx)
  1002eb:	74 58                	je     100345 <brelse+0x65>
    panic("brelse");

  acquire(&bcache.lock);
  1002ed:	83 ec 0c             	sub    $0xc,%esp
  1002f0:	68 60 a8 10 00       	push   $0x10a860
  1002f5:	e8 96 38 00 00       	call   103b90 <acquire>

  b->next->prev = b->prev;
  1002fa:	8b 43 10             	mov    0x10(%ebx),%eax
  1002fd:	8b 53 0c             	mov    0xc(%ebx),%edx
  100300:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  100303:	8b 43 0c             	mov    0xc(%ebx),%eax
  100306:	8b 53 10             	mov    0x10(%ebx),%edx
  100309:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
  10030c:	a1 94 bd 10 00       	mov    0x10bd94,%eax
  b->prev = &bcache.head;
  100311:	c7 43 0c 84 bd 10 00 	movl   $0x10bd84,0xc(%ebx)
  b->next = bcache.head.next;
  100318:	89 43 10             	mov    %eax,0x10(%ebx)
  bcache.head.next->prev = b;
  10031b:	a1 94 bd 10 00       	mov    0x10bd94,%eax
  100320:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
  100323:	89 1d 94 bd 10 00    	mov    %ebx,0x10bd94

  b->flags &= ~B_BUSY;
  100329:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
  10032c:	89 1c 24             	mov    %ebx,(%esp)
  10032f:	e8 1c 35 00 00       	call   103850 <wakeup>

  release(&bcache.lock);
  100334:	c7 44 24 20 60 a8 10 	movl   $0x10a860,0x20(%esp)
  10033b:	00 
}
  10033c:	83 c4 18             	add    $0x18,%esp
  10033f:	5b                   	pop    %ebx
  release(&bcache.lock);
  100340:	e9 eb 39 00 00       	jmp    103d30 <release>
    panic("brelse");
  100345:	83 ec 0c             	sub    $0xc,%esp
  100348:	68 9f 5d 10 00       	push   $0x105d9f
  10034d:	e8 be 04 00 00       	call   100810 <panic>
  100352:	66 90                	xchg   %ax,%ax
  100354:	66 90                	xchg   %ax,%ax
  100356:	66 90                	xchg   %ax,%ax
  100358:	66 90                	xchg   %ax,%ax
  10035a:	66 90                	xchg   %ax,%ax
  10035c:	66 90                	xchg   %ax,%ax
  10035e:	66 90                	xchg   %ax,%ax

00100360 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
  100360:	8b 0d d8 a7 10 00    	mov    0x10a7d8,%ecx
  100366:	85 c9                	test   %ecx,%ecx
  100368:	74 03                	je     10036d <consputc+0xd>
}

static inline void
cli(void)
{
  asm volatile("cli");
  10036a:	fa                   	cli    
  10036b:	eb fe                	jmp    10036b <consputc+0xb>
{
  10036d:	55                   	push   %ebp
  10036e:	57                   	push   %edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10036f:	bf d4 03 00 00       	mov    $0x3d4,%edi
  100374:	56                   	push   %esi
  100375:	53                   	push   %ebx
  100376:	89 c3                	mov    %eax,%ebx
  100378:	83 ec 18             	sub    $0x18,%esp
    cli();
    for(;;)
      ;
  }

  uartputc(c);
  10037b:	50                   	push   %eax
  10037c:	e8 3f 4f 00 00       	call   1052c0 <uartputc>
  100381:	b8 0e 00 00 00       	mov    $0xe,%eax
  100386:	89 fa                	mov    %edi,%edx
  100388:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100389:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  10038e:	89 ca                	mov    %ecx,%edx
  100390:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
  100391:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100394:	89 fa                	mov    %edi,%edx
  100396:	c1 e0 08             	shl    $0x8,%eax
  100399:	89 c6                	mov    %eax,%esi
  10039b:	b8 0f 00 00 00       	mov    $0xf,%eax
  1003a0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003a1:	89 ca                	mov    %ecx,%edx
  1003a3:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
  1003a4:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
  1003a7:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
  1003aa:	09 f0                	or     %esi,%eax
  if(c == '\n')
  1003ac:	83 fb 0a             	cmp    $0xa,%ebx
  1003af:	74 69                	je     10041a <consputc+0xba>
  else if(c == BACKSPACE){
  1003b1:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
  1003b7:	0f 84 bb 00 00 00    	je     100478 <consputc+0x118>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  1003bd:	0f b6 d3             	movzbl %bl,%edx
  1003c0:	8d 70 01             	lea    0x1(%eax),%esi
  1003c3:	80 ce 07             	or     $0x7,%dh
  1003c6:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%eax,%eax,1)
  1003cd:	00 
  if((pos/80) >= 24){  // Scroll up.
  1003ce:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
  1003d4:	7f 5b                	jg     100431 <consputc+0xd1>
  1003d6:	89 f0                	mov    %esi,%eax
  1003d8:	8d 9c 36 00 80 0b 00 	lea    0xb8000(%esi,%esi,1),%ebx
  1003df:	89 f1                	mov    %esi,%ecx
  1003e1:	c1 e8 08             	shr    $0x8,%eax
  1003e4:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1003e6:	bd d4 03 00 00       	mov    $0x3d4,%ebp
  1003eb:	b8 0e 00 00 00       	mov    $0xe,%eax
  1003f0:	89 ea                	mov    %ebp,%edx
  1003f2:	ee                   	out    %al,(%dx)
  1003f3:	be d5 03 00 00       	mov    $0x3d5,%esi
  1003f8:	89 f8                	mov    %edi,%eax
  1003fa:	89 f2                	mov    %esi,%edx
  1003fc:	ee                   	out    %al,(%dx)
  1003fd:	b8 0f 00 00 00       	mov    $0xf,%eax
  100402:	89 ea                	mov    %ebp,%edx
  100404:	ee                   	out    %al,(%dx)
  100405:	89 c8                	mov    %ecx,%eax
  100407:	89 f2                	mov    %esi,%edx
  100409:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
  10040a:	b8 20 07 00 00       	mov    $0x720,%eax
  10040f:	66 89 03             	mov    %ax,(%ebx)
  cgaputc(c);
}
  100412:	83 c4 0c             	add    $0xc,%esp
  100415:	5b                   	pop    %ebx
  100416:	5e                   	pop    %esi
  100417:	5f                   	pop    %edi
  100418:	5d                   	pop    %ebp
  100419:	c3                   	ret    
    pos += 80 - pos%80;
  10041a:	ba 67 66 66 66       	mov    $0x66666667,%edx
  10041f:	f7 ea                	imul   %edx
  100421:	89 d0                	mov    %edx,%eax
  100423:	c1 e8 05             	shr    $0x5,%eax
  100426:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100429:	c1 e0 04             	shl    $0x4,%eax
  10042c:	8d 70 50             	lea    0x50(%eax),%esi
  10042f:	eb 9d                	jmp    1003ce <consputc+0x6e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  100431:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
  100434:	83 ee 50             	sub    $0x50,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  100437:	68 60 0e 00 00       	push   $0xe60
  10043c:	68 a0 80 0b 00       	push   $0xb80a0
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100441:	8d 9c 36 00 80 0b 00 	lea    0xb8000(%esi,%esi,1),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  100448:	68 00 80 0b 00       	push   $0xb8000
  10044d:	e8 ae 39 00 00       	call   103e00 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100452:	b8 80 07 00 00       	mov    $0x780,%eax
  100457:	83 c4 0c             	add    $0xc,%esp
  10045a:	29 f0                	sub    %esi,%eax
  10045c:	01 c0                	add    %eax,%eax
  10045e:	50                   	push   %eax
  10045f:	6a 00                	push   $0x0
  100461:	53                   	push   %ebx
  100462:	e8 19 39 00 00       	call   103d80 <memset>
  100467:	89 f0                	mov    %esi,%eax
  100469:	89 f1                	mov    %esi,%ecx
  10046b:	83 c4 10             	add    $0x10,%esp
  10046e:	c1 e8 08             	shr    $0x8,%eax
  100471:	89 c7                	mov    %eax,%edi
  100473:	e9 6e ff ff ff       	jmp    1003e6 <consputc+0x86>
    if(pos > 0)
  100478:	85 c0                	test   %eax,%eax
  10047a:	74 15                	je     100491 <consputc+0x131>
      crt[--pos] = ' ' | 0x0700;
  10047c:	8d 70 ff             	lea    -0x1(%eax),%esi
  10047f:	ba 20 07 00 00       	mov    $0x720,%edx
  100484:	66 89 94 36 00 80 0b 	mov    %dx,0xb8000(%esi,%esi,1)
  10048b:	00 
  10048c:	e9 3d ff ff ff       	jmp    1003ce <consputc+0x6e>
    if(pos > 0)
  100491:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
  100496:	31 c9                	xor    %ecx,%ecx
  100498:	31 ff                	xor    %edi,%edi
  10049a:	e9 47 ff ff ff       	jmp    1003e6 <consputc+0x86>
  10049f:	90                   	nop

001004a0 <printint>:
{
  1004a0:	57                   	push   %edi
  1004a1:	56                   	push   %esi
  1004a2:	89 d6                	mov    %edx,%esi
  1004a4:	53                   	push   %ebx
  1004a5:	83 ec 10             	sub    $0x10,%esp
  if(sgn && xx < 0){
  1004a8:	85 c9                	test   %ecx,%ecx
  1004aa:	74 64                	je     100510 <printint+0x70>
  1004ac:	89 c2                	mov    %eax,%edx
  1004ae:	c1 ea 1f             	shr    $0x1f,%edx
  1004b1:	84 d2                	test   %dl,%dl
  1004b3:	74 5b                	je     100510 <printint+0x70>
    x = -xx;
  1004b5:	f7 d8                	neg    %eax
    neg = 1;
  1004b7:	bf 01 00 00 00       	mov    $0x1,%edi
  int i = 0, neg = 0;
  1004bc:	31 c9                	xor    %ecx,%ecx
  1004be:	eb 02                	jmp    1004c2 <printint+0x22>
    buf[i++] = digits[x % base];
  1004c0:	89 d9                	mov    %ebx,%ecx
  1004c2:	31 d2                	xor    %edx,%edx
  1004c4:	8d 59 01             	lea    0x1(%ecx),%ebx
  1004c7:	f7 f6                	div    %esi
  1004c9:	0f b6 92 d0 5d 10 00 	movzbl 0x105dd0(%edx),%edx
  }while((x /= base) != 0);
  1004d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
  1004d2:	88 54 1c ff          	mov    %dl,-0x1(%esp,%ebx,1)
  }while((x /= base) != 0);
  1004d6:	75 e8                	jne    1004c0 <printint+0x20>
  if(neg)
  1004d8:	85 ff                	test   %edi,%edi
  1004da:	74 07                	je     1004e3 <printint+0x43>
    buf[i++] = '-';
  1004dc:	c6 04 1c 2d          	movb   $0x2d,(%esp,%ebx,1)
  1004e0:	8d 59 02             	lea    0x2(%ecx),%ebx
  while(--i >= 0)
  1004e3:	83 eb 01             	sub    $0x1,%ebx
  1004e6:	8d 76 00             	lea    0x0(%esi),%esi
  1004e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
  1004f0:	0f be 04 1c          	movsbl (%esp,%ebx,1),%eax
  while(--i >= 0)
  1004f4:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
  1004f7:	e8 64 fe ff ff       	call   100360 <consputc>
  while(--i >= 0)
  1004fc:	83 fb ff             	cmp    $0xffffffff,%ebx
  1004ff:	75 ef                	jne    1004f0 <printint+0x50>
}
  100501:	83 c4 10             	add    $0x10,%esp
  100504:	5b                   	pop    %ebx
  100505:	5e                   	pop    %esi
  100506:	5f                   	pop    %edi
  100507:	c3                   	ret    
  100508:	90                   	nop
  100509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int i = 0, neg = 0;
  100510:	31 ff                	xor    %edi,%edi
  100512:	eb a8                	jmp    1004bc <printint+0x1c>
  100514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10051a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100520 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  100520:	55                   	push   %ebp
  100521:	57                   	push   %edi
  100522:	56                   	push   %esi
  100523:	53                   	push   %ebx
  100524:	83 ec 18             	sub    $0x18,%esp
  100527:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
  10052b:	8b 7c 24 34          	mov    0x34(%esp),%edi
  int i;

  iunlock(ip);
  10052f:	55                   	push   %ebp
  100530:	e8 fb 11 00 00       	call   101730 <iunlock>
  acquire(&cons.lock);
  100535:	c7 04 24 a0 a7 10 00 	movl   $0x10a7a0,(%esp)
  10053c:	e8 4f 36 00 00       	call   103b90 <acquire>
  for(i = 0; i < n; i++)
  100541:	83 c4 10             	add    $0x10,%esp
  100544:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  100548:	85 ff                	test   %edi,%edi
  10054a:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  10054d:	7e 10                	jle    10055f <consolewrite+0x3f>
  10054f:	90                   	nop
    consputc(buf[i] & 0xff);
  100550:	0f b6 03             	movzbl (%ebx),%eax
  100553:	83 c3 01             	add    $0x1,%ebx
  100556:	e8 05 fe ff ff       	call   100360 <consputc>
  for(i = 0; i < n; i++)
  10055b:	39 de                	cmp    %ebx,%esi
  10055d:	75 f1                	jne    100550 <consolewrite+0x30>
  release(&cons.lock);
  10055f:	83 ec 0c             	sub    $0xc,%esp
  100562:	68 a0 a7 10 00       	push   $0x10a7a0
  100567:	e8 c4 37 00 00       	call   103d30 <release>
  ilock(ip);
  10056c:	89 2c 24             	mov    %ebp,(%esp)
  10056f:	e8 ac 10 00 00       	call   101620 <ilock>

  return n;
}
  100574:	83 c4 1c             	add    $0x1c,%esp
  100577:	89 f8                	mov    %edi,%eax
  100579:	5b                   	pop    %ebx
  10057a:	5e                   	pop    %esi
  10057b:	5f                   	pop    %edi
  10057c:	5d                   	pop    %ebp
  10057d:	c3                   	ret    
  10057e:	66 90                	xchg   %ax,%ax

00100580 <consoleread>:
{
  100580:	55                   	push   %ebp
  100581:	57                   	push   %edi
  100582:	56                   	push   %esi
  100583:	53                   	push   %ebx
  100584:	83 ec 28             	sub    $0x28,%esp
  100587:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
  10058b:	8b 5c 24 44          	mov    0x44(%esp),%ebx
  10058f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  iunlock(ip);
  100593:	55                   	push   %ebp
  100594:	e8 97 11 00 00       	call   101730 <iunlock>
  acquire(&input.lock);
  100599:	c7 04 24 a0 bf 10 00 	movl   $0x10bfa0,(%esp)
  1005a0:	e8 eb 35 00 00       	call   103b90 <acquire>
  while(n > 0){
  1005a5:	83 c4 10             	add    $0x10,%esp
  1005a8:	31 c0                	xor    %eax,%eax
  1005aa:	85 db                	test   %ebx,%ebx
  1005ac:	0f 8e a0 00 00 00    	jle    100652 <consoleread+0xd2>
  1005b2:	89 de                	mov    %ebx,%esi
    while(input.r == input.w){
  1005b4:	a1 54 c0 10 00       	mov    0x10c054,%eax
  1005b9:	3b 05 58 c0 10 00    	cmp    0x10c058,%eax
  1005bf:	74 29                	je     1005ea <consoleread+0x6a>
  1005c1:	eb 5d                	jmp    100620 <consoleread+0xa0>
  1005c3:	90                   	nop
  1005c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(&input.r, &input.lock);
  1005c8:	83 ec 08             	sub    $0x8,%esp
  1005cb:	68 a0 bf 10 00       	push   $0x10bfa0
  1005d0:	68 54 c0 10 00       	push   $0x10c054
  1005d5:	e8 b6 31 00 00       	call   103790 <sleep>
    while(input.r == input.w){
  1005da:	a1 54 c0 10 00       	mov    0x10c054,%eax
  1005df:	83 c4 10             	add    $0x10,%esp
  1005e2:	3b 05 58 c0 10 00    	cmp    0x10c058,%eax
  1005e8:	75 36                	jne    100620 <consoleread+0xa0>
      if(proc->killed){
  1005ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1005f0:	8b 40 24             	mov    0x24(%eax),%eax
  1005f3:	85 c0                	test   %eax,%eax
  1005f5:	74 d1                	je     1005c8 <consoleread+0x48>
        release(&input.lock);
  1005f7:	83 ec 0c             	sub    $0xc,%esp
  1005fa:	68 a0 bf 10 00       	push   $0x10bfa0
  1005ff:	e8 2c 37 00 00       	call   103d30 <release>
        ilock(ip);
  100604:	89 2c 24             	mov    %ebp,(%esp)
  100607:	e8 14 10 00 00       	call   101620 <ilock>
        return -1;
  10060c:	83 c4 10             	add    $0x10,%esp
  10060f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100614:	83 c4 1c             	add    $0x1c,%esp
  100617:	5b                   	pop    %ebx
  100618:	5e                   	pop    %esi
  100619:	5f                   	pop    %edi
  10061a:	5d                   	pop    %ebp
  10061b:	c3                   	ret    
  10061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
  100620:	8d 50 01             	lea    0x1(%eax),%edx
  100623:	89 15 54 c0 10 00    	mov    %edx,0x10c054
  100629:	89 c2                	mov    %eax,%edx
  10062b:	83 e2 7f             	and    $0x7f,%edx
  10062e:	0f be 92 d4 bf 10 00 	movsbl 0x10bfd4(%edx),%edx
    if(c == C('D')){  // EOF
  100635:	83 fa 04             	cmp    $0x4,%edx
  100638:	74 3a                	je     100674 <consoleread+0xf4>
    *dst++ = c;
  10063a:	83 c7 01             	add    $0x1,%edi
    --n;
  10063d:	83 ee 01             	sub    $0x1,%esi
    if(c == '\n')
  100640:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
  100643:	88 57 ff             	mov    %dl,-0x1(%edi)
    if(c == '\n')
  100646:	74 35                	je     10067d <consoleread+0xfd>
  while(n > 0){
  100648:	85 f6                	test   %esi,%esi
  10064a:	0f 85 64 ff ff ff    	jne    1005b4 <consoleread+0x34>
  100650:	89 d8                	mov    %ebx,%eax
  100652:	89 44 24 0c          	mov    %eax,0xc(%esp)
  release(&input.lock);
  100656:	83 ec 0c             	sub    $0xc,%esp
  100659:	68 a0 bf 10 00       	push   $0x10bfa0
  10065e:	e8 cd 36 00 00       	call   103d30 <release>
  ilock(ip);
  100663:	89 2c 24             	mov    %ebp,(%esp)
  100666:	e8 b5 0f 00 00       	call   101620 <ilock>
  return target - n;
  10066b:	83 c4 10             	add    $0x10,%esp
  10066e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100672:	eb a0                	jmp    100614 <consoleread+0x94>
      if(n < target){
  100674:	39 f3                	cmp    %esi,%ebx
  100676:	76 05                	jbe    10067d <consoleread+0xfd>
        input.r--;
  100678:	a3 54 c0 10 00       	mov    %eax,0x10c054
  10067d:	89 d8                	mov    %ebx,%eax
  10067f:	29 f0                	sub    %esi,%eax
  100681:	eb cf                	jmp    100652 <consoleread+0xd2>
  100683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100690 <cprintf>:
{
  100690:	55                   	push   %ebp
  100691:	57                   	push   %edi
  100692:	56                   	push   %esi
  100693:	53                   	push   %ebx
  100694:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
  100697:	8b 2d d4 a7 10 00    	mov    0x10a7d4,%ebp
  if(locking)
  10069d:	85 ed                	test   %ebp,%ebp
  10069f:	0f 85 1b 01 00 00    	jne    1007c0 <cprintf+0x130>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1006a5:	8b 74 24 30          	mov    0x30(%esp),%esi
  1006a9:	0f b6 06             	movzbl (%esi),%eax
  1006ac:	85 c0                	test   %eax,%eax
  1006ae:	74 78                	je     100728 <cprintf+0x98>
{
  1006b0:	8d 7c 24 34          	lea    0x34(%esp),%edi
  1006b4:	31 db                	xor    %ebx,%ebx
  1006b6:	eb 53                	jmp    10070b <cprintf+0x7b>
  1006b8:	90                   	nop
  1006b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[++i] & 0xff;
  1006c0:	83 c3 01             	add    $0x1,%ebx
  1006c3:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
  1006c7:	85 d2                	test   %edx,%edx
  1006c9:	74 55                	je     100720 <cprintf+0x90>
    switch(c){
  1006cb:	83 fa 70             	cmp    $0x70,%edx
  1006ce:	74 6a                	je     10073a <cprintf+0xaa>
  1006d0:	7f 5e                	jg     100730 <cprintf+0xa0>
  1006d2:	83 fa 25             	cmp    $0x25,%edx
  1006d5:	0f 84 d5 00 00 00    	je     1007b0 <cprintf+0x120>
  1006db:	83 fa 64             	cmp    $0x64,%edx
  1006de:	0f 85 ac 00 00 00    	jne    100790 <cprintf+0x100>
      printint(*argp++, 10, 1);
  1006e4:	8d 47 04             	lea    0x4(%edi),%eax
  1006e7:	b9 01 00 00 00       	mov    $0x1,%ecx
  1006ec:	ba 0a 00 00 00       	mov    $0xa,%edx
  1006f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1006f5:	8b 07                	mov    (%edi),%eax
  1006f7:	e8 a4 fd ff ff       	call   1004a0 <printint>
  1006fc:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100700:	83 c3 01             	add    $0x1,%ebx
  100703:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  100707:	85 c0                	test   %eax,%eax
  100709:	74 15                	je     100720 <cprintf+0x90>
    if(c != '%'){
  10070b:	83 f8 25             	cmp    $0x25,%eax
  10070e:	74 b0                	je     1006c0 <cprintf+0x30>
      consputc('%');
  100710:	e8 4b fc ff ff       	call   100360 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100715:	83 c3 01             	add    $0x1,%ebx
  100718:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  10071c:	85 c0                	test   %eax,%eax
  10071e:	75 eb                	jne    10070b <cprintf+0x7b>
  if(locking)
  100720:	85 ed                	test   %ebp,%ebp
  100722:	0f 85 b7 00 00 00    	jne    1007df <cprintf+0x14f>
}
  100728:	83 c4 1c             	add    $0x1c,%esp
  10072b:	5b                   	pop    %ebx
  10072c:	5e                   	pop    %esi
  10072d:	5f                   	pop    %edi
  10072e:	5d                   	pop    %ebp
  10072f:	c3                   	ret    
    switch(c){
  100730:	83 fa 73             	cmp    $0x73,%edx
  100733:	74 23                	je     100758 <cprintf+0xc8>
  100735:	83 fa 78             	cmp    $0x78,%edx
  100738:	75 56                	jne    100790 <cprintf+0x100>
      printint(*argp++, 16, 0);
  10073a:	8d 47 04             	lea    0x4(%edi),%eax
  10073d:	31 c9                	xor    %ecx,%ecx
  10073f:	ba 10 00 00 00       	mov    $0x10,%edx
  100744:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100748:	8b 07                	mov    (%edi),%eax
  10074a:	e8 51 fd ff ff       	call   1004a0 <printint>
  10074f:	8b 7c 24 0c          	mov    0xc(%esp),%edi
      break;
  100753:	eb ab                	jmp    100700 <cprintf+0x70>
  100755:	8d 76 00             	lea    0x0(%esi),%esi
      if((s = (char*)*argp++) == 0)
  100758:	8d 47 04             	lea    0x4(%edi),%eax
  10075b:	8b 3f                	mov    (%edi),%edi
  10075d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100761:	85 ff                	test   %edi,%edi
  100763:	75 13                	jne    100778 <cprintf+0xe8>
  100765:	e9 96 00 00 00       	jmp    100800 <cprintf+0x170>
  10076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for(; *s; s++)
  100770:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
  100773:	e8 e8 fb ff ff       	call   100360 <consputc>
      for(; *s; s++)
  100778:	0f be 07             	movsbl (%edi),%eax
  10077b:	84 c0                	test   %al,%al
  10077d:	75 f1                	jne    100770 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
  10077f:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  100783:	e9 78 ff ff ff       	jmp    100700 <cprintf+0x70>
  100788:	90                   	nop
  100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
  100790:	b8 25 00 00 00       	mov    $0x25,%eax
  100795:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100799:	e8 c2 fb ff ff       	call   100360 <consputc>
      consputc(c);
  10079e:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1007a2:	89 d0                	mov    %edx,%eax
  1007a4:	e8 b7 fb ff ff       	call   100360 <consputc>
      break;
  1007a9:	e9 52 ff ff ff       	jmp    100700 <cprintf+0x70>
  1007ae:	66 90                	xchg   %ax,%ax
      consputc('%');
  1007b0:	b8 25 00 00 00       	mov    $0x25,%eax
  1007b5:	e8 a6 fb ff ff       	call   100360 <consputc>
  1007ba:	e9 56 ff ff ff       	jmp    100715 <cprintf+0x85>
  1007bf:	90                   	nop
    acquire(&cons.lock);
  1007c0:	83 ec 0c             	sub    $0xc,%esp
  1007c3:	68 a0 a7 10 00       	push   $0x10a7a0
  1007c8:	e8 c3 33 00 00       	call   103b90 <acquire>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1007cd:	8b 74 24 40          	mov    0x40(%esp),%esi
  1007d1:	83 c4 10             	add    $0x10,%esp
  1007d4:	0f b6 06             	movzbl (%esi),%eax
  1007d7:	85 c0                	test   %eax,%eax
  1007d9:	0f 85 d1 fe ff ff    	jne    1006b0 <cprintf+0x20>
    release(&cons.lock);
  1007df:	83 ec 0c             	sub    $0xc,%esp
  1007e2:	68 a0 a7 10 00       	push   $0x10a7a0
  1007e7:	e8 44 35 00 00       	call   103d30 <release>
  1007ec:	83 c4 10             	add    $0x10,%esp
}
  1007ef:	83 c4 1c             	add    $0x1c,%esp
  1007f2:	5b                   	pop    %ebx
  1007f3:	5e                   	pop    %esi
  1007f4:	5f                   	pop    %edi
  1007f5:	5d                   	pop    %ebp
  1007f6:	c3                   	ret    
  1007f7:	89 f6                	mov    %esi,%esi
  1007f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(; *s; s++)
  100800:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
  100805:	bf a6 5d 10 00       	mov    $0x105da6,%edi
  10080a:	e9 61 ff ff ff       	jmp    100770 <cprintf+0xe0>
  10080f:	90                   	nop

00100810 <panic>:
{
  100810:	56                   	push   %esi
  100811:	53                   	push   %ebx
  100812:	83 ec 3c             	sub    $0x3c,%esp
  asm volatile("cli");
  100815:	fa                   	cli    
  cprintf("cpu%d: panic: ", cpu->id);
  100816:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cons.locking = 0;
  10081c:	c7 05 d4 a7 10 00 00 	movl   $0x0,0x10a7d4
  100823:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
  100826:	0f b6 00             	movzbl (%eax),%eax
  100829:	50                   	push   %eax
  10082a:	68 ad 5d 10 00       	push   $0x105dad
  10082f:	e8 5c fe ff ff       	call   100690 <cprintf>
  cprintf(s);
  100834:	58                   	pop    %eax
  100835:	ff 74 24 4c          	pushl  0x4c(%esp)
  100839:	e8 52 fe ff ff       	call   100690 <cprintf>
  cprintf("\n");
  10083e:	c7 04 24 33 62 10 00 	movl   $0x106233,(%esp)
  100845:	e8 46 fe ff ff       	call   100690 <cprintf>
  getcallerpcs(&s, pcs);
  10084a:	5a                   	pop    %edx
  10084b:	59                   	pop    %ecx
  10084c:	8d 5c 24 10          	lea    0x10(%esp),%ebx
  100850:	53                   	push   %ebx
  100851:	8d 44 24 4c          	lea    0x4c(%esp),%eax
  100855:	50                   	push   %eax
  100856:	e8 e5 33 00 00       	call   103c40 <getcallerpcs>
  10085b:	8d 74 24 40          	lea    0x40(%esp),%esi
  10085f:	83 c4 10             	add    $0x10,%esp
  100862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf(" %p", pcs[i]);
  100868:	83 ec 08             	sub    $0x8,%esp
  10086b:	ff 33                	pushl  (%ebx)
  10086d:	83 c3 04             	add    $0x4,%ebx
  100870:	68 bc 5d 10 00       	push   $0x105dbc
  100875:	e8 16 fe ff ff       	call   100690 <cprintf>
  for(i=0; i<10; i++)
  10087a:	83 c4 10             	add    $0x10,%esp
  10087d:	39 f3                	cmp    %esi,%ebx
  10087f:	75 e7                	jne    100868 <panic+0x58>
  panicked = 1; // freeze other CPU
  100881:	c7 05 d8 a7 10 00 01 	movl   $0x1,0x10a7d8
  100888:	00 00 00 
  10088b:	eb fe                	jmp    10088b <panic+0x7b>
  10088d:	8d 76 00             	lea    0x0(%esi),%esi

00100890 <consoleintr>:
{
  100890:	56                   	push   %esi
  100891:	53                   	push   %ebx
  100892:	83 ec 10             	sub    $0x10,%esp
  100895:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&input.lock);
  100899:	68 a0 bf 10 00       	push   $0x10bfa0
  10089e:	e8 ed 32 00 00       	call   103b90 <acquire>
  while((c = getc()) >= 0){
  1008a3:	83 c4 10             	add    $0x10,%esp
  1008a6:	8d 76 00             	lea    0x0(%esi),%esi
  1008a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  1008b0:	ff d3                	call   *%ebx
  1008b2:	85 c0                	test   %eax,%eax
  1008b4:	89 c6                	mov    %eax,%esi
  1008b6:	0f 88 8f 00 00 00    	js     10094b <consoleintr+0xbb>
    switch(c){
  1008bc:	83 fe 10             	cmp    $0x10,%esi
  1008bf:	0f 84 9b 00 00 00    	je     100960 <consoleintr+0xd0>
  1008c5:	83 fe 15             	cmp    $0x15,%esi
  1008c8:	0f 84 d2 00 00 00    	je     1009a0 <consoleintr+0x110>
  1008ce:	83 fe 08             	cmp    $0x8,%esi
  1008d1:	0f 84 99 00 00 00    	je     100970 <consoleintr+0xe0>
      if(c != 0 && input.e-input.r < INPUT_BUF){
  1008d7:	85 f6                	test   %esi,%esi
  1008d9:	74 d5                	je     1008b0 <consoleintr+0x20>
  1008db:	a1 5c c0 10 00       	mov    0x10c05c,%eax
  1008e0:	89 c2                	mov    %eax,%edx
  1008e2:	2b 15 54 c0 10 00    	sub    0x10c054,%edx
  1008e8:	83 fa 7f             	cmp    $0x7f,%edx
  1008eb:	77 c3                	ja     1008b0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
  1008ed:	8d 50 01             	lea    0x1(%eax),%edx
  1008f0:	89 f1                	mov    %esi,%ecx
  1008f2:	83 e0 7f             	and    $0x7f,%eax
  1008f5:	88 88 d4 bf 10 00    	mov    %cl,0x10bfd4(%eax)
        consputc(c);
  1008fb:	89 f0                	mov    %esi,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
  1008fd:	89 15 5c c0 10 00    	mov    %edx,0x10c05c
        consputc(c);
  100903:	e8 58 fa ff ff       	call   100360 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100908:	83 fe 0a             	cmp    $0xa,%esi
  10090b:	0f 84 dd 00 00 00    	je     1009ee <consoleintr+0x15e>
  100911:	83 fe 04             	cmp    $0x4,%esi
  100914:	0f 84 d4 00 00 00    	je     1009ee <consoleintr+0x15e>
  10091a:	a1 54 c0 10 00       	mov    0x10c054,%eax
  10091f:	83 e8 80             	sub    $0xffffff80,%eax
  100922:	39 05 5c c0 10 00    	cmp    %eax,0x10c05c
  100928:	75 86                	jne    1008b0 <consoleintr+0x20>
          wakeup(&input.r);
  10092a:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
  10092d:	a3 58 c0 10 00       	mov    %eax,0x10c058
          wakeup(&input.r);
  100932:	68 54 c0 10 00       	push   $0x10c054
  100937:	e8 14 2f 00 00       	call   103850 <wakeup>
  10093c:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
  10093f:	ff d3                	call   *%ebx
  100941:	85 c0                	test   %eax,%eax
  100943:	89 c6                	mov    %eax,%esi
  100945:	0f 89 71 ff ff ff    	jns    1008bc <consoleintr+0x2c>
  release(&input.lock);
  10094b:	c7 44 24 10 a0 bf 10 	movl   $0x10bfa0,0x10(%esp)
  100952:	00 
}
  100953:	83 c4 04             	add    $0x4,%esp
  100956:	5b                   	pop    %ebx
  100957:	5e                   	pop    %esi
  release(&input.lock);
  100958:	e9 d3 33 00 00       	jmp    103d30 <release>
  10095d:	8d 76 00             	lea    0x0(%esi),%esi
      procdump();
  100960:	e8 9b 27 00 00       	call   103100 <procdump>
      break;
  100965:	e9 46 ff ff ff       	jmp    1008b0 <consoleintr+0x20>
  10096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(input.e != input.w){
  100970:	a1 5c c0 10 00       	mov    0x10c05c,%eax
  100975:	3b 05 58 c0 10 00    	cmp    0x10c058,%eax
  10097b:	0f 84 2f ff ff ff    	je     1008b0 <consoleintr+0x20>
        input.e--;
  100981:	83 e8 01             	sub    $0x1,%eax
  100984:	a3 5c c0 10 00       	mov    %eax,0x10c05c
        consputc(BACKSPACE);
  100989:	b8 00 01 00 00       	mov    $0x100,%eax
  10098e:	e8 cd f9 ff ff       	call   100360 <consputc>
  100993:	e9 18 ff ff ff       	jmp    1008b0 <consoleintr+0x20>
  100998:	90                   	nop
  100999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
  1009a0:	a1 5c c0 10 00       	mov    0x10c05c,%eax
  1009a5:	39 05 58 c0 10 00    	cmp    %eax,0x10c058
  1009ab:	75 2b                	jne    1009d8 <consoleintr+0x148>
  1009ad:	e9 fe fe ff ff       	jmp    1008b0 <consoleintr+0x20>
  1009b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
  1009b8:	a3 5c c0 10 00       	mov    %eax,0x10c05c
        consputc(BACKSPACE);
  1009bd:	b8 00 01 00 00       	mov    $0x100,%eax
  1009c2:	e8 99 f9 ff ff       	call   100360 <consputc>
      while(input.e != input.w &&
  1009c7:	a1 5c c0 10 00       	mov    0x10c05c,%eax
  1009cc:	3b 05 58 c0 10 00    	cmp    0x10c058,%eax
  1009d2:	0f 84 d8 fe ff ff    	je     1008b0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  1009d8:	83 e8 01             	sub    $0x1,%eax
  1009db:	89 c2                	mov    %eax,%edx
  1009dd:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
  1009e0:	80 ba d4 bf 10 00 0a 	cmpb   $0xa,0x10bfd4(%edx)
  1009e7:	75 cf                	jne    1009b8 <consoleintr+0x128>
  1009e9:	e9 c2 fe ff ff       	jmp    1008b0 <consoleintr+0x20>
  1009ee:	a1 5c c0 10 00       	mov    0x10c05c,%eax
  1009f3:	e9 32 ff ff ff       	jmp    10092a <consoleintr+0x9a>
  1009f8:	90                   	nop
  1009f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100a00 <consoleinit>:

void
consoleinit(void)
{
  100a00:	83 ec 14             	sub    $0x14,%esp
  initlock(&cons.lock, "console");
  100a03:	68 c0 5d 10 00       	push   $0x105dc0
  100a08:	68 a0 a7 10 00       	push   $0x10a7a0
  100a0d:	e8 5e 31 00 00       	call   103b70 <initlock>
  initlock(&input.lock, "input");
  100a12:	58                   	pop    %eax
  100a13:	5a                   	pop    %edx
  100a14:	68 c8 5d 10 00       	push   $0x105dc8
  100a19:	68 a0 bf 10 00       	push   $0x10bfa0
  100a1e:	e8 4d 31 00 00       	call   103b70 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  100a23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
  100a2a:	c7 05 0c ca 10 00 20 	movl   $0x100520,0x10ca0c
  100a31:	05 10 00 
  devsw[CONSOLE].read = consoleread;
  100a34:	c7 05 08 ca 10 00 80 	movl   $0x100580,0x10ca08
  100a3b:	05 10 00 
  cons.locking = 1;
  100a3e:	c7 05 d4 a7 10 00 01 	movl   $0x1,0x10a7d4
  100a45:	00 00 00 
  picenable(IRQ_KBD);
  100a48:	e8 23 21 00 00       	call   102b70 <picenable>
  ioapicenable(IRQ_KBD, 0);
  100a4d:	59                   	pop    %ecx
  100a4e:	58                   	pop    %eax
  100a4f:	6a 00                	push   $0x0
  100a51:	6a 01                	push   $0x1
  100a53:	e8 98 18 00 00       	call   1022f0 <ioapicenable>
}
  100a58:	83 c4 1c             	add    $0x1c,%esp
  100a5b:	c3                   	ret    
  100a5c:	66 90                	xchg   %ax,%ax
  100a5e:	66 90                	xchg   %ax,%ax

00100a60 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  100a60:	55                   	push   %ebp
  100a61:	57                   	push   %edi
  100a62:	56                   	push   %esi
  100a63:	53                   	push   %ebx
  100a64:	81 ec 98 00 00 00    	sub    $0x98,%esp
  struct proghdr ph;

  mem = 0;
  sz = 0;

  if((ip = namei(path)) == 0)
  100a6a:	ff b4 24 ac 00 00 00 	pushl  0xac(%esp)
  100a71:	e8 7a 14 00 00       	call   101ef0 <namei>
  100a76:	83 c4 10             	add    $0x10,%esp
  100a79:	85 c0                	test   %eax,%eax
  100a7b:	0f 84 b5 03 00 00    	je     100e36 <exec+0x3d6>
    return -1;
  ilock(ip);
  100a81:	83 ec 0c             	sub    $0xc,%esp
  100a84:	89 c3                	mov    %eax,%ebx
  100a86:	50                   	push   %eax
  100a87:	e8 94 0b 00 00       	call   101620 <ilock>

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  100a8c:	6a 34                	push   $0x34
  100a8e:	6a 00                	push   $0x0
  100a90:	8d 44 24 64          	lea    0x64(%esp),%eax
  100a94:	50                   	push   %eax
  100a95:	53                   	push   %ebx
  100a96:	e8 95 0e 00 00       	call   101930 <readi>
  100a9b:	83 c4 20             	add    $0x20,%esp
  100a9e:	83 f8 33             	cmp    $0x33,%eax
  100aa1:	0f 86 44 03 00 00    	jbe    100deb <exec+0x38b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  100aa7:	81 7c 24 4c 7f 45 4c 	cmpl   $0x464c457f,0x4c(%esp)
  100aae:	46 
  100aaf:	0f 85 36 03 00 00    	jne    100deb <exec+0x38b>
    goto bad;

  // Compute memory size of new process.
  // Program segments.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100ab5:	66 83 7c 24 78 00    	cmpw   $0x0,0x78(%esp)
  100abb:	8b 6c 24 68          	mov    0x68(%esp),%ebp
  100abf:	0f 84 67 03 00 00    	je     100e2c <exec+0x3cc>
  100ac5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100acc:	00 
  100acd:	31 ff                	xor    %edi,%edi
  100acf:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  100ad3:	eb 12                	jmp    100ae7 <exec+0x87>
  100ad5:	8d 76 00             	lea    0x0(%esi),%esi
  100ad8:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100add:	83 c7 01             	add    $0x1,%edi
  100ae0:	83 c5 20             	add    $0x20,%ebp
  100ae3:	39 f8                	cmp    %edi,%eax
  100ae5:	7e 3e                	jle    100b25 <exec+0xc5>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100ae7:	6a 20                	push   $0x20
  100ae9:	55                   	push   %ebp
  100aea:	56                   	push   %esi
  100aeb:	53                   	push   %ebx
  100aec:	e8 3f 0e 00 00       	call   101930 <readi>
  100af1:	83 c4 10             	add    $0x10,%esp
  100af4:	83 f8 20             	cmp    $0x20,%eax
  100af7:	0f 85 ee 02 00 00    	jne    100deb <exec+0x38b>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100afd:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
  100b02:	75 d4                	jne    100ad8 <exec+0x78>
      continue;
    if(ph.memsz < ph.filesz)
  100b04:	8b 44 24 40          	mov    0x40(%esp),%eax
  100b08:	3b 44 24 3c          	cmp    0x3c(%esp),%eax
  100b0c:	0f 82 d9 02 00 00    	jb     100deb <exec+0x38b>
      goto bad;
    sz += ph.memsz;
  100b12:	01 44 24 08          	add    %eax,0x8(%esp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100b16:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100b1b:	83 c7 01             	add    $0x1,%edi
  100b1e:	83 c5 20             	add    $0x20,%ebp
  100b21:	39 f8                	cmp    %edi,%eax
  100b23:	7f c2                	jg     100ae7 <exec+0x87>
  100b25:	8b 74 24 08          	mov    0x8(%esp),%esi
  100b29:	81 c6 07 20 00 00    	add    $0x2007,%esi
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b2f:	8b 84 24 a4 00 00 00 	mov    0xa4(%esp),%eax
  100b36:	8b 00                	mov    (%eax),%eax
  100b38:	85 c0                	test   %eax,%eax
  100b3a:	0f 84 c7 02 00 00    	je     100e07 <exec+0x3a7>
  100b40:	89 74 24 08          	mov    %esi,0x8(%esp)
  100b44:	31 ff                	xor    %edi,%edi
  100b46:	31 ed                	xor    %ebp,%ebp
  100b48:	8b b4 24 a4 00 00 00 	mov    0xa4(%esp),%esi
  100b4f:	eb 09                	jmp    100b5a <exec+0xfa>
  100b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100b58:	89 d5                	mov    %edx,%ebp
    arglen += strlen(argv[argc]) + 1;
  100b5a:	83 ec 0c             	sub    $0xc,%esp
  100b5d:	50                   	push   %eax
  100b5e:	e8 fd 33 00 00       	call   103f60 <strlen>
  for(argc=0; argv[argc]; argc++)
  100b63:	8d 55 01             	lea    0x1(%ebp),%edx
    arglen += strlen(argv[argc]) + 1;
  100b66:	8d 7c 38 01          	lea    0x1(%eax,%edi,1),%edi
  for(argc=0; argv[argc]; argc++)
  100b6a:	83 c4 10             	add    $0x10,%esp
  100b6d:	8b 04 96             	mov    (%esi,%edx,4),%eax
  100b70:	85 c0                	test   %eax,%eax
  100b72:	75 e4                	jne    100b58 <exec+0xf8>
  100b74:	83 c7 03             	add    $0x3,%edi
  100b77:	8d 04 ad 08 00 00 00 	lea    0x8(,%ebp,4),%eax
  100b7e:	8b 74 24 08          	mov    0x8(%esp),%esi
  100b82:	83 e7 fc             	and    $0xfffffffc,%edi
  100b85:	89 54 24 18          	mov    %edx,0x18(%esp)
  100b89:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  100b8d:	89 7c 24 10          	mov    %edi,0x10(%esp)
  100b91:	89 44 24 14          	mov    %eax,0x14(%esp)

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100b95:	8b 44 24 10          	mov    0x10(%esp),%eax
  100b99:	03 44 24 14          	add    0x14(%esp),%eax
  mem = kalloc(sz);
  100b9d:	83 ec 0c             	sub    $0xc,%esp
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100ba0:	01 c6                	add    %eax,%esi
  100ba2:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  100ba8:	89 74 24 18          	mov    %esi,0x18(%esp)
  mem = kalloc(sz);
  100bac:	56                   	push   %esi
  100bad:	e8 ce 18 00 00       	call   102480 <kalloc>
  100bb2:	89 44 24 18          	mov    %eax,0x18(%esp)
  if(mem == 0)
  100bb6:	83 c4 10             	add    $0x10,%esp
  100bb9:	85 c0                	test   %eax,%eax
  100bbb:	0f 84 2a 02 00 00    	je     100deb <exec+0x38b>
    goto bad;
  memset(mem, 0, sz);
  100bc1:	83 ec 04             	sub    $0x4,%esp
  100bc4:	56                   	push   %esi
  100bc5:	6a 00                	push   $0x0
  100bc7:	50                   	push   %eax
  100bc8:	e8 b3 31 00 00       	call   103d80 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100bcd:	8b 7c 24 78          	mov    0x78(%esp),%edi
  100bd1:	83 c4 10             	add    $0x10,%esp
  100bd4:	66 83 7c 24 78 00    	cmpw   $0x0,0x78(%esp)
  100bda:	0f 84 b5 00 00 00    	je     100c95 <exec+0x235>
  100be0:	31 ed                	xor    %ebp,%ebp
  100be2:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  100be6:	eb 1b                	jmp    100c03 <exec+0x1a3>
  100be8:	90                   	nop
  100be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100bf0:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100bf5:	83 c5 01             	add    $0x1,%ebp
  100bf8:	83 c7 20             	add    $0x20,%edi
  100bfb:	39 e8                	cmp    %ebp,%eax
  100bfd:	0f 8e 92 00 00 00    	jle    100c95 <exec+0x235>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100c03:	6a 20                	push   $0x20
  100c05:	57                   	push   %edi
  100c06:	56                   	push   %esi
  100c07:	53                   	push   %ebx
  100c08:	e8 23 0d 00 00       	call   101930 <readi>
  100c0d:	83 c4 10             	add    $0x10,%esp
  100c10:	83 f8 20             	cmp    $0x20,%eax
  100c13:	0f 85 bf 01 00 00    	jne    100dd8 <exec+0x378>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100c19:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
  100c1e:	75 d0                	jne    100bf0 <exec+0x190>
      continue;
    if(ph.va + ph.memsz < ph.va || ph.va + ph.memsz > sz)
  100c20:	8b 44 24 34          	mov    0x34(%esp),%eax
  100c24:	8b 54 24 40          	mov    0x40(%esp),%edx
  100c28:	89 c1                	mov    %eax,%ecx
  100c2a:	01 d1                	add    %edx,%ecx
  100c2c:	0f 82 a6 01 00 00    	jb     100dd8 <exec+0x378>
  100c32:	39 4c 24 0c          	cmp    %ecx,0xc(%esp)
  100c36:	0f 82 9c 01 00 00    	jb     100dd8 <exec+0x378>
      goto bad;
    if(ph.memsz < ph.filesz)
  100c3c:	8b 4c 24 3c          	mov    0x3c(%esp),%ecx
  100c40:	39 ca                	cmp    %ecx,%edx
  100c42:	0f 82 90 01 00 00    	jb     100dd8 <exec+0x378>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  100c48:	51                   	push   %ecx
  100c49:	ff 74 24 34          	pushl  0x34(%esp)
  100c4d:	03 44 24 10          	add    0x10(%esp),%eax
  100c51:	50                   	push   %eax
  100c52:	53                   	push   %ebx
  100c53:	e8 d8 0c 00 00       	call   101930 <readi>
  100c58:	83 c4 10             	add    $0x10,%esp
  100c5b:	3b 44 24 3c          	cmp    0x3c(%esp),%eax
  100c5f:	0f 85 73 01 00 00    	jne    100dd8 <exec+0x378>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100c65:	83 ec 04             	sub    $0x4,%esp
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100c68:	83 c5 01             	add    $0x1,%ebp
  100c6b:	83 c7 20             	add    $0x20,%edi
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100c6e:	8b 4c 24 44          	mov    0x44(%esp),%ecx
  100c72:	29 c1                	sub    %eax,%ecx
  100c74:	51                   	push   %ecx
  100c75:	6a 00                	push   $0x0
  100c77:	03 44 24 40          	add    0x40(%esp),%eax
  100c7b:	03 44 24 14          	add    0x14(%esp),%eax
  100c7f:	50                   	push   %eax
  100c80:	e8 fb 30 00 00       	call   103d80 <memset>
  100c85:	83 c4 10             	add    $0x10,%esp
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100c88:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100c8d:	39 e8                	cmp    %ebp,%eax
  100c8f:	0f 8f 6e ff ff ff    	jg     100c03 <exec+0x1a3>
  }
  iunlockput(ip);
  100c95:	83 ec 0c             	sub    $0xc,%esp
  100c98:	53                   	push   %ebx
  100c99:	e8 42 0c 00 00       	call   1018e0 <iunlockput>
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c9e:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100ca2:	8b 4c 24 28          	mov    0x28(%esp),%ecx
  100ca6:	8b 54 24 18          	mov    0x18(%esp),%edx
  argp = sz - arglen - 4*(argc+1);
  100caa:	89 df                	mov    %ebx,%edi
  100cac:	2b 7c 24 20          	sub    0x20(%esp),%edi
  for(i=argc-1; i>=0; i--){
  100cb0:	8d 69 ff             	lea    -0x1(%ecx),%ebp
  argp = sz - arglen - 4*(argc+1);
  100cb3:	2b 7c 24 24          	sub    0x24(%esp),%edi
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100cb7:	8d 04 8a             	lea    (%edx,%ecx,4),%eax
  for(i=argc-1; i>=0; i--){
  100cba:	83 c4 10             	add    $0x10,%esp
  100cbd:	83 fd ff             	cmp    $0xffffffff,%ebp
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100cc0:	c7 04 38 00 00 00 00 	movl   $0x0,(%eax,%edi,1)
  100cc7:	8d 34 3a             	lea    (%edx,%edi,1),%esi
  for(i=argc-1; i>=0; i--){
  100cca:	74 4a                	je     100d16 <exec+0x2b6>
  100ccc:	89 7c 24 10          	mov    %edi,0x10(%esp)
  100cd0:	8b bc 24 a4 00 00 00 	mov    0xa4(%esp),%edi
  100cd7:	89 f0                	mov    %esi,%eax
  100cd9:	89 ee                	mov    %ebp,%esi
  100cdb:	89 c5                	mov    %eax,%ebp
  100cdd:	8d 76 00             	lea    0x0(%esi),%esi
    len = strlen(argv[i]) + 1;
  100ce0:	83 ec 0c             	sub    $0xc,%esp
  100ce3:	ff 34 b7             	pushl  (%edi,%esi,4)
  100ce6:	e8 75 32 00 00       	call   103f60 <strlen>
    sp -= len;
    memmove(mem+sp, argv[i], len);
  100ceb:	83 c4 0c             	add    $0xc,%esp
    len = strlen(argv[i]) + 1;
  100cee:	83 c0 01             	add    $0x1,%eax
    memmove(mem+sp, argv[i], len);
  100cf1:	50                   	push   %eax
    sp -= len;
  100cf2:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp, argv[i], len);
  100cf4:	ff 34 b7             	pushl  (%edi,%esi,4)
  100cf7:	8b 44 24 14          	mov    0x14(%esp),%eax
  100cfb:	01 d8                	add    %ebx,%eax
  100cfd:	50                   	push   %eax
  100cfe:	e8 fd 30 00 00       	call   103e00 <memmove>
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  100d03:	89 5c b5 00          	mov    %ebx,0x0(%ebp,%esi,4)
  for(i=argc-1; i>=0; i--){
  100d07:	83 ee 01             	sub    $0x1,%esi
  100d0a:	83 c4 10             	add    $0x10,%esp
  100d0d:	83 fe ff             	cmp    $0xffffffff,%esi
  100d10:	75 ce                	jne    100ce0 <exec+0x280>
  100d12:	8b 7c 24 10          	mov    0x10(%esp),%edi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100d16:	8b 44 24 08          	mov    0x8(%esp),%eax
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100d1a:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  sp -= 4;
  100d1e:	8d 5f f4             	lea    -0xc(%edi),%ebx
  100d21:	8b 8c 24 a0 00 00 00 	mov    0xa0(%esp),%ecx
  *(uint*)(mem+sp) = argp;
  100d28:	89 7c 38 fc          	mov    %edi,-0x4(%eax,%edi,1)
  *(uint*)(mem+sp) = argc;
  100d2c:	89 54 38 f8          	mov    %edx,-0x8(%eax,%edi,1)
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  100d30:	c7 44 38 f4 ff ff ff 	movl   $0xffffffff,-0xc(%eax,%edi,1)
  100d37:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100d38:	8b 84 24 a0 00 00 00 	mov    0xa0(%esp),%eax
  100d3f:	0f b6 10             	movzbl (%eax),%edx
  100d42:	83 c0 01             	add    $0x1,%eax
  100d45:	84 d2                	test   %dl,%dl
  100d47:	74 1e                	je     100d67 <exec+0x307>
  100d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(*s == '/')
      last = s+1;
  100d50:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
  100d53:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
  100d56:	0f 44 c8             	cmove  %eax,%ecx
  100d59:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
  100d5c:	84 d2                	test   %dl,%dl
  100d5e:	75 f0                	jne    100d50 <exec+0x2f0>
  100d60:	89 8c 24 a0 00 00 00 	mov    %ecx,0xa0(%esp)
  safestrcpy(proc->name, last, sizeof(proc->name));
  100d67:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100d6d:	83 ec 04             	sub    $0x4,%esp
  100d70:	6a 10                	push   $0x10
  100d72:	ff b4 24 a8 00 00 00 	pushl  0xa8(%esp)
  100d79:	83 c0 6c             	add    $0x6c,%eax
  100d7c:	50                   	push   %eax
  100d7d:	e8 9e 31 00 00       	call   103f20 <safestrcpy>

  // Commit to the new image.
  kfree(proc->mem, proc->sz);
  100d82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100d88:	5a                   	pop    %edx
  100d89:	59                   	pop    %ecx
  100d8a:	ff 70 04             	pushl  0x4(%eax)
  100d8d:	ff 30                	pushl  (%eax)
  100d8f:	e8 9c 15 00 00       	call   102330 <kfree>
  proc->mem = mem;
  100d94:	8b 54 24 18          	mov    0x18(%esp),%edx
  100d98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100d9e:	89 10                	mov    %edx,(%eax)
  proc->sz = sz;
  100da0:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  100da4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  100daa:	89 50 04             	mov    %edx,0x4(%eax)
  proc->tf->eip = elf.entry;  // main
  100dad:	8b 50 18             	mov    0x18(%eax),%edx
  100db0:	8b 4c 24 74          	mov    0x74(%esp),%ecx
  100db4:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
  100db7:	8b 40 18             	mov    0x18(%eax),%eax
  100dba:	89 58 44             	mov    %ebx,0x44(%eax)
  usegment();
  100dbd:	e8 fe 24 00 00       	call   1032c0 <usegment>
  return 0;
  100dc2:	83 c4 10             	add    $0x10,%esp
  100dc5:	31 c0                	xor    %eax,%eax
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  100dc7:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  100dcd:	5b                   	pop    %ebx
  100dce:	5e                   	pop    %esi
  100dcf:	5f                   	pop    %edi
  100dd0:	5d                   	pop    %ebp
  100dd1:	c3                   	ret    
  100dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kfree(mem, sz);
  100dd8:	83 ec 08             	sub    $0x8,%esp
  100ddb:	ff 74 24 14          	pushl  0x14(%esp)
  100ddf:	ff 74 24 14          	pushl  0x14(%esp)
  100de3:	e8 48 15 00 00       	call   102330 <kfree>
  100de8:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
  100deb:	83 ec 0c             	sub    $0xc,%esp
  100dee:	53                   	push   %ebx
  100def:	e8 ec 0a 00 00       	call   1018e0 <iunlockput>
  return -1;
  100df4:	83 c4 10             	add    $0x10,%esp
  100df7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100dfc:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  100e02:	5b                   	pop    %ebx
  100e03:	5e                   	pop    %esi
  100e04:	5f                   	pop    %edi
  100e05:	5d                   	pop    %ebp
  100e06:	c3                   	ret    
  for(argc=0; argv[argc]; argc++)
  100e07:	c7 44 24 14 04 00 00 	movl   $0x4,0x14(%esp)
  100e0e:	00 
  100e0f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100e16:	00 
  100e17:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  100e1e:	00 
  100e1f:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  100e26:	00 
  100e27:	e9 69 fd ff ff       	jmp    100b95 <exec+0x135>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100e2c:	be 07 20 00 00       	mov    $0x2007,%esi
  100e31:	e9 f9 fc ff ff       	jmp    100b2f <exec+0xcf>
    return -1;
  100e36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e3b:	eb bf                	jmp    100dfc <exec+0x39c>
  100e3d:	66 90                	xchg   %ax,%ax
  100e3f:	90                   	nop

00100e40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  100e40:	83 ec 14             	sub    $0x14,%esp
  initlock(&ftable.lock, "ftable");
  100e43:	68 e1 5d 10 00       	push   $0x105de1
  100e48:	68 60 c0 10 00       	push   $0x10c060
  100e4d:	e8 1e 2d 00 00       	call   103b70 <initlock>
}
  100e52:	83 c4 1c             	add    $0x1c,%esp
  100e55:	c3                   	ret    
  100e56:	8d 76 00             	lea    0x0(%esi),%esi
  100e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e60:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100e61:	bb 94 c0 10 00       	mov    $0x10c094,%ebx
{
  100e66:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
  100e69:	68 60 c0 10 00       	push   $0x10c060
  100e6e:	e8 1d 2d 00 00       	call   103b90 <acquire>
  100e73:	83 c4 10             	add    $0x10,%esp
  100e76:	eb 13                	jmp    100e8b <filealloc+0x2b>
  100e78:	90                   	nop
  100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100e80:	83 c3 18             	add    $0x18,%ebx
  100e83:	81 fb f4 c9 10 00    	cmp    $0x10c9f4,%ebx
  100e89:	73 25                	jae    100eb0 <filealloc+0x50>
    if(f->ref == 0){
  100e8b:	8b 43 04             	mov    0x4(%ebx),%eax
  100e8e:	85 c0                	test   %eax,%eax
  100e90:	75 ee                	jne    100e80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
  100e92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
  100e95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
  100e9c:	68 60 c0 10 00       	push   $0x10c060
  100ea1:	e8 8a 2e 00 00       	call   103d30 <release>
      return f;
  100ea6:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
  100ea9:	89 d8                	mov    %ebx,%eax
  100eab:	83 c4 08             	add    $0x8,%esp
  100eae:	5b                   	pop    %ebx
  100eaf:	c3                   	ret    
  release(&ftable.lock);
  100eb0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
  100eb3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
  100eb5:	68 60 c0 10 00       	push   $0x10c060
  100eba:	e8 71 2e 00 00       	call   103d30 <release>
  return 0;
  100ebf:	83 c4 10             	add    $0x10,%esp
}
  100ec2:	89 d8                	mov    %ebx,%eax
  100ec4:	83 c4 08             	add    $0x8,%esp
  100ec7:	5b                   	pop    %ebx
  100ec8:	c3                   	ret    
  100ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100ed0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100ed0:	53                   	push   %ebx
  100ed1:	83 ec 14             	sub    $0x14,%esp
  100ed4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&ftable.lock);
  100ed8:	68 60 c0 10 00       	push   $0x10c060
  100edd:	e8 ae 2c 00 00       	call   103b90 <acquire>
  if(f->ref < 1)
  100ee2:	8b 43 04             	mov    0x4(%ebx),%eax
  100ee5:	83 c4 10             	add    $0x10,%esp
  100ee8:	85 c0                	test   %eax,%eax
  100eea:	7e 1a                	jle    100f06 <filedup+0x36>
    panic("filedup");
  f->ref++;
  100eec:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
  100eef:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
  100ef2:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
  100ef5:	68 60 c0 10 00       	push   $0x10c060
  100efa:	e8 31 2e 00 00       	call   103d30 <release>
  return f;
}
  100eff:	83 c4 18             	add    $0x18,%esp
  100f02:	89 d8                	mov    %ebx,%eax
  100f04:	5b                   	pop    %ebx
  100f05:	c3                   	ret    
    panic("filedup");
  100f06:	83 ec 0c             	sub    $0xc,%esp
  100f09:	68 e8 5d 10 00       	push   $0x105de8
  100f0e:	e8 fd f8 ff ff       	call   100810 <panic>
  100f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f20 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100f20:	55                   	push   %ebp
  100f21:	57                   	push   %edi
  100f22:	56                   	push   %esi
  100f23:	53                   	push   %ebx
  100f24:	83 ec 28             	sub    $0x28,%esp
  100f27:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  struct file ff;

  acquire(&ftable.lock);
  100f2b:	68 60 c0 10 00       	push   $0x10c060
  100f30:	e8 5b 2c 00 00       	call   103b90 <acquire>
  if(f->ref < 1)
  100f35:	8b 43 04             	mov    0x4(%ebx),%eax
  100f38:	83 c4 10             	add    $0x10,%esp
  100f3b:	85 c0                	test   %eax,%eax
  100f3d:	0f 8e 85 00 00 00    	jle    100fc8 <fileclose+0xa8>
    panic("fileclose");
  if(--f->ref > 0){
  100f43:	83 e8 01             	sub    $0x1,%eax
  100f46:	85 c0                	test   %eax,%eax
  100f48:	89 43 04             	mov    %eax,0x4(%ebx)
  100f4b:	74 1b                	je     100f68 <fileclose+0x48>
    release(&ftable.lock);
  100f4d:	c7 44 24 30 60 c0 10 	movl   $0x10c060,0x30(%esp)
  100f54:	00 
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
}
  100f55:	83 c4 1c             	add    $0x1c,%esp
  100f58:	5b                   	pop    %ebx
  100f59:	5e                   	pop    %esi
  100f5a:	5f                   	pop    %edi
  100f5b:	5d                   	pop    %ebp
    release(&ftable.lock);
  100f5c:	e9 cf 2d 00 00       	jmp    103d30 <release>
  100f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
  100f68:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  100f6c:	8b 33                	mov    (%ebx),%esi
  release(&ftable.lock);
  100f6e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
  100f71:	8b 7b 0c             	mov    0xc(%ebx),%edi
  100f74:	8b 6b 10             	mov    0x10(%ebx),%ebp
  f->type = FD_NONE;
  100f77:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
  100f7d:	88 44 24 1b          	mov    %al,0x1b(%esp)
  release(&ftable.lock);
  100f81:	68 60 c0 10 00       	push   $0x10c060
  100f86:	e8 a5 2d 00 00       	call   103d30 <release>
  if(ff.type == FD_PIPE)
  100f8b:	83 c4 10             	add    $0x10,%esp
  100f8e:	83 fe 01             	cmp    $0x1,%esi
  100f91:	74 0d                	je     100fa0 <fileclose+0x80>
  else if(ff.type == FD_INODE)
  100f93:	83 fe 02             	cmp    $0x2,%esi
  100f96:	74 20                	je     100fb8 <fileclose+0x98>
}
  100f98:	83 c4 1c             	add    $0x1c,%esp
  100f9b:	5b                   	pop    %ebx
  100f9c:	5e                   	pop    %esi
  100f9d:	5f                   	pop    %edi
  100f9e:	5d                   	pop    %ebp
  100f9f:	c3                   	ret    
    pipeclose(ff.pipe, ff.writable);
  100fa0:	83 ec 08             	sub    $0x8,%esp
  100fa3:	0f be 74 24 17       	movsbl 0x17(%esp),%esi
  100fa8:	56                   	push   %esi
  100fa9:	57                   	push   %edi
  100faa:	e8 91 1d 00 00       	call   102d40 <pipeclose>
  100faf:	83 c4 10             	add    $0x10,%esp
  100fb2:	eb e4                	jmp    100f98 <fileclose+0x78>
  100fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iput(ff.ip);
  100fb8:	89 6c 24 30          	mov    %ebp,0x30(%esp)
}
  100fbc:	83 c4 1c             	add    $0x1c,%esp
  100fbf:	5b                   	pop    %ebx
  100fc0:	5e                   	pop    %esi
  100fc1:	5f                   	pop    %edi
  100fc2:	5d                   	pop    %ebp
    iput(ff.ip);
  100fc3:	e9 b8 07 00 00       	jmp    101780 <iput>
    panic("fileclose");
  100fc8:	83 ec 0c             	sub    $0xc,%esp
  100fcb:	68 f0 5d 10 00       	push   $0x105df0
  100fd0:	e8 3b f8 ff ff       	call   100810 <panic>
  100fd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100fe0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat_new *st)
{
  100fe0:	53                   	push   %ebx
  100fe1:	83 ec 08             	sub    $0x8,%esp
  100fe4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(f->type == FD_INODE){
  100fe8:	83 3b 02             	cmpl   $0x2,(%ebx)
  100feb:	75 33                	jne    101020 <filestat+0x40>
    ilock(f->ip);
  100fed:	83 ec 0c             	sub    $0xc,%esp
  100ff0:	ff 73 10             	pushl  0x10(%ebx)
  100ff3:	e8 28 06 00 00       	call   101620 <ilock>
    stati(f->ip, st);
  100ff8:	58                   	pop    %eax
  100ff9:	5a                   	pop    %edx
  100ffa:	ff 74 24 1c          	pushl  0x1c(%esp)
  100ffe:	ff 73 10             	pushl  0x10(%ebx)
  101001:	e8 fa 08 00 00       	call   101900 <stati>
    iunlock(f->ip);
  101006:	59                   	pop    %ecx
  101007:	ff 73 10             	pushl  0x10(%ebx)
  10100a:	e8 21 07 00 00       	call   101730 <iunlock>
    return 0;
  10100f:	83 c4 10             	add    $0x10,%esp
  101012:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
  101014:	83 c4 08             	add    $0x8,%esp
  101017:	5b                   	pop    %ebx
  101018:	c3                   	ret    
  101019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101020:	83 c4 08             	add    $0x8,%esp
  return -1;
  101023:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101028:	5b                   	pop    %ebx
  101029:	c3                   	ret    
  10102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101030 <fileread>:

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  101030:	57                   	push   %edi
  101031:	56                   	push   %esi
  101032:	53                   	push   %ebx
  101033:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  101037:	8b 74 24 14          	mov    0x14(%esp),%esi
  10103b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->readable == 0)
  10103f:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  101043:	74 5b                	je     1010a0 <fileread+0x70>
    return -1;
  if(f->type == FD_PIPE)
  101045:	8b 03                	mov    (%ebx),%eax
  101047:	83 f8 01             	cmp    $0x1,%eax
  10104a:	74 44                	je     101090 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  10104c:	83 f8 02             	cmp    $0x2,%eax
  10104f:	75 56                	jne    1010a7 <fileread+0x77>
    ilock(f->ip);
  101051:	83 ec 0c             	sub    $0xc,%esp
  101054:	ff 73 10             	pushl  0x10(%ebx)
  101057:	e8 c4 05 00 00       	call   101620 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  10105c:	57                   	push   %edi
  10105d:	ff 73 14             	pushl  0x14(%ebx)
  101060:	56                   	push   %esi
  101061:	ff 73 10             	pushl  0x10(%ebx)
  101064:	e8 c7 08 00 00       	call   101930 <readi>
  101069:	83 c4 20             	add    $0x20,%esp
  10106c:	85 c0                	test   %eax,%eax
  10106e:	89 c6                	mov    %eax,%esi
  101070:	7e 03                	jle    101075 <fileread+0x45>
      f->off += r;
  101072:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  101075:	83 ec 0c             	sub    $0xc,%esp
  101078:	ff 73 10             	pushl  0x10(%ebx)
  10107b:	e8 b0 06 00 00       	call   101730 <iunlock>
    return r;
  101080:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
  101083:	89 f0                	mov    %esi,%eax
  101085:	5b                   	pop    %ebx
  101086:	5e                   	pop    %esi
  101087:	5f                   	pop    %edi
  101088:	c3                   	ret    
  101089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
  101090:	8b 43 0c             	mov    0xc(%ebx),%eax
  101093:	89 44 24 10          	mov    %eax,0x10(%esp)
}
  101097:	5b                   	pop    %ebx
  101098:	5e                   	pop    %esi
  101099:	5f                   	pop    %edi
    return piperead(f->pipe, addr, n);
  10109a:	e9 41 1e 00 00       	jmp    102ee0 <piperead>
  10109f:	90                   	nop
    return -1;
  1010a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
  1010a5:	eb dc                	jmp    101083 <fileread+0x53>
  panic("fileread");
  1010a7:	83 ec 0c             	sub    $0xc,%esp
  1010aa:	68 fa 5d 10 00       	push   $0x105dfa
  1010af:	e8 5c f7 ff ff       	call   100810 <panic>
  1010b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1010ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001010c0 <filewrite>:

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  1010c0:	57                   	push   %edi
  1010c1:	56                   	push   %esi
  1010c2:	53                   	push   %ebx
  1010c3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1010c7:	8b 74 24 14          	mov    0x14(%esp),%esi
  1010cb:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->writable == 0)
  1010cf:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  1010d3:	74 5b                	je     101130 <filewrite+0x70>
    return -1;
  if(f->type == FD_PIPE)
  1010d5:	8b 03                	mov    (%ebx),%eax
  1010d7:	83 f8 01             	cmp    $0x1,%eax
  1010da:	74 44                	je     101120 <filewrite+0x60>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  1010dc:	83 f8 02             	cmp    $0x2,%eax
  1010df:	75 56                	jne    101137 <filewrite+0x77>
    ilock(f->ip);
  1010e1:	83 ec 0c             	sub    $0xc,%esp
  1010e4:	ff 73 10             	pushl  0x10(%ebx)
  1010e7:	e8 34 05 00 00       	call   101620 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  1010ec:	57                   	push   %edi
  1010ed:	ff 73 14             	pushl  0x14(%ebx)
  1010f0:	56                   	push   %esi
  1010f1:	ff 73 10             	pushl  0x10(%ebx)
  1010f4:	e8 37 09 00 00       	call   101a30 <writei>
  1010f9:	83 c4 20             	add    $0x20,%esp
  1010fc:	85 c0                	test   %eax,%eax
  1010fe:	89 c6                	mov    %eax,%esi
  101100:	7e 03                	jle    101105 <filewrite+0x45>
      f->off += r;
  101102:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  101105:	83 ec 0c             	sub    $0xc,%esp
  101108:	ff 73 10             	pushl  0x10(%ebx)
  10110b:	e8 20 06 00 00       	call   101730 <iunlock>
    return r;
  101110:	83 c4 10             	add    $0x10,%esp
  }
  panic("filewrite");
}
  101113:	89 f0                	mov    %esi,%eax
  101115:	5b                   	pop    %ebx
  101116:	5e                   	pop    %esi
  101117:	5f                   	pop    %edi
  101118:	c3                   	ret    
  101119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return pipewrite(f->pipe, addr, n);
  101120:	8b 43 0c             	mov    0xc(%ebx),%eax
  101123:	89 44 24 10          	mov    %eax,0x10(%esp)
}
  101127:	5b                   	pop    %ebx
  101128:	5e                   	pop    %esi
  101129:	5f                   	pop    %edi
    return pipewrite(f->pipe, addr, n);
  10112a:	e9 b1 1c 00 00       	jmp    102de0 <pipewrite>
  10112f:	90                   	nop
    return -1;
  101130:	be ff ff ff ff       	mov    $0xffffffff,%esi
  101135:	eb dc                	jmp    101113 <filewrite+0x53>
  panic("filewrite");
  101137:	83 ec 0c             	sub    $0xc,%esp
  10113a:	68 03 5e 10 00       	push   $0x105e03
  10113f:	e8 cc f6 ff ff       	call   100810 <panic>
  101144:	66 90                	xchg   %ax,%ax
  101146:	66 90                	xchg   %ax,%ax
  101148:	66 90                	xchg   %ax,%ax
  10114a:	66 90                	xchg   %ax,%ax
  10114c:	66 90                	xchg   %ax,%ax
  10114e:	66 90                	xchg   %ax,%ax

00101150 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  101150:	56                   	push   %esi
  101151:	53                   	push   %ebx
  101152:	89 d6                	mov    %edx,%esi
  101154:	83 ec 0c             	sub    $0xc,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  101157:	6a 01                	push   $0x1
  101159:	50                   	push   %eax
  10115a:	e8 71 f0 ff ff       	call   1001d0 <bread>
  10115f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  101161:	8d 40 18             	lea    0x18(%eax),%eax
  101164:	83 c4 0c             	add    $0xc,%esp
  101167:	6a 0c                	push   $0xc
  101169:	50                   	push   %eax
  10116a:	56                   	push   %esi
  10116b:	e8 90 2c 00 00       	call   103e00 <memmove>
  brelse(bp);
  101170:	89 1c 24             	mov    %ebx,(%esp)
  101173:	e8 68 f1 ff ff       	call   1002e0 <brelse>
}
  101178:	83 c4 14             	add    $0x14,%esp
  10117b:	5b                   	pop    %ebx
  10117c:	5e                   	pop    %esi
  10117d:	c3                   	ret    
  10117e:	66 90                	xchg   %ax,%ax

00101180 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  101180:	57                   	push   %edi
  101181:	56                   	push   %esi
  101182:	89 c6                	mov    %eax,%esi
  101184:	53                   	push   %ebx
  101185:	89 d3                	mov    %edx,%ebx
  101187:	83 ec 18             	sub    $0x18,%esp
  bp = bread(dev, bno);
  10118a:	52                   	push   %edx
  10118b:	50                   	push   %eax
  10118c:	e8 3f f0 ff ff       	call   1001d0 <bread>
  memset(bp->data, 0, BSIZE);
  101191:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
  101194:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  101196:	83 c0 18             	add    $0x18,%eax
  101199:	68 00 02 00 00       	push   $0x200
  10119e:	6a 00                	push   $0x0
  1011a0:	50                   	push   %eax
  1011a1:	e8 da 2b 00 00       	call   103d80 <memset>
  bwrite(bp);
  1011a6:	89 3c 24             	mov    %edi,(%esp)
  1011a9:	e8 02 f1 ff ff       	call   1002b0 <bwrite>
  brelse(bp);
  1011ae:	89 3c 24             	mov    %edi,(%esp)
  1011b1:	e8 2a f1 ff ff       	call   1002e0 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  1011b6:	8d 54 24 14          	lea    0x14(%esp),%edx
  1011ba:	89 f0                	mov    %esi,%eax
  1011bc:	e8 8f ff ff ff       	call   101150 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1011c1:	58                   	pop    %eax
  1011c2:	5a                   	pop    %edx
  1011c3:	8b 44 24 14          	mov    0x14(%esp),%eax
  1011c7:	89 da                	mov    %ebx,%edx
  1011c9:	c1 ea 0c             	shr    $0xc,%edx
  1011cc:	c1 e8 03             	shr    $0x3,%eax
  1011cf:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1011d3:	50                   	push   %eax
  1011d4:	56                   	push   %esi
  1011d5:	e8 f6 ef ff ff       	call   1001d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
  1011da:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
  1011dc:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
  1011df:	ba 01 00 00 00       	mov    $0x1,%edx
  1011e4:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  1011e7:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  1011ed:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
  1011f0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
  1011f2:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
  1011f7:	85 d1                	test   %edx,%ecx
  1011f9:	74 22                	je     10121d <bfree+0x9d>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  1011fb:	f7 d2                	not    %edx
  1011fd:	89 c6                	mov    %eax,%esi
  bwrite(bp);
  1011ff:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  101202:	21 ca                	and    %ecx,%edx
  101204:	88 54 1e 18          	mov    %dl,0x18(%esi,%ebx,1)
  bwrite(bp);
  101208:	56                   	push   %esi
  101209:	e8 a2 f0 ff ff       	call   1002b0 <bwrite>
  brelse(bp);
  10120e:	89 34 24             	mov    %esi,(%esp)
  101211:	e8 ca f0 ff ff       	call   1002e0 <brelse>
}
  101216:	83 c4 20             	add    $0x20,%esp
  101219:	5b                   	pop    %ebx
  10121a:	5e                   	pop    %esi
  10121b:	5f                   	pop    %edi
  10121c:	c3                   	ret    
    panic("freeing free block");
  10121d:	83 ec 0c             	sub    $0xc,%esp
  101220:	68 0d 5e 10 00       	push   $0x105e0d
  101225:	e8 e6 f5 ff ff       	call   100810 <panic>
  10122a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101230 <balloc>:
{
  101230:	55                   	push   %ebp
  101231:	57                   	push   %edi
  101232:	56                   	push   %esi
  101233:	53                   	push   %ebx
  101234:	83 ec 2c             	sub    $0x2c,%esp
  readsb(dev, &sb);
  101237:	8d 54 24 14          	lea    0x14(%esp),%edx
{
  10123b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  readsb(dev, &sb);
  10123f:	e8 0c ff ff ff       	call   101150 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  101244:	8b 44 24 14          	mov    0x14(%esp),%eax
  101248:	85 c0                	test   %eax,%eax
  10124a:	0f 84 aa 00 00 00    	je     1012fa <balloc+0xca>
  101250:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101257:	00 
      m = 1 << (bi % 8);
  101258:	bf 01 00 00 00       	mov    $0x1,%edi
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  10125d:	83 ec 08             	sub    $0x8,%esp
    for(bi = 0; bi < BPB; bi++){
  101260:	31 db                	xor    %ebx,%ebx
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  101262:	8b 44 24 24          	mov    0x24(%esp),%eax
  101266:	8b 54 24 10          	mov    0x10(%esp),%edx
  10126a:	c1 e8 03             	shr    $0x3,%eax
  10126d:	c1 fa 0c             	sar    $0xc,%edx
  101270:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101274:	50                   	push   %eax
  101275:	ff 74 24 18          	pushl  0x18(%esp)
  101279:	e8 52 ef ff ff       	call   1001d0 <bread>
  10127e:	83 c4 10             	add    $0x10,%esp
  101281:	eb 10                	jmp    101293 <balloc+0x63>
  101283:	90                   	nop
  101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB; bi++){
  101288:	83 c3 01             	add    $0x1,%ebx
  10128b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  101291:	74 45                	je     1012d8 <balloc+0xa8>
      m = 1 << (bi % 8);
  101293:	89 d9                	mov    %ebx,%ecx
  101295:	89 fe                	mov    %edi,%esi
  101297:	83 e1 07             	and    $0x7,%ecx
  10129a:	d3 e6                	shl    %cl,%esi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10129c:	89 d9                	mov    %ebx,%ecx
  10129e:	c1 f9 03             	sar    $0x3,%ecx
  1012a1:	0f b6 6c 08 18       	movzbl 0x18(%eax,%ecx,1),%ebp
  1012a6:	85 f5                	test   %esi,%ebp
  1012a8:	89 ea                	mov    %ebp,%edx
  1012aa:	75 dc                	jne    101288 <balloc+0x58>
        bwrite(bp);
  1012ac:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  1012af:	09 f2                	or     %esi,%edx
  1012b1:	89 c5                	mov    %eax,%ebp
  1012b3:	88 54 08 18          	mov    %dl,0x18(%eax,%ecx,1)
        bwrite(bp);
  1012b7:	50                   	push   %eax
  1012b8:	e8 f3 ef ff ff       	call   1002b0 <bwrite>
        brelse(bp);
  1012bd:	89 2c 24             	mov    %ebp,(%esp)
  1012c0:	e8 1b f0 ff ff       	call   1002e0 <brelse>
        return b + bi;
  1012c5:	8b 44 24 18          	mov    0x18(%esp),%eax
}
  1012c9:	83 c4 3c             	add    $0x3c,%esp
        return b + bi;
  1012cc:	01 d8                	add    %ebx,%eax
}
  1012ce:	5b                   	pop    %ebx
  1012cf:	5e                   	pop    %esi
  1012d0:	5f                   	pop    %edi
  1012d1:	5d                   	pop    %ebp
  1012d2:	c3                   	ret    
  1012d3:	90                   	nop
  1012d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
  1012d8:	83 ec 0c             	sub    $0xc,%esp
  1012db:	50                   	push   %eax
  1012dc:	e8 ff ef ff ff       	call   1002e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
  1012e1:	81 44 24 18 00 10 00 	addl   $0x1000,0x18(%esp)
  1012e8:	00 
  1012e9:	8b 44 24 18          	mov    0x18(%esp),%eax
  1012ed:	83 c4 10             	add    $0x10,%esp
  1012f0:	39 44 24 14          	cmp    %eax,0x14(%esp)
  1012f4:	0f 87 63 ff ff ff    	ja     10125d <balloc+0x2d>
  panic("balloc: out of blocks");
  1012fa:	83 ec 0c             	sub    $0xc,%esp
  1012fd:	68 20 5e 10 00       	push   $0x105e20
  101302:	e8 09 f5 ff ff       	call   100810 <panic>
  101307:	89 f6                	mov    %esi,%esi
  101309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101310 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101310:	55                   	push   %ebp
  101311:	57                   	push   %edi
  101312:	89 d5                	mov    %edx,%ebp
  101314:	56                   	push   %esi
  101315:	53                   	push   %ebx
  101316:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  101318:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10131a:	bb 94 ca 10 00       	mov    $0x10ca94,%ebx
{
  10131f:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
  101322:	68 60 ca 10 00       	push   $0x10ca60
  101327:	e8 64 28 00 00       	call   103b90 <acquire>
  10132c:	83 c4 10             	add    $0x10,%esp
  10132f:	eb 16                	jmp    101347 <iget+0x37>
  101331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101338:	85 f6                	test   %esi,%esi
  10133a:	74 44                	je     101380 <iget+0x70>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10133c:	83 c3 50             	add    $0x50,%ebx
  10133f:	81 fb 34 da 10 00    	cmp    $0x10da34,%ebx
  101345:	73 49                	jae    101390 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  101347:	8b 4b 08             	mov    0x8(%ebx),%ecx
  10134a:	85 c9                	test   %ecx,%ecx
  10134c:	7e ea                	jle    101338 <iget+0x28>
  10134e:	39 3b                	cmp    %edi,(%ebx)
  101350:	75 e6                	jne    101338 <iget+0x28>
  101352:	39 6b 04             	cmp    %ebp,0x4(%ebx)
  101355:	75 e1                	jne    101338 <iget+0x28>
      release(&icache.lock);
  101357:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
  10135a:	83 c1 01             	add    $0x1,%ecx
      return ip;
  10135d:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
  10135f:	68 60 ca 10 00       	push   $0x10ca60
      ip->ref++;
  101364:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
  101367:	e8 c4 29 00 00       	call   103d30 <release>
      return ip;
  10136c:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  10136f:	89 f0                	mov    %esi,%eax
  101371:	83 c4 0c             	add    $0xc,%esp
  101374:	5b                   	pop    %ebx
  101375:	5e                   	pop    %esi
  101376:	5f                   	pop    %edi
  101377:	5d                   	pop    %ebp
  101378:	c3                   	ret    
  101379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101380:	85 c9                	test   %ecx,%ecx
  101382:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  101385:	83 c3 50             	add    $0x50,%ebx
  101388:	81 fb 34 da 10 00    	cmp    $0x10da34,%ebx
  10138e:	72 b7                	jb     101347 <iget+0x37>
  if(empty == 0)
  101390:	85 f6                	test   %esi,%esi
  101392:	74 2d                	je     1013c1 <iget+0xb1>
  release(&icache.lock);
  101394:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
  101397:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  101399:	89 6e 04             	mov    %ebp,0x4(%esi)
  ip->ref = 1;
  10139c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  1013a3:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  1013aa:	68 60 ca 10 00       	push   $0x10ca60
  1013af:	e8 7c 29 00 00       	call   103d30 <release>
  return ip;
  1013b4:	83 c4 10             	add    $0x10,%esp
}
  1013b7:	89 f0                	mov    %esi,%eax
  1013b9:	83 c4 0c             	add    $0xc,%esp
  1013bc:	5b                   	pop    %ebx
  1013bd:	5e                   	pop    %esi
  1013be:	5f                   	pop    %edi
  1013bf:	5d                   	pop    %ebp
  1013c0:	c3                   	ret    
    panic("iget: no inodes");
  1013c1:	83 ec 0c             	sub    $0xc,%esp
  1013c4:	68 36 5e 10 00       	push   $0x105e36
  1013c9:	e8 42 f4 ff ff       	call   100810 <panic>
  1013ce:	66 90                	xchg   %ax,%ax

001013d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1013d0:	55                   	push   %ebp
  1013d1:	57                   	push   %edi
  1013d2:	56                   	push   %esi
  1013d3:	53                   	push   %ebx
  1013d4:	89 c6                	mov    %eax,%esi
  1013d6:	83 ec 0c             	sub    $0xc,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1013d9:	83 fa 0b             	cmp    $0xb,%edx
  1013dc:	77 1a                	ja     1013f8 <bmap+0x28>
  1013de:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
  1013e1:	8b 5f 1c             	mov    0x1c(%edi),%ebx
  1013e4:	85 db                	test   %ebx,%ebx
  1013e6:	74 68                	je     101450 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1013e8:	83 c4 0c             	add    $0xc,%esp
  1013eb:	89 d8                	mov    %ebx,%eax
  1013ed:	5b                   	pop    %ebx
  1013ee:	5e                   	pop    %esi
  1013ef:	5f                   	pop    %edi
  1013f0:	5d                   	pop    %ebp
  1013f1:	c3                   	ret    
  1013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
  1013f8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
  1013fb:	83 fb 7f             	cmp    $0x7f,%ebx
  1013fe:	77 7c                	ja     10147c <bmap+0xac>
    if((addr = ip->addrs[NDIRECT]) == 0)
  101400:	8b 40 4c             	mov    0x4c(%eax),%eax
  101403:	85 c0                	test   %eax,%eax
  101405:	74 69                	je     101470 <bmap+0xa0>
    bp = bread(ip->dev, addr);
  101407:	83 ec 08             	sub    $0x8,%esp
  10140a:	50                   	push   %eax
  10140b:	ff 36                	pushl  (%esi)
  10140d:	e8 be ed ff ff       	call   1001d0 <bread>
    if((addr = a[bn]) == 0){
  101412:	8d 6c 98 18          	lea    0x18(%eax,%ebx,4),%ebp
  101416:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
  101419:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
  10141b:	8b 5d 00             	mov    0x0(%ebp),%ebx
  10141e:	85 db                	test   %ebx,%ebx
  101420:	75 18                	jne    10143a <bmap+0x6a>
      a[bn] = addr = balloc(ip->dev);
  101422:	8b 06                	mov    (%esi),%eax
  101424:	e8 07 fe ff ff       	call   101230 <balloc>
      bwrite(bp);
  101429:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
  10142c:	89 45 00             	mov    %eax,0x0(%ebp)
  10142f:	89 c3                	mov    %eax,%ebx
      bwrite(bp);
  101431:	57                   	push   %edi
  101432:	e8 79 ee ff ff       	call   1002b0 <bwrite>
  101437:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
  10143a:	83 ec 0c             	sub    $0xc,%esp
  10143d:	57                   	push   %edi
  10143e:	e8 9d ee ff ff       	call   1002e0 <brelse>
  101443:	83 c4 10             	add    $0x10,%esp
}
  101446:	89 d8                	mov    %ebx,%eax
  101448:	83 c4 0c             	add    $0xc,%esp
  10144b:	5b                   	pop    %ebx
  10144c:	5e                   	pop    %esi
  10144d:	5f                   	pop    %edi
  10144e:	5d                   	pop    %ebp
  10144f:	c3                   	ret    
      ip->addrs[bn] = addr = balloc(ip->dev);
  101450:	8b 00                	mov    (%eax),%eax
  101452:	e8 d9 fd ff ff       	call   101230 <balloc>
  101457:	89 47 1c             	mov    %eax,0x1c(%edi)
  10145a:	89 c3                	mov    %eax,%ebx
}
  10145c:	83 c4 0c             	add    $0xc,%esp
  10145f:	89 d8                	mov    %ebx,%eax
  101461:	5b                   	pop    %ebx
  101462:	5e                   	pop    %esi
  101463:	5f                   	pop    %edi
  101464:	5d                   	pop    %ebp
  101465:	c3                   	ret    
  101466:	8d 76 00             	lea    0x0(%esi),%esi
  101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  101470:	8b 06                	mov    (%esi),%eax
  101472:	e8 b9 fd ff ff       	call   101230 <balloc>
  101477:	89 46 4c             	mov    %eax,0x4c(%esi)
  10147a:	eb 8b                	jmp    101407 <bmap+0x37>
  panic("bmap: out of range");
  10147c:	83 ec 0c             	sub    $0xc,%esp
  10147f:	68 46 5e 10 00       	push   $0x105e46
  101484:	e8 87 f3 ff ff       	call   100810 <panic>
  101489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101490 <iinit>:
{
  101490:	83 ec 14             	sub    $0x14,%esp
  initlock(&icache.lock, "icache");
  101493:	68 59 5e 10 00       	push   $0x105e59
  101498:	68 60 ca 10 00       	push   $0x10ca60
  10149d:	e8 ce 26 00 00       	call   103b70 <initlock>
}
  1014a2:	83 c4 1c             	add    $0x1c,%esp
  1014a5:	c3                   	ret    
  1014a6:	8d 76 00             	lea    0x0(%esi),%esi
  1014a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001014b0 <ialloc>:
{
  1014b0:	55                   	push   %ebp
  1014b1:	57                   	push   %edi
  1014b2:	56                   	push   %esi
  1014b3:	53                   	push   %ebx
  1014b4:	83 ec 2c             	sub    $0x2c,%esp
  1014b7:	8b 74 24 40          	mov    0x40(%esp),%esi
  readsb(dev, &sb);
  1014bb:	8d 54 24 14          	lea    0x14(%esp),%edx
{
  1014bf:	8b 7c 24 44          	mov    0x44(%esp),%edi
  readsb(dev, &sb);
  1014c3:	89 f0                	mov    %esi,%eax
  1014c5:	e8 86 fc ff ff       	call   101150 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1014ca:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
  1014cf:	0f 86 82 00 00 00    	jbe    101557 <ialloc+0xa7>
  1014d5:	bb 01 00 00 00       	mov    $0x1,%ebx
  1014da:	eb 19                	jmp    1014f5 <ialloc+0x45>
  1014dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
  1014e0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1014e3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
  1014e6:	55                   	push   %ebp
  1014e7:	e8 f4 ed ff ff       	call   1002e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1014ec:	83 c4 10             	add    $0x10,%esp
  1014ef:	39 5c 24 1c          	cmp    %ebx,0x1c(%esp)
  1014f3:	76 62                	jbe    101557 <ialloc+0xa7>
    bp = bread(dev, IBLOCK(inum));
  1014f5:	89 d8                	mov    %ebx,%eax
  1014f7:	83 ec 08             	sub    $0x8,%esp
  1014fa:	c1 e8 03             	shr    $0x3,%eax
  1014fd:	83 c0 02             	add    $0x2,%eax
  101500:	50                   	push   %eax
  101501:	56                   	push   %esi
  101502:	e8 c9 ec ff ff       	call   1001d0 <bread>
  101507:	89 c5                	mov    %eax,%ebp
    dip = (struct dinode*)bp->data + inum%IPB;
  101509:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
  10150b:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
  10150e:	83 e0 07             	and    $0x7,%eax
  101511:	c1 e0 06             	shl    $0x6,%eax
  101514:	8d 54 05 18          	lea    0x18(%ebp,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  101518:	66 83 3a 00          	cmpw   $0x0,(%edx)
  10151c:	75 c2                	jne    1014e0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
  10151e:	83 ec 04             	sub    $0x4,%esp
  101521:	6a 40                	push   $0x40
  101523:	6a 00                	push   $0x0
  101525:	52                   	push   %edx
  101526:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  10152a:	e8 51 28 00 00       	call   103d80 <memset>
      dip->type = type;
  10152f:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  101533:	66 89 3a             	mov    %di,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  101536:	89 2c 24             	mov    %ebp,(%esp)
  101539:	e8 72 ed ff ff       	call   1002b0 <bwrite>
      brelse(bp);
  10153e:	89 2c 24             	mov    %ebp,(%esp)
  101541:	e8 9a ed ff ff       	call   1002e0 <brelse>
      return iget(dev, inum);
  101546:	89 da                	mov    %ebx,%edx
  101548:	89 f0                	mov    %esi,%eax
  10154a:	e8 c1 fd ff ff       	call   101310 <iget>
}
  10154f:	83 c4 3c             	add    $0x3c,%esp
  101552:	5b                   	pop    %ebx
  101553:	5e                   	pop    %esi
  101554:	5f                   	pop    %edi
  101555:	5d                   	pop    %ebp
  101556:	c3                   	ret    
  panic("ialloc: no inodes");
  101557:	83 ec 0c             	sub    $0xc,%esp
  10155a:	68 60 5e 10 00       	push   $0x105e60
  10155f:	e8 ac f2 ff ff       	call   100810 <panic>
  101564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10156a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101570 <iupdate>:
{
  101570:	56                   	push   %esi
  101571:	53                   	push   %ebx
  101572:	83 ec 0c             	sub    $0xc,%esp
  101575:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum));
  101579:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  10157c:	83 c3 1c             	add    $0x1c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum));
  10157f:	c1 e8 03             	shr    $0x3,%eax
  101582:	83 c0 02             	add    $0x2,%eax
  101585:	50                   	push   %eax
  101586:	ff 73 e4             	pushl  -0x1c(%ebx)
  101589:	e8 42 ec ff ff       	call   1001d0 <bread>
  10158e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101590:	8b 43 e8             	mov    -0x18(%ebx),%eax
  dip->type = ip->type;
  101593:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101597:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  10159a:	83 e0 07             	and    $0x7,%eax
  10159d:	c1 e0 06             	shl    $0x6,%eax
  1015a0:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  1015a4:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  1015a7:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015ab:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
  1015ae:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
  1015b2:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
  1015b6:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
  1015ba:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
  1015be:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
  1015c2:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1015c5:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015c8:	6a 34                	push   $0x34
  1015ca:	53                   	push   %ebx
  1015cb:	50                   	push   %eax
  1015cc:	e8 2f 28 00 00       	call   103e00 <memmove>
  bwrite(bp);
  1015d1:	89 34 24             	mov    %esi,(%esp)
  1015d4:	e8 d7 ec ff ff       	call   1002b0 <bwrite>
  brelse(bp);
  1015d9:	89 74 24 20          	mov    %esi,0x20(%esp)
}
  1015dd:	83 c4 14             	add    $0x14,%esp
  1015e0:	5b                   	pop    %ebx
  1015e1:	5e                   	pop    %esi
  brelse(bp);
  1015e2:	e9 f9 ec ff ff       	jmp    1002e0 <brelse>
  1015e7:	89 f6                	mov    %esi,%esi
  1015e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001015f0 <idup>:
{
  1015f0:	53                   	push   %ebx
  1015f1:	83 ec 14             	sub    $0x14,%esp
  1015f4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&icache.lock);
  1015f8:	68 60 ca 10 00       	push   $0x10ca60
  1015fd:	e8 8e 25 00 00       	call   103b90 <acquire>
  ip->ref++;
  101602:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  101606:	c7 04 24 60 ca 10 00 	movl   $0x10ca60,(%esp)
  10160d:	e8 1e 27 00 00       	call   103d30 <release>
}
  101612:	83 c4 18             	add    $0x18,%esp
  101615:	89 d8                	mov    %ebx,%eax
  101617:	5b                   	pop    %ebx
  101618:	c3                   	ret    
  101619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101620 <ilock>:
{
  101620:	56                   	push   %esi
  101621:	53                   	push   %ebx
  101622:	83 ec 04             	sub    $0x4,%esp
  101625:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(ip == 0 || ip->ref < 1)
  101629:	85 db                	test   %ebx,%ebx
  10162b:	0f 84 e7 00 00 00    	je     101718 <ilock+0xf8>
  101631:	8b 43 08             	mov    0x8(%ebx),%eax
  101634:	85 c0                	test   %eax,%eax
  101636:	0f 8e dc 00 00 00    	jle    101718 <ilock+0xf8>
  acquire(&icache.lock);
  10163c:	83 ec 0c             	sub    $0xc,%esp
  10163f:	68 60 ca 10 00       	push   $0x10ca60
  101644:	e8 47 25 00 00       	call   103b90 <acquire>
  while(ip->flags & I_BUSY)
  101649:	8b 43 0c             	mov    0xc(%ebx),%eax
  10164c:	83 c4 10             	add    $0x10,%esp
  10164f:	a8 01                	test   $0x1,%al
  101651:	74 1d                	je     101670 <ilock+0x50>
  101653:	90                   	nop
  101654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101658:	83 ec 08             	sub    $0x8,%esp
  10165b:	68 60 ca 10 00       	push   $0x10ca60
  101660:	53                   	push   %ebx
  101661:	e8 2a 21 00 00       	call   103790 <sleep>
  while(ip->flags & I_BUSY)
  101666:	8b 43 0c             	mov    0xc(%ebx),%eax
  101669:	83 c4 10             	add    $0x10,%esp
  10166c:	a8 01                	test   $0x1,%al
  10166e:	75 e8                	jne    101658 <ilock+0x38>
  release(&icache.lock);
  101670:	83 ec 0c             	sub    $0xc,%esp
  ip->flags |= I_BUSY;
  101673:	83 c8 01             	or     $0x1,%eax
  101676:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  101679:	68 60 ca 10 00       	push   $0x10ca60
  10167e:	e8 ad 26 00 00       	call   103d30 <release>
  if(!(ip->flags & I_VALID)){
  101683:	83 c4 10             	add    $0x10,%esp
  101686:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  10168a:	74 0c                	je     101698 <ilock+0x78>
}
  10168c:	83 c4 04             	add    $0x4,%esp
  10168f:	5b                   	pop    %ebx
  101690:	5e                   	pop    %esi
  101691:	c3                   	ret    
  101692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101698:	8b 43 04             	mov    0x4(%ebx),%eax
  10169b:	83 ec 08             	sub    $0x8,%esp
  10169e:	c1 e8 03             	shr    $0x3,%eax
  1016a1:	83 c0 02             	add    $0x2,%eax
  1016a4:	50                   	push   %eax
  1016a5:	ff 33                	pushl  (%ebx)
  1016a7:	e8 24 eb ff ff       	call   1001d0 <bread>
  1016ac:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  1016ae:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1016b1:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  1016b4:	83 e0 07             	and    $0x7,%eax
  1016b7:	c1 e0 06             	shl    $0x6,%eax
  1016ba:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  1016be:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1016c1:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
  1016c4:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  1016c8:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
  1016cc:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  1016d0:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
  1016d4:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  1016d8:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
  1016dc:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  1016e0:	8b 50 fc             	mov    -0x4(%eax),%edx
  1016e3:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1016e6:	6a 34                	push   $0x34
  1016e8:	50                   	push   %eax
  1016e9:	8d 43 1c             	lea    0x1c(%ebx),%eax
  1016ec:	50                   	push   %eax
  1016ed:	e8 0e 27 00 00       	call   103e00 <memmove>
    brelse(bp);
  1016f2:	89 34 24             	mov    %esi,(%esp)
  1016f5:	e8 e6 eb ff ff       	call   1002e0 <brelse>
    ip->flags |= I_VALID;
  1016fa:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  1016fe:	83 c4 10             	add    $0x10,%esp
  101701:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  101706:	75 84                	jne    10168c <ilock+0x6c>
      panic("ilock: no type");
  101708:	83 ec 0c             	sub    $0xc,%esp
  10170b:	68 78 5e 10 00       	push   $0x105e78
  101710:	e8 fb f0 ff ff       	call   100810 <panic>
  101715:	8d 76 00             	lea    0x0(%esi),%esi
    panic("ilock");
  101718:	83 ec 0c             	sub    $0xc,%esp
  10171b:	68 72 5e 10 00       	push   $0x105e72
  101720:	e8 eb f0 ff ff       	call   100810 <panic>
  101725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101730 <iunlock>:
{
  101730:	53                   	push   %ebx
  101731:	83 ec 08             	sub    $0x8,%esp
  101734:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  101738:	85 db                	test   %ebx,%ebx
  10173a:	74 37                	je     101773 <iunlock+0x43>
  10173c:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101740:	74 31                	je     101773 <iunlock+0x43>
  101742:	8b 43 08             	mov    0x8(%ebx),%eax
  101745:	85 c0                	test   %eax,%eax
  101747:	7e 2a                	jle    101773 <iunlock+0x43>
  acquire(&icache.lock);
  101749:	83 ec 0c             	sub    $0xc,%esp
  10174c:	68 60 ca 10 00       	push   $0x10ca60
  101751:	e8 3a 24 00 00       	call   103b90 <acquire>
  ip->flags &= ~I_BUSY;
  101756:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  10175a:	89 1c 24             	mov    %ebx,(%esp)
  10175d:	e8 ee 20 00 00       	call   103850 <wakeup>
  release(&icache.lock);
  101762:	c7 44 24 20 60 ca 10 	movl   $0x10ca60,0x20(%esp)
  101769:	00 
}
  10176a:	83 c4 18             	add    $0x18,%esp
  10176d:	5b                   	pop    %ebx
  release(&icache.lock);
  10176e:	e9 bd 25 00 00       	jmp    103d30 <release>
    panic("iunlock");
  101773:	83 ec 0c             	sub    $0xc,%esp
  101776:	68 87 5e 10 00       	push   $0x105e87
  10177b:	e8 90 f0 ff ff       	call   100810 <panic>

00101780 <iput>:
{
  101780:	55                   	push   %ebp
  101781:	57                   	push   %edi
  101782:	56                   	push   %esi
  101783:	53                   	push   %ebx
  101784:	83 ec 18             	sub    $0x18,%esp
  101787:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  acquire(&icache.lock);
  10178b:	68 60 ca 10 00       	push   $0x10ca60
  101790:	e8 fb 23 00 00       	call   103b90 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  101795:	8b 46 08             	mov    0x8(%esi),%eax
  101798:	83 c4 10             	add    $0x10,%esp
  10179b:	83 f8 01             	cmp    $0x1,%eax
  10179e:	0f 85 ac 00 00 00    	jne    101850 <iput+0xd0>
  1017a4:	8b 56 0c             	mov    0xc(%esi),%edx
  1017a7:	f6 c2 02             	test   $0x2,%dl
  1017aa:	0f 84 a0 00 00 00    	je     101850 <iput+0xd0>
  1017b0:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  1017b5:	0f 85 95 00 00 00    	jne    101850 <iput+0xd0>
    if(ip->flags & I_BUSY)
  1017bb:	f6 c2 01             	test   $0x1,%dl
  1017be:	0f 85 04 01 00 00    	jne    1018c8 <iput+0x148>
    release(&icache.lock);
  1017c4:	83 ec 0c             	sub    $0xc,%esp
    ip->flags |= I_BUSY;
  1017c7:	83 ca 01             	or     $0x1,%edx
  1017ca:	8d 5e 1c             	lea    0x1c(%esi),%ebx
  1017cd:	89 56 0c             	mov    %edx,0xc(%esi)
    release(&icache.lock);
  1017d0:	68 60 ca 10 00       	push   $0x10ca60
  1017d5:	8d 7e 4c             	lea    0x4c(%esi),%edi
  1017d8:	e8 53 25 00 00       	call   103d30 <release>
  1017dd:	83 c4 10             	add    $0x10,%esp
  1017e0:	eb 0d                	jmp    1017ef <iput+0x6f>
  1017e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1017e8:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  1017eb:	39 fb                	cmp    %edi,%ebx
  1017ed:	74 1b                	je     10180a <iput+0x8a>
    if(ip->addrs[i]){
  1017ef:	8b 13                	mov    (%ebx),%edx
  1017f1:	85 d2                	test   %edx,%edx
  1017f3:	74 f3                	je     1017e8 <iput+0x68>
      bfree(ip->dev, ip->addrs[i]);
  1017f5:	8b 06                	mov    (%esi),%eax
  1017f7:	83 c3 04             	add    $0x4,%ebx
  1017fa:	e8 81 f9 ff ff       	call   101180 <bfree>
      ip->addrs[i] = 0;
  1017ff:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
  for(i = 0; i < NDIRECT; i++){
  101806:	39 fb                	cmp    %edi,%ebx
  101808:	75 e5                	jne    1017ef <iput+0x6f>
    }
  }
  
  if(ip->addrs[NDIRECT]){
  10180a:	8b 46 4c             	mov    0x4c(%esi),%eax
  10180d:	85 c0                	test   %eax,%eax
  10180f:	75 5f                	jne    101870 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
  101811:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
  101814:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  10181b:	56                   	push   %esi
  10181c:	e8 4f fd ff ff       	call   101570 <iupdate>
    ip->type = 0;
  101821:	31 c0                	xor    %eax,%eax
  101823:	66 89 46 10          	mov    %ax,0x10(%esi)
    iupdate(ip);
  101827:	89 34 24             	mov    %esi,(%esp)
  10182a:	e8 41 fd ff ff       	call   101570 <iupdate>
    acquire(&icache.lock);
  10182f:	c7 04 24 60 ca 10 00 	movl   $0x10ca60,(%esp)
  101836:	e8 55 23 00 00       	call   103b90 <acquire>
    ip->flags = 0;
  10183b:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  101842:	89 34 24             	mov    %esi,(%esp)
  101845:	e8 06 20 00 00       	call   103850 <wakeup>
  10184a:	8b 46 08             	mov    0x8(%esi),%eax
  10184d:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
  101850:	83 e8 01             	sub    $0x1,%eax
  101853:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  101856:	c7 44 24 20 60 ca 10 	movl   $0x10ca60,0x20(%esp)
  10185d:	00 
}
  10185e:	83 c4 0c             	add    $0xc,%esp
  101861:	5b                   	pop    %ebx
  101862:	5e                   	pop    %esi
  101863:	5f                   	pop    %edi
  101864:	5d                   	pop    %ebp
  release(&icache.lock);
  101865:	e9 c6 24 00 00       	jmp    103d30 <release>
  10186a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101870:	83 ec 08             	sub    $0x8,%esp
  101873:	50                   	push   %eax
  101874:	ff 36                	pushl  (%esi)
  101876:	e8 55 e9 ff ff       	call   1001d0 <bread>
  10187b:	83 c4 10             	add    $0x10,%esp
  10187e:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
  101880:	8d 58 18             	lea    0x18(%eax),%ebx
  101883:	8d a8 18 02 00 00    	lea    0x218(%eax),%ebp
  101889:	eb 0c                	jmp    101897 <iput+0x117>
  10188b:	90                   	nop
  10188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101890:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
  101893:	39 dd                	cmp    %ebx,%ebp
  101895:	74 0f                	je     1018a6 <iput+0x126>
      if(a[j])
  101897:	8b 13                	mov    (%ebx),%edx
  101899:	85 d2                	test   %edx,%edx
  10189b:	74 f3                	je     101890 <iput+0x110>
        bfree(ip->dev, a[j]);
  10189d:	8b 06                	mov    (%esi),%eax
  10189f:	e8 dc f8 ff ff       	call   101180 <bfree>
  1018a4:	eb ea                	jmp    101890 <iput+0x110>
    brelse(bp);
  1018a6:	83 ec 0c             	sub    $0xc,%esp
  1018a9:	57                   	push   %edi
  1018aa:	e8 31 ea ff ff       	call   1002e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
  1018af:	8b 56 4c             	mov    0x4c(%esi),%edx
  1018b2:	8b 06                	mov    (%esi),%eax
  1018b4:	e8 c7 f8 ff ff       	call   101180 <bfree>
    ip->addrs[NDIRECT] = 0;
  1018b9:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  1018c0:	83 c4 10             	add    $0x10,%esp
  1018c3:	e9 49 ff ff ff       	jmp    101811 <iput+0x91>
      panic("iput busy");
  1018c8:	83 ec 0c             	sub    $0xc,%esp
  1018cb:	68 8f 5e 10 00       	push   $0x105e8f
  1018d0:	e8 3b ef ff ff       	call   100810 <panic>
  1018d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1018d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001018e0 <iunlockput>:
{
  1018e0:	53                   	push   %ebx
  1018e1:	83 ec 14             	sub    $0x14,%esp
  1018e4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  iunlock(ip);
  1018e8:	53                   	push   %ebx
  1018e9:	e8 42 fe ff ff       	call   101730 <iunlock>
  iput(ip);
  1018ee:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  1018f2:	83 c4 18             	add    $0x18,%esp
  1018f5:	5b                   	pop    %ebx
  iput(ip);
  1018f6:	e9 85 fe ff ff       	jmp    101780 <iput>
  1018fb:	90                   	nop
  1018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101900 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat_new *st)
{
  101900:	8b 54 24 04          	mov    0x4(%esp),%edx
  101904:	8b 44 24 08          	mov    0x8(%esp),%eax
  st->dev = ip->dev;
  101908:	8b 0a                	mov    (%edx),%ecx
  10190a:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
  10190d:	8b 4a 04             	mov    0x4(%edx),%ecx
  101910:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
  101913:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  101917:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
  10191a:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  10191e:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
  101922:	8b 52 18             	mov    0x18(%edx),%edx
  101925:	89 50 10             	mov    %edx,0x10(%eax)
  101928:	c3                   	ret    
  101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101930 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101930:	55                   	push   %ebp
  101931:	57                   	push   %edi
  101932:	56                   	push   %esi
  101933:	53                   	push   %ebx
  101934:	83 ec 1c             	sub    $0x1c,%esp
  101937:	8b 44 24 30          	mov    0x30(%esp),%eax
  10193b:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  10193f:	8b 6c 24 34          	mov    0x34(%esp),%ebp
  101943:	8b 74 24 38          	mov    0x38(%esp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101947:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
  10194c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101950:	89 7c 24 04          	mov    %edi,0x4(%esp)
  if(ip->type == T_DEV){
  101954:	0f 84 a6 00 00 00    	je     101a00 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  10195a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10195e:	8b 40 18             	mov    0x18(%eax),%eax
  101961:	39 f0                	cmp    %esi,%eax
  101963:	0f 82 b9 00 00 00    	jb     101a22 <readi+0xf2>
  101969:	8b 7c 24 04          	mov    0x4(%esp),%edi
  10196d:	89 f9                	mov    %edi,%ecx
  10196f:	01 f1                	add    %esi,%ecx
  101971:	0f 82 ab 00 00 00    	jb     101a22 <readi+0xf2>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  101977:	89 c2                	mov    %eax,%edx
  101979:	29 f2                	sub    %esi,%edx
  10197b:	39 c8                	cmp    %ecx,%eax
  10197d:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101980:	31 ff                	xor    %edi,%edi
  101982:	85 d2                	test   %edx,%edx
    n = ip->size - off;
  101984:	89 54 24 04          	mov    %edx,0x4(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101988:	74 6a                	je     1019f4 <readi+0xc4>
  10198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101990:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  101994:	89 f2                	mov    %esi,%edx
  101996:	c1 ea 09             	shr    $0x9,%edx
  101999:	89 d8                	mov    %ebx,%eax
  10199b:	e8 30 fa ff ff       	call   1013d0 <bmap>
  1019a0:	83 ec 08             	sub    $0x8,%esp
  1019a3:	50                   	push   %eax
  1019a4:	ff 33                	pushl  (%ebx)
  1019a6:	e8 25 e8 ff ff       	call   1001d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  1019ab:	8b 5c 24 14          	mov    0x14(%esp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1019af:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1019b1:	89 f0                	mov    %esi,%eax
  1019b3:	25 ff 01 00 00       	and    $0x1ff,%eax
  1019b8:	b9 00 02 00 00       	mov    $0x200,%ecx
  1019bd:	83 c4 0c             	add    $0xc,%esp
  1019c0:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
  1019c2:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
  1019c6:	29 fb                	sub    %edi,%ebx
  1019c8:	39 d9                	cmp    %ebx,%ecx
  1019ca:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
  1019cd:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019ce:	01 df                	add    %ebx,%edi
  1019d0:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
  1019d2:	89 54 24 10          	mov    %edx,0x10(%esp)
  1019d6:	50                   	push   %eax
  1019d7:	55                   	push   %ebp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019d8:	01 dd                	add    %ebx,%ebp
    memmove(dst, bp->data + off%BSIZE, m);
  1019da:	e8 21 24 00 00       	call   103e00 <memmove>
    brelse(bp);
  1019df:	8b 54 24 18          	mov    0x18(%esp),%edx
  1019e3:	89 14 24             	mov    %edx,(%esp)
  1019e6:	e8 f5 e8 ff ff       	call   1002e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019eb:	83 c4 10             	add    $0x10,%esp
  1019ee:	39 7c 24 04          	cmp    %edi,0x4(%esp)
  1019f2:	77 9c                	ja     101990 <readi+0x60>
  }
  return n;
  1019f4:	8b 44 24 04          	mov    0x4(%esp),%eax
}
  1019f8:	83 c4 1c             	add    $0x1c,%esp
  1019fb:	5b                   	pop    %ebx
  1019fc:	5e                   	pop    %esi
  1019fd:	5f                   	pop    %edi
  1019fe:	5d                   	pop    %ebp
  1019ff:	c3                   	ret    
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  101a00:	0f bf 40 12          	movswl 0x12(%eax),%eax
  101a04:	66 83 f8 09          	cmp    $0x9,%ax
  101a08:	77 18                	ja     101a22 <readi+0xf2>
  101a0a:	8b 04 c5 00 ca 10 00 	mov    0x10ca00(,%eax,8),%eax
  101a11:	85 c0                	test   %eax,%eax
  101a13:	74 0d                	je     101a22 <readi+0xf2>
    return devsw[ip->major].read(ip, dst, n);
  101a15:	89 7c 24 38          	mov    %edi,0x38(%esp)
}
  101a19:	83 c4 1c             	add    $0x1c,%esp
  101a1c:	5b                   	pop    %ebx
  101a1d:	5e                   	pop    %esi
  101a1e:	5f                   	pop    %edi
  101a1f:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
  101a20:	ff e0                	jmp    *%eax
      return -1;
  101a22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101a27:	eb cf                	jmp    1019f8 <readi+0xc8>
  101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101a30 <writei>:

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101a30:	55                   	push   %ebp
  101a31:	57                   	push   %edi
  101a32:	56                   	push   %esi
  101a33:	53                   	push   %ebx
  101a34:	83 ec 1c             	sub    $0x1c,%esp
  101a37:	8b 44 24 30          	mov    0x30(%esp),%eax
  101a3b:	8b 7c 24 34          	mov    0x34(%esp),%edi
  101a3f:	8b 74 24 38          	mov    0x38(%esp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101a43:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
  101a48:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101a4c:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  101a50:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101a54:	89 7c 24 04          	mov    %edi,0x4(%esp)
  if(ip->type == T_DEV){
  101a58:	0f 84 c2 00 00 00    	je     101b20 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  101a5e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101a62:	39 70 18             	cmp    %esi,0x18(%eax)
  101a65:	0f 82 f2 00 00 00    	jb     101b5d <writei+0x12d>
  101a6b:	8b 7c 24 04          	mov    0x4(%esp),%edi
  101a6f:	89 fa                	mov    %edi,%edx
  101a71:	01 f2                	add    %esi,%edx
  101a73:	0f 82 e4 00 00 00    	jb     101b5d <writei+0x12d>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;
  101a79:	b8 00 18 01 00       	mov    $0x11800,%eax
  101a7e:	29 f0                	sub    %esi,%eax
  101a80:	81 fa 01 18 01 00    	cmp    $0x11801,%edx
  101a86:	0f 42 c7             	cmovb  %edi,%eax

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101a89:	31 ff                	xor    %edi,%edi
  101a8b:	85 c0                	test   %eax,%eax
    n = MAXFILE*BSIZE - off;
  101a8d:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101a91:	74 77                	je     101b0a <writei+0xda>
  101a93:	90                   	nop
  101a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101a98:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  101a9c:	89 f2                	mov    %esi,%edx
  101a9e:	c1 ea 09             	shr    $0x9,%edx
  101aa1:	89 d8                	mov    %ebx,%eax
  101aa3:	e8 28 f9 ff ff       	call   1013d0 <bmap>
  101aa8:	83 ec 08             	sub    $0x8,%esp
  101aab:	50                   	push   %eax
  101aac:	ff 33                	pushl  (%ebx)
  101aae:	e8 1d e7 ff ff       	call   1001d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101ab3:	8b 5c 24 14          	mov    0x14(%esp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101ab7:	89 c5                	mov    %eax,%ebp
    m = min(n - tot, BSIZE - off%BSIZE);
  101ab9:	89 f0                	mov    %esi,%eax
  101abb:	25 ff 01 00 00       	and    $0x1ff,%eax
  101ac0:	b9 00 02 00 00       	mov    $0x200,%ecx
  101ac5:	83 c4 0c             	add    $0xc,%esp
  101ac8:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
  101aca:	8d 44 05 18          	lea    0x18(%ebp,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
  101ace:	29 fb                	sub    %edi,%ebx
  101ad0:	39 d9                	cmp    %ebx,%ecx
  101ad2:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
  101ad5:	53                   	push   %ebx
  101ad6:	ff 74 24 10          	pushl  0x10(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101ada:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
  101adc:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101add:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
  101adf:	e8 1c 23 00 00       	call   103e00 <memmove>
    bwrite(bp);
  101ae4:	89 2c 24             	mov    %ebp,(%esp)
  101ae7:	e8 c4 e7 ff ff       	call   1002b0 <bwrite>
    brelse(bp);
  101aec:	89 2c 24             	mov    %ebp,(%esp)
  101aef:	e8 ec e7 ff ff       	call   1002e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101af4:	01 5c 24 18          	add    %ebx,0x18(%esp)
  101af8:	83 c4 10             	add    $0x10,%esp
  101afb:	39 7c 24 04          	cmp    %edi,0x4(%esp)
  101aff:	77 97                	ja     101a98 <writei+0x68>
  }

  if(n > 0 && off > ip->size){
  101b01:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101b05:	3b 70 18             	cmp    0x18(%eax),%esi
  101b08:	77 3e                	ja     101b48 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  101b0a:	8b 44 24 04          	mov    0x4(%esp),%eax
}
  101b0e:	83 c4 1c             	add    $0x1c,%esp
  101b11:	5b                   	pop    %ebx
  101b12:	5e                   	pop    %esi
  101b13:	5f                   	pop    %edi
  101b14:	5d                   	pop    %ebp
  101b15:	c3                   	ret    
  101b16:	8d 76 00             	lea    0x0(%esi),%esi
  101b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101b20:	0f bf 40 12          	movswl 0x12(%eax),%eax
  101b24:	66 83 f8 09          	cmp    $0x9,%ax
  101b28:	77 33                	ja     101b5d <writei+0x12d>
  101b2a:	8b 04 c5 04 ca 10 00 	mov    0x10ca04(,%eax,8),%eax
  101b31:	85 c0                	test   %eax,%eax
  101b33:	74 28                	je     101b5d <writei+0x12d>
    return devsw[ip->major].write(ip, src, n);
  101b35:	89 7c 24 38          	mov    %edi,0x38(%esp)
}
  101b39:	83 c4 1c             	add    $0x1c,%esp
  101b3c:	5b                   	pop    %ebx
  101b3d:	5e                   	pop    %esi
  101b3e:	5f                   	pop    %edi
  101b3f:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
  101b40:	ff e0                	jmp    *%eax
  101b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip->size = off;
  101b48:	8b 44 24 0c          	mov    0xc(%esp),%eax
    iupdate(ip);
  101b4c:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
  101b4f:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
  101b52:	50                   	push   %eax
  101b53:	e8 18 fa ff ff       	call   101570 <iupdate>
  101b58:	83 c4 10             	add    $0x10,%esp
  101b5b:	eb ad                	jmp    101b0a <writei+0xda>
      return -1;
  101b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101b62:	eb aa                	jmp    101b0e <writei+0xde>
  101b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101b70 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101b70:	83 ec 10             	sub    $0x10,%esp
  return strncmp(s, t, DIRSIZ);
  101b73:	6a 0e                	push   $0xe
  101b75:	ff 74 24 1c          	pushl  0x1c(%esp)
  101b79:	ff 74 24 1c          	pushl  0x1c(%esp)
  101b7d:	e8 de 22 00 00       	call   103e60 <strncmp>
}
  101b82:	83 c4 1c             	add    $0x1c,%esp
  101b85:	c3                   	ret    
  101b86:	8d 76 00             	lea    0x0(%esi),%esi
  101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101b90 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101b90:	55                   	push   %ebp
  101b91:	57                   	push   %edi
  101b92:	56                   	push   %esi
  101b93:	53                   	push   %ebx
  101b94:	83 ec 1c             	sub    $0x1c,%esp
  101b97:	8b 44 24 30          	mov    0x30(%esp),%eax
  101b9b:	8b 4c 24 38          	mov    0x38(%esp),%ecx
  101b9f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101ba3:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
{
  101ba8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bac:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  if(dp->type != T_DIR)
  101bb0:	0f 85 d9 00 00 00    	jne    101c8f <dirlookup+0xff>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101bb6:	8b 40 18             	mov    0x18(%eax),%eax
  101bb9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  101bc0:	85 c0                	test   %eax,%eax
  101bc2:	0f 84 bd 00 00 00    	je     101c85 <dirlookup+0xf5>
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  101bc8:	8b 7c 24 04          	mov    0x4(%esp),%edi
  101bcc:	8b 14 24             	mov    (%esp),%edx
  101bcf:	89 f8                	mov    %edi,%eax
  101bd1:	c1 ea 09             	shr    $0x9,%edx
  101bd4:	e8 f7 f7 ff ff       	call   1013d0 <bmap>
  101bd9:	83 ec 08             	sub    $0x8,%esp
  101bdc:	50                   	push   %eax
  101bdd:	ff 37                	pushl  (%edi)
  101bdf:	e8 ec e5 ff ff       	call   1001d0 <bread>
  101be4:	89 c7                	mov    %eax,%edi
    for(de = (struct dirent*)bp->data;
  101be6:	8d 40 18             	lea    0x18(%eax),%eax
        de < (struct dirent*)(bp->data + BSIZE);
  101be9:	8d b7 18 02 00 00    	lea    0x218(%edi),%esi
    for(de = (struct dirent*)bp->data;
  101bef:	89 44 24 18          	mov    %eax,0x18(%esp)
  101bf3:	89 c5                	mov    %eax,%ebp
        de < (struct dirent*)(bp->data + BSIZE);
  101bf5:	83 c4 10             	add    $0x10,%esp
  101bf8:	eb 0d                	jmp    101c07 <dirlookup+0x77>
  101bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        de++){
  101c00:	83 c5 10             	add    $0x10,%ebp
    for(de = (struct dirent*)bp->data;
  101c03:	39 f5                	cmp    %esi,%ebp
  101c05:	73 59                	jae    101c60 <dirlookup+0xd0>
      if(de->inum == 0)
  101c07:	66 83 7d 00 00       	cmpw   $0x0,0x0(%ebp)
  101c0c:	74 f2                	je     101c00 <dirlookup+0x70>
  return strncmp(s, t, DIRSIZ);
  101c0e:	8d 45 02             	lea    0x2(%ebp),%eax
  101c11:	83 ec 04             	sub    $0x4,%esp
  101c14:	6a 0e                	push   $0xe
  101c16:	50                   	push   %eax
  101c17:	53                   	push   %ebx
  101c18:	e8 43 22 00 00       	call   103e60 <strncmp>
        continue;
      if(namecmp(name, de->name) == 0){
  101c1d:	83 c4 10             	add    $0x10,%esp
  101c20:	85 c0                	test   %eax,%eax
  101c22:	75 dc                	jne    101c00 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  101c24:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101c28:	85 c0                	test   %eax,%eax
  101c2a:	74 0b                	je     101c37 <dirlookup+0xa7>
          *poff = off + (uchar*)de - bp->data;
  101c2c:	8b 34 24             	mov    (%esp),%esi
  101c2f:	01 ee                	add    %ebp,%esi
  101c31:	2b 74 24 08          	sub    0x8(%esp),%esi
  101c35:	89 30                	mov    %esi,(%eax)
        inum = de->inum;
        brelse(bp);
  101c37:	83 ec 0c             	sub    $0xc,%esp
        inum = de->inum;
  101c3a:	0f b7 5d 00          	movzwl 0x0(%ebp),%ebx
        brelse(bp);
  101c3e:	57                   	push   %edi
  101c3f:	e8 9c e6 ff ff       	call   1002e0 <brelse>
        return iget(dp->dev, inum);
  101c44:	8b 44 24 14          	mov    0x14(%esp),%eax
  101c48:	89 da                	mov    %ebx,%edx
  101c4a:	8b 00                	mov    (%eax),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  101c4c:	83 c4 2c             	add    $0x2c,%esp
  101c4f:	5b                   	pop    %ebx
  101c50:	5e                   	pop    %esi
  101c51:	5f                   	pop    %edi
  101c52:	5d                   	pop    %ebp
        return iget(dp->dev, inum);
  101c53:	e9 b8 f6 ff ff       	jmp    101310 <iget>
  101c58:	90                   	nop
  101c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
  101c60:	83 ec 0c             	sub    $0xc,%esp
  101c63:	57                   	push   %edi
  101c64:	e8 77 e6 ff ff       	call   1002e0 <brelse>
  for(off = 0; off < dp->size; off += BSIZE){
  101c69:	81 44 24 10 00 02 00 	addl   $0x200,0x10(%esp)
  101c70:	00 
  101c71:	8b 44 24 10          	mov    0x10(%esp),%eax
  101c75:	83 c4 10             	add    $0x10,%esp
  101c78:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  101c7c:	39 41 18             	cmp    %eax,0x18(%ecx)
  101c7f:	0f 87 43 ff ff ff    	ja     101bc8 <dirlookup+0x38>
}
  101c85:	83 c4 1c             	add    $0x1c,%esp
  101c88:	31 c0                	xor    %eax,%eax
  101c8a:	5b                   	pop    %ebx
  101c8b:	5e                   	pop    %esi
  101c8c:	5f                   	pop    %edi
  101c8d:	5d                   	pop    %ebp
  101c8e:	c3                   	ret    
    panic("dirlookup not DIR");
  101c8f:	83 ec 0c             	sub    $0xc,%esp
  101c92:	68 99 5e 10 00       	push   $0x105e99
  101c97:	e8 74 eb ff ff       	call   100810 <panic>
  101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101ca0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
  101ca0:	55                   	push   %ebp
  101ca1:	57                   	push   %edi
  101ca2:	89 cf                	mov    %ecx,%edi
  101ca4:	56                   	push   %esi
  101ca5:	53                   	push   %ebx
  101ca6:	89 c3                	mov    %eax,%ebx
  101ca8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
  101cab:	80 38 2f             	cmpb   $0x2f,(%eax)
{
  101cae:	89 54 24 08          	mov    %edx,0x8(%esp)
  if(*path == '/')
  101cb2:	0f 84 3b 01 00 00    	je     101df3 <namex+0x153>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
  101cb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
  101cbe:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(proc->cwd);
  101cc1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
  101cc4:	68 60 ca 10 00       	push   $0x10ca60
  101cc9:	e8 c2 1e 00 00       	call   103b90 <acquire>
  ip->ref++;
  101cce:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
  101cd2:	c7 04 24 60 ca 10 00 	movl   $0x10ca60,(%esp)
  101cd9:	e8 52 20 00 00       	call   103d30 <release>
  101cde:	83 c4 10             	add    $0x10,%esp
  101ce1:	eb 08                	jmp    101ceb <namex+0x4b>
  101ce3:	90                   	nop
  101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  101ce8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
  101ceb:	0f b6 03             	movzbl (%ebx),%eax
  101cee:	3c 2f                	cmp    $0x2f,%al
  101cf0:	74 f6                	je     101ce8 <namex+0x48>
  if(*path == 0)
  101cf2:	84 c0                	test   %al,%al
  101cf4:	0f 84 c7 00 00 00    	je     101dc1 <namex+0x121>
  while(*path != '/' && *path != 0)
  101cfa:	0f b6 03             	movzbl (%ebx),%eax
  101cfd:	89 dd                	mov    %ebx,%ebp
  101cff:	84 c0                	test   %al,%al
  101d01:	0f 84 95 00 00 00    	je     101d9c <namex+0xfc>
  101d07:	3c 2f                	cmp    $0x2f,%al
  101d09:	75 09                	jne    101d14 <namex+0x74>
  101d0b:	e9 8c 00 00 00       	jmp    101d9c <namex+0xfc>
  101d10:	84 c0                	test   %al,%al
  101d12:	74 0b                	je     101d1f <namex+0x7f>
    path++;
  101d14:	83 c5 01             	add    $0x1,%ebp
  while(*path != '/' && *path != 0)
  101d17:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  101d1b:	3c 2f                	cmp    $0x2f,%al
  101d1d:	75 f1                	jne    101d10 <namex+0x70>
  101d1f:	89 e9                	mov    %ebp,%ecx
  101d21:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
  101d23:	83 f9 0d             	cmp    $0xd,%ecx
  101d26:	7e 78                	jle    101da0 <namex+0x100>
    memmove(name, s, DIRSIZ);
  101d28:	83 ec 04             	sub    $0x4,%esp
  101d2b:	6a 0e                	push   $0xe
  101d2d:	53                   	push   %ebx
    path++;
  101d2e:	89 eb                	mov    %ebp,%ebx
    memmove(name, s, DIRSIZ);
  101d30:	57                   	push   %edi
  101d31:	e8 ca 20 00 00       	call   103e00 <memmove>
  101d36:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
  101d39:	80 7d 00 2f          	cmpb   $0x2f,0x0(%ebp)
  101d3d:	75 09                	jne    101d48 <namex+0xa8>
  101d3f:	90                   	nop
    path++;
  101d40:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
  101d43:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  101d46:	74 f8                	je     101d40 <namex+0xa0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
  101d48:	83 ec 0c             	sub    $0xc,%esp
  101d4b:	56                   	push   %esi
  101d4c:	e8 cf f8 ff ff       	call   101620 <ilock>
    if(ip->type != T_DIR){
  101d51:	83 c4 10             	add    $0x10,%esp
  101d54:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  101d59:	75 78                	jne    101dd3 <namex+0x133>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
  101d5b:	8b 54 24 08          	mov    0x8(%esp),%edx
  101d5f:	85 d2                	test   %edx,%edx
  101d61:	74 09                	je     101d6c <namex+0xcc>
  101d63:	80 3b 00             	cmpb   $0x0,(%ebx)
  101d66:	0f 84 9d 00 00 00    	je     101e09 <namex+0x169>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101d6c:	83 ec 04             	sub    $0x4,%esp
  101d6f:	6a 00                	push   $0x0
  101d71:	57                   	push   %edi
  101d72:	56                   	push   %esi
  101d73:	e8 18 fe ff ff       	call   101b90 <dirlookup>
  101d78:	83 c4 10             	add    $0x10,%esp
  101d7b:	85 c0                	test   %eax,%eax
  101d7d:	89 c5                	mov    %eax,%ebp
  101d7f:	74 52                	je     101dd3 <namex+0x133>
  iunlock(ip);
  101d81:	83 ec 0c             	sub    $0xc,%esp
  101d84:	56                   	push   %esi
  101d85:	e8 a6 f9 ff ff       	call   101730 <iunlock>
  iput(ip);
  101d8a:	89 34 24             	mov    %esi,(%esp)
  101d8d:	89 ee                	mov    %ebp,%esi
  101d8f:	e8 ec f9 ff ff       	call   101780 <iput>
  101d94:	83 c4 10             	add    $0x10,%esp
  101d97:	e9 4f ff ff ff       	jmp    101ceb <namex+0x4b>
  while(*path != '/' && *path != 0)
  101d9c:	31 c9                	xor    %ecx,%ecx
  101d9e:	66 90                	xchg   %ax,%ax
    memmove(name, s, len);
  101da0:	83 ec 04             	sub    $0x4,%esp
  101da3:	51                   	push   %ecx
  101da4:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  101da8:	53                   	push   %ebx
    name[len] = 0;
  101da9:	89 eb                	mov    %ebp,%ebx
    memmove(name, s, len);
  101dab:	57                   	push   %edi
  101dac:	e8 4f 20 00 00       	call   103e00 <memmove>
    name[len] = 0;
  101db1:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  101db5:	83 c4 10             	add    $0x10,%esp
  101db8:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
  101dbc:	e9 78 ff ff ff       	jmp    101d39 <namex+0x99>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
  101dc1:	8b 44 24 08          	mov    0x8(%esp),%eax
  101dc5:	85 c0                	test   %eax,%eax
  101dc7:	75 56                	jne    101e1f <namex+0x17f>
    iput(ip);
    return 0;
  }
  return ip;
}
  101dc9:	83 c4 1c             	add    $0x1c,%esp
  101dcc:	89 f0                	mov    %esi,%eax
  101dce:	5b                   	pop    %ebx
  101dcf:	5e                   	pop    %esi
  101dd0:	5f                   	pop    %edi
  101dd1:	5d                   	pop    %ebp
  101dd2:	c3                   	ret    
  iunlock(ip);
  101dd3:	83 ec 0c             	sub    $0xc,%esp
  101dd6:	56                   	push   %esi
  101dd7:	e8 54 f9 ff ff       	call   101730 <iunlock>
  iput(ip);
  101ddc:	89 34 24             	mov    %esi,(%esp)
      return 0;
  101ddf:	31 f6                	xor    %esi,%esi
  iput(ip);
  101de1:	e8 9a f9 ff ff       	call   101780 <iput>
      return 0;
  101de6:	83 c4 10             	add    $0x10,%esp
}
  101de9:	89 f0                	mov    %esi,%eax
  101deb:	83 c4 1c             	add    $0x1c,%esp
  101dee:	5b                   	pop    %ebx
  101def:	5e                   	pop    %esi
  101df0:	5f                   	pop    %edi
  101df1:	5d                   	pop    %ebp
  101df2:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
  101df3:	ba 01 00 00 00       	mov    $0x1,%edx
  101df8:	b8 01 00 00 00       	mov    $0x1,%eax
  101dfd:	e8 0e f5 ff ff       	call   101310 <iget>
  101e02:	89 c6                	mov    %eax,%esi
  101e04:	e9 e2 fe ff ff       	jmp    101ceb <namex+0x4b>
      iunlock(ip);
  101e09:	83 ec 0c             	sub    $0xc,%esp
  101e0c:	56                   	push   %esi
  101e0d:	e8 1e f9 ff ff       	call   101730 <iunlock>
      return ip;
  101e12:	83 c4 10             	add    $0x10,%esp
}
  101e15:	89 f0                	mov    %esi,%eax
  101e17:	83 c4 1c             	add    $0x1c,%esp
  101e1a:	5b                   	pop    %ebx
  101e1b:	5e                   	pop    %esi
  101e1c:	5f                   	pop    %edi
  101e1d:	5d                   	pop    %ebp
  101e1e:	c3                   	ret    
    iput(ip);
  101e1f:	83 ec 0c             	sub    $0xc,%esp
  101e22:	56                   	push   %esi
    return 0;
  101e23:	31 f6                	xor    %esi,%esi
    iput(ip);
  101e25:	e8 56 f9 ff ff       	call   101780 <iput>
    return 0;
  101e2a:	83 c4 10             	add    $0x10,%esp
  101e2d:	eb 9a                	jmp    101dc9 <namex+0x129>
  101e2f:	90                   	nop

00101e30 <dirlink>:
{
  101e30:	55                   	push   %ebp
  101e31:	57                   	push   %edi
  101e32:	56                   	push   %esi
  101e33:	53                   	push   %ebx
  101e34:	83 ec 20             	sub    $0x20,%esp
  101e37:	8b 74 24 34          	mov    0x34(%esp),%esi
  101e3b:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  if((ip = dirlookup(dp, name, 0)) != 0){
  101e3f:	6a 00                	push   $0x0
  101e41:	55                   	push   %ebp
  101e42:	56                   	push   %esi
  101e43:	e8 48 fd ff ff       	call   101b90 <dirlookup>
  101e48:	83 c4 10             	add    $0x10,%esp
  101e4b:	85 c0                	test   %eax,%eax
  101e4d:	75 67                	jne    101eb6 <dirlink+0x86>
  for(off = 0; off < dp->size; off += sizeof(de)){
  101e4f:	8b 5e 18             	mov    0x18(%esi),%ebx
  101e52:	89 e7                	mov    %esp,%edi
  101e54:	85 db                	test   %ebx,%ebx
  101e56:	74 29                	je     101e81 <dirlink+0x51>
  101e58:	31 db                	xor    %ebx,%ebx
  101e5a:	89 e7                	mov    %esp,%edi
  101e5c:	eb 0a                	jmp    101e68 <dirlink+0x38>
  101e5e:	66 90                	xchg   %ax,%ax
  101e60:	83 c3 10             	add    $0x10,%ebx
  101e63:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101e66:	76 19                	jbe    101e81 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101e68:	6a 10                	push   $0x10
  101e6a:	53                   	push   %ebx
  101e6b:	57                   	push   %edi
  101e6c:	56                   	push   %esi
  101e6d:	e8 be fa ff ff       	call   101930 <readi>
  101e72:	83 c4 10             	add    $0x10,%esp
  101e75:	83 f8 10             	cmp    $0x10,%eax
  101e78:	75 4f                	jne    101ec9 <dirlink+0x99>
    if(de.inum == 0)
  101e7a:	66 83 3c 24 00       	cmpw   $0x0,(%esp)
  101e7f:	75 df                	jne    101e60 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
  101e81:	83 ec 04             	sub    $0x4,%esp
  101e84:	6a 0e                	push   $0xe
  101e86:	55                   	push   %ebp
  101e87:	8d 44 24 0e          	lea    0xe(%esp),%eax
  101e8b:	50                   	push   %eax
  101e8c:	e8 2f 20 00 00       	call   103ec0 <strncpy>
  de.inum = inum;
  101e91:	8b 44 24 48          	mov    0x48(%esp),%eax
  101e95:	66 89 44 24 10       	mov    %ax,0x10(%esp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101e9a:	6a 10                	push   $0x10
  101e9c:	53                   	push   %ebx
  101e9d:	57                   	push   %edi
  101e9e:	56                   	push   %esi
  101e9f:	e8 8c fb ff ff       	call   101a30 <writei>
  101ea4:	83 c4 20             	add    $0x20,%esp
  101ea7:	83 f8 10             	cmp    $0x10,%eax
  101eaa:	75 2a                	jne    101ed6 <dirlink+0xa6>
  return 0;
  101eac:	31 c0                	xor    %eax,%eax
}
  101eae:	83 c4 1c             	add    $0x1c,%esp
  101eb1:	5b                   	pop    %ebx
  101eb2:	5e                   	pop    %esi
  101eb3:	5f                   	pop    %edi
  101eb4:	5d                   	pop    %ebp
  101eb5:	c3                   	ret    
    iput(ip);
  101eb6:	83 ec 0c             	sub    $0xc,%esp
  101eb9:	50                   	push   %eax
  101eba:	e8 c1 f8 ff ff       	call   101780 <iput>
    return -1;
  101ebf:	83 c4 10             	add    $0x10,%esp
  101ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101ec7:	eb e5                	jmp    101eae <dirlink+0x7e>
      panic("dirlink read");
  101ec9:	83 ec 0c             	sub    $0xc,%esp
  101ecc:	68 ab 5e 10 00       	push   $0x105eab
  101ed1:	e8 3a e9 ff ff       	call   100810 <panic>
    panic("dirlink");
  101ed6:	83 ec 0c             	sub    $0xc,%esp
  101ed9:	68 3a 64 10 00       	push   $0x10643a
  101ede:	e8 2d e9 ff ff       	call   100810 <panic>
  101ee3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101ef0 <namei>:

struct inode*
namei(char *path)
{
  101ef0:	83 ec 1c             	sub    $0x1c,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101ef3:	31 d2                	xor    %edx,%edx
  101ef5:	8b 44 24 20          	mov    0x20(%esp),%eax
  101ef9:	8d 4c 24 02          	lea    0x2(%esp),%ecx
  101efd:	e8 9e fd ff ff       	call   101ca0 <namex>
}
  101f02:	83 c4 1c             	add    $0x1c,%esp
  101f05:	c3                   	ret    
  101f06:	8d 76 00             	lea    0x0(%esi),%esi
  101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f10 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
  101f10:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101f14:	8b 44 24 04          	mov    0x4(%esp),%eax
  101f18:	ba 01 00 00 00       	mov    $0x1,%edx
  101f1d:	e9 7e fd ff ff       	jmp    101ca0 <namex>
  101f22:	66 90                	xchg   %ax,%ax
  101f24:	66 90                	xchg   %ax,%ax
  101f26:	66 90                	xchg   %ax,%ax
  101f28:	66 90                	xchg   %ax,%ax
  101f2a:	66 90                	xchg   %ax,%ax
  101f2c:	66 90                	xchg   %ax,%ax
  101f2e:	66 90                	xchg   %ax,%ax

00101f30 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  101f30:	56                   	push   %esi
  101f31:	53                   	push   %ebx
  101f32:	83 ec 04             	sub    $0x4,%esp
  if(b == 0)
  101f35:	85 c0                	test   %eax,%eax
  101f37:	0f 84 97 00 00 00    	je     101fd4 <idestart+0xa4>
  101f3d:	89 c6                	mov    %eax,%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101f3f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101f48:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  101f49:	83 e0 c0             	and    $0xffffffc0,%eax
  101f4c:	3c 40                	cmp    $0x40,%al
  101f4e:	75 f8                	jne    101f48 <idestart+0x18>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101f50:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101f55:	31 c0                	xor    %eax,%eax
  101f57:	ee                   	out    %al,(%dx)
  101f58:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101f5d:	b8 01 00 00 00       	mov    $0x1,%eax
  101f62:	ee                   	out    %al,(%dx)
    panic("idestart");

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101f63:	8b 5e 08             	mov    0x8(%esi),%ebx
  101f66:	ba f3 01 00 00       	mov    $0x1f3,%edx
  101f6b:	89 d8                	mov    %ebx,%eax
  101f6d:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  101f6e:	89 d8                	mov    %ebx,%eax
  101f70:	ba f4 01 00 00       	mov    $0x1f4,%edx
  101f75:	c1 e8 08             	shr    $0x8,%eax
  101f78:	ee                   	out    %al,(%dx)
  outb(0x1f5, (b->sector >> 16) & 0xff);
  101f79:	89 d8                	mov    %ebx,%eax
  101f7b:	ba f5 01 00 00       	mov    $0x1f5,%edx
  101f80:	c1 e8 10             	shr    $0x10,%eax
  101f83:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  101f84:	0f b6 46 04          	movzbl 0x4(%esi),%eax
  101f88:	c1 eb 18             	shr    $0x18,%ebx
  101f8b:	ba f6 01 00 00       	mov    $0x1f6,%edx
  101f90:	83 e3 0f             	and    $0xf,%ebx
  101f93:	c1 e0 04             	shl    $0x4,%eax
  101f96:	83 e0 10             	and    $0x10,%eax
  101f99:	09 d8                	or     %ebx,%eax
  101f9b:	83 c8 e0             	or     $0xffffffe0,%eax
  101f9e:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
  101f9f:	f6 06 04             	testb  $0x4,(%esi)
  101fa2:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101fa7:	75 0f                	jne    101fb8 <idestart+0x88>
  101fa9:	b8 20 00 00 00       	mov    $0x20,%eax
  101fae:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101faf:	83 c4 04             	add    $0x4,%esp
  101fb2:	5b                   	pop    %ebx
  101fb3:	5e                   	pop    %esi
  101fb4:	c3                   	ret    
  101fb5:	8d 76 00             	lea    0x0(%esi),%esi
  101fb8:	b8 30 00 00 00       	mov    $0x30,%eax
  101fbd:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
  101fbe:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, 512/4);
  101fc3:	83 c6 18             	add    $0x18,%esi
  101fc6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  101fcb:	fc                   	cld    
  101fcc:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
  101fce:	83 c4 04             	add    $0x4,%esp
  101fd1:	5b                   	pop    %ebx
  101fd2:	5e                   	pop    %esi
  101fd3:	c3                   	ret    
    panic("idestart");
  101fd4:	83 ec 0c             	sub    $0xc,%esp
  101fd7:	68 b8 5e 10 00       	push   $0x105eb8
  101fdc:	e8 2f e8 ff ff       	call   100810 <panic>
  101fe1:	eb 0d                	jmp    101ff0 <ideinit>
  101fe3:	90                   	nop
  101fe4:	90                   	nop
  101fe5:	90                   	nop
  101fe6:	90                   	nop
  101fe7:	90                   	nop
  101fe8:	90                   	nop
  101fe9:	90                   	nop
  101fea:	90                   	nop
  101feb:	90                   	nop
  101fec:	90                   	nop
  101fed:	90                   	nop
  101fee:	90                   	nop
  101fef:	90                   	nop

00101ff0 <ideinit>:
{
  101ff0:	83 ec 14             	sub    $0x14,%esp
  initlock(&idelock, "ide");
  101ff3:	68 c1 5e 10 00       	push   $0x105ec1
  101ff8:	68 00 a8 10 00       	push   $0x10a800
  101ffd:	e8 6e 1b 00 00       	call   103b70 <initlock>
  picenable(IRQ_IDE);
  102002:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102009:	e8 62 0b 00 00       	call   102b70 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
  10200e:	58                   	pop    %eax
  10200f:	a1 80 e0 10 00       	mov    0x10e080,%eax
  102014:	5a                   	pop    %edx
  102015:	83 e8 01             	sub    $0x1,%eax
  102018:	50                   	push   %eax
  102019:	6a 0e                	push   $0xe
  10201b:	e8 d0 02 00 00       	call   1022f0 <ioapicenable>
  102020:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102023:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102028:	90                   	nop
  102029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102030:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  102031:	83 e0 c0             	and    $0xffffffc0,%eax
  102034:	3c 40                	cmp    $0x40,%al
  102036:	75 f8                	jne    102030 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102038:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10203d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  102042:	ee                   	out    %al,(%dx)
  102043:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102048:	ba f7 01 00 00       	mov    $0x1f7,%edx
  10204d:	eb 06                	jmp    102055 <ideinit+0x65>
  10204f:	90                   	nop
  for(i=0; i<1000; i++){
  102050:	83 e9 01             	sub    $0x1,%ecx
  102053:	74 0f                	je     102064 <ideinit+0x74>
  102055:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102056:	84 c0                	test   %al,%al
  102058:	74 f6                	je     102050 <ideinit+0x60>
      havedisk1 = 1;
  10205a:	c7 05 e0 a7 10 00 01 	movl   $0x1,0x10a7e0
  102061:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102064:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102069:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10206e:	ee                   	out    %al,(%dx)
}
  10206f:	83 c4 0c             	add    $0xc,%esp
  102072:	c3                   	ret    
  102073:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
  102080:	57                   	push   %edi
  102081:	56                   	push   %esi
  102082:	53                   	push   %ebx
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  102083:	83 ec 0c             	sub    $0xc,%esp
  102086:	68 00 a8 10 00       	push   $0x10a800
  10208b:	e8 00 1b 00 00       	call   103b90 <acquire>
  if((b = idequeue) == 0){
  102090:	8b 1d e4 a7 10 00    	mov    0x10a7e4,%ebx
  102096:	83 c4 10             	add    $0x10,%esp
  102099:	85 db                	test   %ebx,%ebx
  10209b:	74 76                	je     102113 <ideintr+0x93>
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  10209d:	8b 43 14             	mov    0x14(%ebx),%eax
  1020a0:	a3 e4 a7 10 00       	mov    %eax,0x10a7e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1020a5:	8b 33                	mov    (%ebx),%esi
  1020a7:	f7 c6 04 00 00 00    	test   $0x4,%esi
  1020ad:	74 39                	je     1020e8 <ideintr+0x68>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  1020af:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
  1020b2:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
  1020b5:	83 ce 02             	or     $0x2,%esi
  1020b8:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
  1020ba:	53                   	push   %ebx
  1020bb:	e8 90 17 00 00       	call   103850 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  1020c0:	a1 e4 a7 10 00       	mov    0x10a7e4,%eax
  1020c5:	83 c4 10             	add    $0x10,%esp
  1020c8:	85 c0                	test   %eax,%eax
  1020ca:	74 05                	je     1020d1 <ideintr+0x51>
    idestart(idequeue);
  1020cc:	e8 5f fe ff ff       	call   101f30 <idestart>

  release(&idelock);
  1020d1:	83 ec 0c             	sub    $0xc,%esp
  1020d4:	68 00 a8 10 00       	push   $0x10a800
  1020d9:	e8 52 1c 00 00       	call   103d30 <release>
  1020de:	83 c4 10             	add    $0x10,%esp
}
  1020e1:	5b                   	pop    %ebx
  1020e2:	5e                   	pop    %esi
  1020e3:	5f                   	pop    %edi
  1020e4:	c3                   	ret    
  1020e5:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1020e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
  1020ed:	8d 76 00             	lea    0x0(%esi),%esi
  1020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  1020f1:	89 c1                	mov    %eax,%ecx
  1020f3:	83 e1 c0             	and    $0xffffffc0,%ecx
  1020f6:	80 f9 40             	cmp    $0x40,%cl
  1020f9:	75 f5                	jne    1020f0 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  1020fb:	a8 21                	test   $0x21,%al
  1020fd:	75 b0                	jne    1020af <ideintr+0x2f>
    insl(0x1f0, b->data, 512/4);
  1020ff:	8d 7b 18             	lea    0x18(%ebx),%edi
  asm volatile("cld; rep insl" :
  102102:	b9 80 00 00 00       	mov    $0x80,%ecx
  102107:	ba f0 01 00 00       	mov    $0x1f0,%edx
  10210c:	fc                   	cld    
  10210d:	f3 6d                	rep insl (%dx),%es:(%edi)
  10210f:	8b 33                	mov    (%ebx),%esi
  102111:	eb 9c                	jmp    1020af <ideintr+0x2f>
    release(&idelock);
  102113:	83 ec 0c             	sub    $0xc,%esp
  102116:	68 00 a8 10 00       	push   $0x10a800
  10211b:	e8 10 1c 00 00       	call   103d30 <release>
    cprintf("Spurious IDE interrupt.\n");
  102120:	c7 04 24 c5 5e 10 00 	movl   $0x105ec5,(%esp)
  102127:	e8 64 e5 ff ff       	call   100690 <cprintf>
    return;
  10212c:	83 c4 10             	add    $0x10,%esp
  10212f:	eb b0                	jmp    1020e1 <ideintr+0x61>
  102131:	eb 0d                	jmp    102140 <iderw>
  102133:	90                   	nop
  102134:	90                   	nop
  102135:	90                   	nop
  102136:	90                   	nop
  102137:	90                   	nop
  102138:	90                   	nop
  102139:	90                   	nop
  10213a:	90                   	nop
  10213b:	90                   	nop
  10213c:	90                   	nop
  10213d:	90                   	nop
  10213e:	90                   	nop
  10213f:	90                   	nop

00102140 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  102140:	53                   	push   %ebx
  102141:	83 ec 08             	sub    $0x8,%esp
  102144:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  102148:	8b 03                	mov    (%ebx),%eax
  10214a:	a8 01                	test   $0x1,%al
  10214c:	0f 84 aa 00 00 00    	je     1021fc <iderw+0xbc>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  102152:	83 e0 06             	and    $0x6,%eax
  102155:	83 f8 02             	cmp    $0x2,%eax
  102158:	0f 84 b8 00 00 00    	je     102216 <iderw+0xd6>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  10215e:	8b 53 04             	mov    0x4(%ebx),%edx
  102161:	85 d2                	test   %edx,%edx
  102163:	74 0d                	je     102172 <iderw+0x32>
  102165:	a1 e0 a7 10 00       	mov    0x10a7e0,%eax
  10216a:	85 c0                	test   %eax,%eax
  10216c:	0f 84 97 00 00 00    	je     102209 <iderw+0xc9>
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);
  102172:	83 ec 0c             	sub    $0xc,%esp
  102175:	68 00 a8 10 00       	push   $0x10a800
  10217a:	e8 11 1a 00 00       	call   103b90 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  10217f:	8b 15 e4 a7 10 00    	mov    0x10a7e4,%edx
  102185:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
  102188:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  10218f:	85 d2                	test   %edx,%edx
  102191:	75 07                	jne    10219a <iderw+0x5a>
  102193:	eb 57                	jmp    1021ec <iderw+0xac>
  102195:	8d 76 00             	lea    0x0(%esi),%esi
  102198:	89 c2                	mov    %eax,%edx
  10219a:	8b 42 14             	mov    0x14(%edx),%eax
  10219d:	85 c0                	test   %eax,%eax
  10219f:	75 f7                	jne    102198 <iderw+0x58>
  1021a1:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
  1021a4:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(idequeue == b)
  1021a6:	3b 1d e4 a7 10 00    	cmp    0x10a7e4,%ebx
  1021ac:	74 45                	je     1021f3 <iderw+0xb3>
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore proc->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1021ae:	8b 03                	mov    (%ebx),%eax
  1021b0:	83 e0 06             	and    $0x6,%eax
  1021b3:	83 f8 02             	cmp    $0x2,%eax
  1021b6:	74 23                	je     1021db <iderw+0x9b>
  1021b8:	90                   	nop
  1021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
  1021c0:	83 ec 08             	sub    $0x8,%esp
  1021c3:	68 00 a8 10 00       	push   $0x10a800
  1021c8:	53                   	push   %ebx
  1021c9:	e8 c2 15 00 00       	call   103790 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1021ce:	8b 03                	mov    (%ebx),%eax
  1021d0:	83 c4 10             	add    $0x10,%esp
  1021d3:	83 e0 06             	and    $0x6,%eax
  1021d6:	83 f8 02             	cmp    $0x2,%eax
  1021d9:	75 e5                	jne    1021c0 <iderw+0x80>

  release(&idelock);
  1021db:	c7 44 24 10 00 a8 10 	movl   $0x10a800,0x10(%esp)
  1021e2:	00 
}
  1021e3:	83 c4 08             	add    $0x8,%esp
  1021e6:	5b                   	pop    %ebx
  release(&idelock);
  1021e7:	e9 44 1b 00 00       	jmp    103d30 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  1021ec:	ba e4 a7 10 00       	mov    $0x10a7e4,%edx
  1021f1:	eb b1                	jmp    1021a4 <iderw+0x64>
    idestart(b);
  1021f3:	89 d8                	mov    %ebx,%eax
  1021f5:	e8 36 fd ff ff       	call   101f30 <idestart>
  1021fa:	eb b2                	jmp    1021ae <iderw+0x6e>
    panic("iderw: buf not busy");
  1021fc:	83 ec 0c             	sub    $0xc,%esp
  1021ff:	68 de 5e 10 00       	push   $0x105ede
  102204:	e8 07 e6 ff ff       	call   100810 <panic>
    panic("idrw: ide disk 1 not present");
  102209:	83 ec 0c             	sub    $0xc,%esp
  10220c:	68 07 5f 10 00       	push   $0x105f07
  102211:	e8 fa e5 ff ff       	call   100810 <panic>
    panic("iderw: nothing to do");
  102216:	83 ec 0c             	sub    $0xc,%esp
  102219:	68 f2 5e 10 00       	push   $0x105ef2
  10221e:	e8 ed e5 ff ff       	call   100810 <panic>
  102223:	66 90                	xchg   %ax,%ax
  102225:	66 90                	xchg   %ax,%ax
  102227:	66 90                	xchg   %ax,%ax
  102229:	66 90                	xchg   %ax,%ax
  10222b:	66 90                	xchg   %ax,%ax
  10222d:	66 90                	xchg   %ax,%ax
  10222f:	90                   	nop

00102230 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
  102230:	a1 84 da 10 00       	mov    0x10da84,%eax
  102235:	85 c0                	test   %eax,%eax
  102237:	0f 84 a7 00 00 00    	je     1022e4 <ioapicinit+0xb4>
{
  10223d:	56                   	push   %esi
  10223e:	53                   	push   %ebx
  10223f:	83 ec 04             	sub    $0x4,%esp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  102242:	c7 05 34 da 10 00 00 	movl   $0xfec00000,0x10da34
  102249:	00 c0 fe 
  ioapic->reg = reg;
  10224c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  102253:	00 00 00 
  return ioapic->data;
  102256:	8b 15 34 da 10 00    	mov    0x10da34,%edx
  10225c:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
  10225f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
  102265:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  10226b:	0f b6 15 80 da 10 00 	movzbl 0x10da80,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  102272:	c1 ee 10             	shr    $0x10,%esi
  102275:	89 f0                	mov    %esi,%eax
  102277:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
  10227a:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
  10227d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
  102280:	39 d0                	cmp    %edx,%eax
  102282:	74 16                	je     10229a <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  102284:	83 ec 0c             	sub    $0xc,%esp
  102287:	68 24 5f 10 00       	push   $0x105f24
  10228c:	e8 ff e3 ff ff       	call   100690 <cprintf>
  102291:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx
  102297:	83 c4 10             	add    $0x10,%esp
  10229a:	83 c6 21             	add    $0x21,%esi
{
  10229d:	ba 10 00 00 00       	mov    $0x10,%edx
  1022a2:	b8 20 00 00 00       	mov    $0x20,%eax
  1022a7:	89 f6                	mov    %esi,%esi
  1022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
  1022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
  1022b2:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  1022b8:	89 c3                	mov    %eax,%ebx
  1022ba:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  1022c0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
  1022c3:	89 59 10             	mov    %ebx,0x10(%ecx)
  1022c6:	8d 5a 01             	lea    0x1(%edx),%ebx
  1022c9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
  1022cc:	39 f0                	cmp    %esi,%eax
  ioapic->reg = reg;
  1022ce:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
  1022d0:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx
  1022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
  1022dd:	75 d1                	jne    1022b0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  1022df:	83 c4 04             	add    $0x4,%esp
  1022e2:	5b                   	pop    %ebx
  1022e3:	5e                   	pop    %esi
  1022e4:	f3 c3                	repz ret 
  1022e6:	8d 76 00             	lea    0x0(%esi),%esi
  1022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
  1022f0:	8b 15 84 da 10 00    	mov    0x10da84,%edx
{
  1022f6:	8b 44 24 04          	mov    0x4(%esp),%eax
  if(!ismp)
  1022fa:	85 d2                	test   %edx,%edx
  1022fc:	74 2c                	je     10232a <ioapicenable+0x3a>
  ioapic->reg = reg;
  1022fe:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  102304:	8d 50 20             	lea    0x20(%eax),%edx
  102307:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
  10230b:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  10230d:	8b 0d 34 da 10 00    	mov    0x10da34,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102313:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
  102316:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102319:	8b 54 24 08          	mov    0x8(%esp),%edx
  ioapic->reg = reg;
  10231d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  10231f:	a1 34 da 10 00       	mov    0x10da34,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102324:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
  102327:	89 50 10             	mov    %edx,0x10(%eax)
  10232a:	f3 c3                	repz ret 
  10232c:	66 90                	xchg   %ax,%ax
  10232e:	66 90                	xchg   %ax,%ax

00102330 <kfree>:
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102330:	55                   	push   %ebp
  102331:	57                   	push   %edi
  102332:	56                   	push   %esi
  102333:	53                   	push   %ebx
  102334:	83 ec 0c             	sub    $0xc,%esp
  102337:	8b 7c 24 24          	mov    0x24(%esp),%edi
  10233b:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  10233f:	85 ff                	test   %edi,%edi
  102341:	0f 8e eb 00 00 00    	jle    102432 <kfree+0x102>
  102347:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  10234d:	0f 85 df 00 00 00    	jne    102432 <kfree+0x102>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102353:	83 ec 04             	sub    $0x4,%esp

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  102356:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  memset(v, 1, len);
  102359:	57                   	push   %edi
  10235a:	6a 01                	push   $0x1
  10235c:	53                   	push   %ebx
  10235d:	e8 1e 1a 00 00       	call   103d80 <memset>
  acquire(&kmem.lock);
  102362:	c7 04 24 40 da 10 00 	movl   $0x10da40,(%esp)
  102369:	e8 22 18 00 00       	call   103b90 <acquire>
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10236e:	a1 74 da 10 00       	mov    0x10da74,%eax
  102373:	83 c4 10             	add    $0x10,%esp
  102376:	85 c0                	test   %eax,%eax
  102378:	0f 84 a0 00 00 00    	je     10241e <kfree+0xee>
  10237e:	39 c6                	cmp    %eax,%esi
  102380:	0f 82 98 00 00 00    	jb     10241e <kfree+0xee>
    rend = (struct run*)((char*)r + r->len);
  102386:	8b 48 04             	mov    0x4(%eax),%ecx
    if(r <= p && p < rend)
  102389:	39 c3                	cmp    %eax,%ebx
    rend = (struct run*)((char*)r + r->len);
  10238b:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    if(r <= p && p < rend)
  10238e:	72 08                	jb     102398 <kfree+0x68>
  102390:	39 d3                	cmp    %edx,%ebx
  102392:	0f 82 8d 00 00 00    	jb     102425 <kfree+0xf5>
      panic("freeing free page");
    if(rend == p){  // r before p: expand r to include p
  102398:	39 d3                	cmp    %edx,%ebx
  10239a:	74 54                	je     1023f0 <kfree+0xc0>
        r->len += r->next->len;
        r->next = r->next->next;
      }
      goto out;
    }
    if(pend == r){  // p before r: expand p to include, replace r
  10239c:	39 c6                	cmp    %eax,%esi
  10239e:	75 22                	jne    1023c2 <kfree+0x92>
  1023a0:	eb 69                	jmp    10240b <kfree+0xdb>
  1023a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023a8:	39 c6                	cmp    %eax,%esi
  1023aa:	72 1e                	jb     1023ca <kfree+0x9a>
    rend = (struct run*)((char*)r + r->len);
  1023ac:	8b 48 04             	mov    0x4(%eax),%ecx
    if(r <= p && p < rend)
  1023af:	39 c3                	cmp    %eax,%ebx
    rend = (struct run*)((char*)r + r->len);
  1023b1:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    if(r <= p && p < rend)
  1023b4:	72 04                	jb     1023ba <kfree+0x8a>
  1023b6:	39 d3                	cmp    %edx,%ebx
  1023b8:	72 6b                	jb     102425 <kfree+0xf5>
    if(rend == p){  // r before p: expand r to include p
  1023ba:	39 d3                	cmp    %edx,%ebx
  1023bc:	74 32                	je     1023f0 <kfree+0xc0>
    if(pend == r){  // p before r: expand p to include, replace r
  1023be:	39 c6                	cmp    %eax,%esi
  1023c0:	74 4e                	je     102410 <kfree+0xe0>
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023c2:	89 c5                	mov    %eax,%ebp
  1023c4:	8b 00                	mov    (%eax),%eax
  1023c6:	85 c0                	test   %eax,%eax
  1023c8:	75 de                	jne    1023a8 <kfree+0x78>
      *rp = p;
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1023ca:	89 7b 04             	mov    %edi,0x4(%ebx)
  p->next = r;
  1023cd:	89 03                	mov    %eax,(%ebx)
  *rp = p;
  1023cf:	89 5d 00             	mov    %ebx,0x0(%ebp)

 out:
  release(&kmem.lock);
  1023d2:	c7 44 24 20 40 da 10 	movl   $0x10da40,0x20(%esp)
  1023d9:	00 
}
  1023da:	83 c4 0c             	add    $0xc,%esp
  1023dd:	5b                   	pop    %ebx
  1023de:	5e                   	pop    %esi
  1023df:	5f                   	pop    %edi
  1023e0:	5d                   	pop    %ebp
  release(&kmem.lock);
  1023e1:	e9 4a 19 00 00       	jmp    103d30 <release>
  1023e6:	8d 76 00             	lea    0x0(%esi),%esi
  1023e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(r->next && r->next == pend){  // r now next to r->next?
  1023f0:	8b 10                	mov    (%eax),%edx
      r->len += len;
  1023f2:	01 f9                	add    %edi,%ecx
  1023f4:	89 48 04             	mov    %ecx,0x4(%eax)
      if(r->next && r->next == pend){  // r now next to r->next?
  1023f7:	39 d6                	cmp    %edx,%esi
  1023f9:	75 d7                	jne    1023d2 <kfree+0xa2>
  1023fb:	85 d2                	test   %edx,%edx
  1023fd:	74 d3                	je     1023d2 <kfree+0xa2>
        r->len += r->next->len;
  1023ff:	03 4a 04             	add    0x4(%edx),%ecx
  102402:	89 48 04             	mov    %ecx,0x4(%eax)
        r->next = r->next->next;
  102405:	8b 12                	mov    (%edx),%edx
  102407:	89 10                	mov    %edx,(%eax)
  102409:	eb c7                	jmp    1023d2 <kfree+0xa2>
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10240b:	bd 74 da 10 00       	mov    $0x10da74,%ebp
      p->len = len + r->len;
  102410:	01 f9                	add    %edi,%ecx
  102412:	89 4b 04             	mov    %ecx,0x4(%ebx)
      p->next = r->next;
  102415:	8b 06                	mov    (%esi),%eax
  102417:	89 03                	mov    %eax,(%ebx)
      *rp = p;
  102419:	89 5d 00             	mov    %ebx,0x0(%ebp)
      goto out;
  10241c:	eb b4                	jmp    1023d2 <kfree+0xa2>
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10241e:	bd 74 da 10 00       	mov    $0x10da74,%ebp
  102423:	eb a5                	jmp    1023ca <kfree+0x9a>
      panic("freeing free page");
  102425:	83 ec 0c             	sub    $0xc,%esp
  102428:	68 5c 5f 10 00       	push   $0x105f5c
  10242d:	e8 de e3 ff ff       	call   100810 <panic>
    panic("kfree");
  102432:	83 ec 0c             	sub    $0xc,%esp
  102435:	68 56 5f 10 00       	push   $0x105f56
  10243a:	e8 d1 e3 ff ff       	call   100810 <panic>
  10243f:	90                   	nop

00102440 <kinit>:
{
  102440:	83 ec 14             	sub    $0x14,%esp
  initlock(&kmem.lock, "kmem");
  102443:	68 6e 5f 10 00       	push   $0x105f6e
  102448:	68 40 da 10 00       	push   $0x10da40
  10244d:	e8 1e 17 00 00       	call   103b70 <initlock>
  cprintf("mem = %d\n", len);
  102452:	58                   	pop    %eax
  102453:	5a                   	pop    %edx
  102454:	68 00 00 10 00       	push   $0x100000
  102459:	68 73 5f 10 00       	push   $0x105f73
  10245e:	e8 2d e2 ff ff       	call   100690 <cprintf>
  kfree(p, len);
  102463:	59                   	pop    %ecx
  102464:	58                   	pop    %eax
  p = (char*)(((uint)end + PAGE) & ~(PAGE-1));
  102465:	b8 24 18 11 00       	mov    $0x111824,%eax
  kfree(p, len);
  10246a:	68 00 00 10 00       	push   $0x100000
  p = (char*)(((uint)end + PAGE) & ~(PAGE-1));
  10246f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  kfree(p, len);
  102474:	50                   	push   %eax
  102475:	e8 b6 fe ff ff       	call   102330 <kfree>
}
  10247a:	83 c4 1c             	add    $0x1c,%esp
  10247d:	c3                   	ret    
  10247e:	66 90                	xchg   %ax,%ax

00102480 <kalloc>:
// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(int n)
{
  102480:	56                   	push   %esi
  102481:	53                   	push   %ebx
  102482:	83 ec 04             	sub    $0x4,%esp
  102485:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  102489:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  10248f:	0f 85 96 00 00 00    	jne    10252b <kalloc+0xab>
  102495:	85 f6                	test   %esi,%esi
  102497:	0f 8e 8e 00 00 00    	jle    10252b <kalloc+0xab>
    panic("kalloc");

  acquire(&kmem.lock);
  10249d:	83 ec 0c             	sub    $0xc,%esp
  1024a0:	68 40 da 10 00       	push   $0x10da40
  1024a5:	e8 e6 16 00 00       	call   103b90 <acquire>
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  1024aa:	8b 0d 74 da 10 00    	mov    0x10da74,%ecx
  1024b0:	83 c4 10             	add    $0x10,%esp
  1024b3:	85 c9                	test   %ecx,%ecx
  1024b5:	74 18                	je     1024cf <kalloc+0x4f>
    if(r->len >= n){
  1024b7:	8b 41 04             	mov    0x4(%ecx),%eax
  1024ba:	39 c6                	cmp    %eax,%esi
  1024bc:	7f 0b                	jg     1024c9 <kalloc+0x49>
  1024be:	eb 62                	jmp    102522 <kalloc+0xa2>
  1024c0:	8b 42 04             	mov    0x4(%edx),%eax
  1024c3:	39 c6                	cmp    %eax,%esi
  1024c5:	7e 31                	jle    1024f8 <kalloc+0x78>
  1024c7:	89 d1                	mov    %edx,%ecx
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  1024c9:	8b 11                	mov    (%ecx),%edx
  1024cb:	85 d2                	test   %edx,%edx
  1024cd:	75 f1                	jne    1024c0 <kalloc+0x40>
        *rp = r->next;
      release(&kmem.lock);
      return p;
    }
  }
  release(&kmem.lock);
  1024cf:	83 ec 0c             	sub    $0xc,%esp

  cprintf("kalloc: out of memory\n");
  return 0;
  1024d2:	31 f6                	xor    %esi,%esi
  release(&kmem.lock);
  1024d4:	68 40 da 10 00       	push   $0x10da40
  1024d9:	e8 52 18 00 00       	call   103d30 <release>
  cprintf("kalloc: out of memory\n");
  1024de:	c7 04 24 84 5f 10 00 	movl   $0x105f84,(%esp)
  1024e5:	e8 a6 e1 ff ff       	call   100690 <cprintf>
  return 0;
  1024ea:	83 c4 10             	add    $0x10,%esp
}
  1024ed:	89 f0                	mov    %esi,%eax
  1024ef:	83 c4 04             	add    $0x4,%esp
  1024f2:	5b                   	pop    %ebx
  1024f3:	5e                   	pop    %esi
  1024f4:	c3                   	ret    
  1024f5:	8d 76 00             	lea    0x0(%esi),%esi
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  1024f8:	89 cb                	mov    %ecx,%ebx
      r->len -= n;
  1024fa:	29 f0                	sub    %esi,%eax
      if(r->len == 0)
  1024fc:	85 c0                	test   %eax,%eax
      r->len -= n;
  1024fe:	89 42 04             	mov    %eax,0x4(%edx)
      p = (char*)r + r->len;
  102501:	8d 34 02             	lea    (%edx,%eax,1),%esi
      if(r->len == 0)
  102504:	75 04                	jne    10250a <kalloc+0x8a>
        *rp = r->next;
  102506:	8b 02                	mov    (%edx),%eax
  102508:	89 03                	mov    %eax,(%ebx)
      release(&kmem.lock);
  10250a:	83 ec 0c             	sub    $0xc,%esp
  10250d:	68 40 da 10 00       	push   $0x10da40
  102512:	e8 19 18 00 00       	call   103d30 <release>
      return p;
  102517:	83 c4 10             	add    $0x10,%esp
}
  10251a:	89 f0                	mov    %esi,%eax
  10251c:	83 c4 04             	add    $0x4,%esp
  10251f:	5b                   	pop    %ebx
  102520:	5e                   	pop    %esi
  102521:	c3                   	ret    
    if(r->len >= n){
  102522:	89 ca                	mov    %ecx,%edx
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  102524:	bb 74 da 10 00       	mov    $0x10da74,%ebx
  102529:	eb cf                	jmp    1024fa <kalloc+0x7a>
    panic("kalloc");
  10252b:	83 ec 0c             	sub    $0xc,%esp
  10252e:	68 7d 5f 10 00       	push   $0x105f7d
  102533:	e8 d8 e2 ff ff       	call   100810 <panic>
  102538:	66 90                	xchg   %ax,%ax
  10253a:	66 90                	xchg   %ax,%ax
  10253c:	66 90                	xchg   %ax,%ax
  10253e:	66 90                	xchg   %ax,%ax

00102540 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102540:	ba 64 00 00 00       	mov    $0x64,%edx
  102545:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  102546:	a8 01                	test   $0x1,%al
  102548:	0f 84 c2 00 00 00    	je     102610 <kbdgetc+0xd0>
  10254e:	ba 60 00 00 00       	mov    $0x60,%edx
  102553:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  102554:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
  102557:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
  10255d:	0f 84 9d 00 00 00    	je     102600 <kbdgetc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102563:	84 c0                	test   %al,%al
  102565:	78 59                	js     1025c0 <kbdgetc+0x80>
{
  102567:	53                   	push   %ebx
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  102568:	8b 1d 34 a8 10 00    	mov    0x10a834,%ebx
  10256e:	f6 c3 40             	test   $0x40,%bl
  102571:	74 09                	je     10257c <kbdgetc+0x3c>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  102573:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
  102576:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
  102579:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
  10257c:	0f b6 8a c0 60 10 00 	movzbl 0x1060c0(%edx),%ecx
  shift ^= togglecode[data];
  102583:	0f b6 82 c0 5f 10 00 	movzbl 0x105fc0(%edx),%eax
  shift |= shiftcode[data];
  10258a:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
  10258c:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
  10258e:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
  102590:	89 0d 34 a8 10 00    	mov    %ecx,0x10a834
  c = charcode[shift & (CTL | SHIFT)][data];
  102596:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
  102599:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
  10259c:	8b 04 85 a0 5f 10 00 	mov    0x105fa0(,%eax,4),%eax
  1025a3:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
  1025a7:	74 0b                	je     1025b4 <kbdgetc+0x74>
    if('a' <= c && c <= 'z')
  1025a9:	8d 50 9f             	lea    -0x61(%eax),%edx
  1025ac:	83 fa 19             	cmp    $0x19,%edx
  1025af:	77 3f                	ja     1025f0 <kbdgetc+0xb0>
      c += 'A' - 'a';
  1025b1:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1025b4:	5b                   	pop    %ebx
  1025b5:	c3                   	ret    
  1025b6:	8d 76 00             	lea    0x0(%esi),%esi
  1025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    data = (shift & E0ESC ? data : data & 0x7F);
  1025c0:	8b 0d 34 a8 10 00    	mov    0x10a834,%ecx
  1025c6:	83 e0 7f             	and    $0x7f,%eax
  1025c9:	f6 c1 40             	test   $0x40,%cl
  1025cc:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
  1025cf:	0f b6 82 c0 60 10 00 	movzbl 0x1060c0(%edx),%eax
  1025d6:	83 c8 40             	or     $0x40,%eax
  1025d9:	0f b6 c0             	movzbl %al,%eax
  1025dc:	f7 d0                	not    %eax
  1025de:	21 c8                	and    %ecx,%eax
  1025e0:	a3 34 a8 10 00       	mov    %eax,0x10a834
    return 0;
  1025e5:	31 c0                	xor    %eax,%eax
  1025e7:	c3                   	ret    
  1025e8:	90                   	nop
  1025e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
  1025f0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
  1025f3:	8d 50 20             	lea    0x20(%eax),%edx
}
  1025f6:	5b                   	pop    %ebx
      c += 'a' - 'A';
  1025f7:	83 f9 19             	cmp    $0x19,%ecx
  1025fa:	0f 46 c2             	cmovbe %edx,%eax
}
  1025fd:	c3                   	ret    
  1025fe:	66 90                	xchg   %ax,%ax
    shift |= E0ESC;
  102600:	83 0d 34 a8 10 00 40 	orl    $0x40,0x10a834
    return 0;
  102607:	31 c0                	xor    %eax,%eax
  102609:	c3                   	ret    
  10260a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102615:	c3                   	ret    
  102616:	8d 76 00             	lea    0x0(%esi),%esi
  102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102620 <kbdintr>:

void
kbdintr(void)
{
  102620:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
  102623:	68 40 25 10 00       	push   $0x102540
  102628:	e8 63 e2 ff ff       	call   100890 <consoleintr>
}
  10262d:	83 c4 1c             	add    $0x1c,%esp
  102630:	c3                   	ret    
  102631:	66 90                	xchg   %ax,%ax
  102633:	66 90                	xchg   %ax,%ax
  102635:	66 90                	xchg   %ax,%ax
  102637:	66 90                	xchg   %ax,%ax
  102639:	66 90                	xchg   %ax,%ax
  10263b:	66 90                	xchg   %ax,%ax
  10263d:	66 90                	xchg   %ax,%ax
  10263f:	90                   	nop

00102640 <lapicinit>:
}

void
lapicinit(int c)
{
  if(!lapic) 
  102640:	a1 78 da 10 00       	mov    0x10da78,%eax
  102645:	85 c0                	test   %eax,%eax
  102647:	0f 84 c3 00 00 00    	je     102710 <lapicinit+0xd0>
  lapic[index] = value;
  10264d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  102654:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102657:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10265a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  102661:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102664:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  102667:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  10266e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  102671:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  102674:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  10267b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  10267e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  102681:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102688:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10268b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10268e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  102695:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102698:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  10269b:	8b 50 30             	mov    0x30(%eax),%edx
  10269e:	c1 ea 10             	shr    $0x10,%edx
  1026a1:	80 fa 03             	cmp    $0x3,%dl
  1026a4:	77 72                	ja     102718 <lapicinit+0xd8>
  lapic[index] = value;
  1026a6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  1026ad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026b0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1026b3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026bd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1026c0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026c7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026ca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1026cd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1026d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1026da:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1026e1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026e4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1026e7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1026ee:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  1026f1:	8b 50 20             	mov    0x20(%eax),%edx
  1026f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  1026f8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
  1026fe:	80 e6 10             	and    $0x10,%dh
  102701:	75 f5                	jne    1026f8 <lapicinit+0xb8>
  lapic[index] = value;
  102703:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  10270a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10270d:	8b 40 20             	mov    0x20(%eax),%eax
  102710:	f3 c3                	repz ret 
  102712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
  102718:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  10271f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102722:	8b 50 20             	mov    0x20(%eax),%edx
  102725:	e9 7c ff ff ff       	jmp    1026a6 <lapicinit+0x66>
  10272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102730 <cpunum>:
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102730:	9c                   	pushf  
  102731:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  102732:	f6 c4 02             	test   $0x2,%ah
  102735:	74 12                	je     102749 <cpunum+0x19>
    static int n;
    if(n++ == 0)
  102737:	a1 38 a8 10 00       	mov    0x10a838,%eax
  10273c:	8d 50 01             	lea    0x1(%eax),%edx
  10273f:	85 c0                	test   %eax,%eax
  102741:	89 15 38 a8 10 00    	mov    %edx,0x10a838
  102747:	74 17                	je     102760 <cpunum+0x30>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  102749:	a1 78 da 10 00       	mov    0x10da78,%eax
  10274e:	85 c0                	test   %eax,%eax
  102750:	74 3e                	je     102790 <cpunum+0x60>
    return lapic[ID]>>24;
  102752:	8b 40 20             	mov    0x20(%eax),%eax
  102755:	c1 e8 18             	shr    $0x18,%eax
  102758:	c3                   	ret    
  102759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  102760:	83 ec 14             	sub    $0x14,%esp
      cprintf("cpu called from %x with interrupts enabled\n",
  102763:	ff 74 24 14          	pushl  0x14(%esp)
  102767:	68 c0 61 10 00       	push   $0x1061c0
  10276c:	e8 1f df ff ff       	call   100690 <cprintf>
  if(lapic)
  102771:	a1 78 da 10 00       	mov    0x10da78,%eax
      cprintf("cpu called from %x with interrupts enabled\n",
  102776:	83 c4 10             	add    $0x10,%esp
  if(lapic)
  102779:	85 c0                	test   %eax,%eax
  10277b:	74 1b                	je     102798 <cpunum+0x68>
    return lapic[ID]>>24;
  10277d:	8b 40 20             	mov    0x20(%eax),%eax
  102780:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102783:	83 c4 0c             	add    $0xc,%esp
  102786:	c3                   	ret    
  102787:	89 f6                	mov    %esi,%esi
  102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  102790:	31 c0                	xor    %eax,%eax
  102792:	c3                   	ret    
  102793:	90                   	nop
  102794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102798:	31 c0                	xor    %eax,%eax
  10279a:	eb e7                	jmp    102783 <cpunum+0x53>
  10279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001027a0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  1027a0:	a1 78 da 10 00       	mov    0x10da78,%eax
  1027a5:	85 c0                	test   %eax,%eax
  1027a7:	74 0d                	je     1027b6 <lapiceoi+0x16>
  lapic[index] = value;
  1027a9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1027b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1027b3:	8b 40 20             	mov    0x20(%eax),%eax
  1027b6:	f3 c3                	repz ret 
  1027b8:	90                   	nop
  1027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001027c0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1027c0:	f3 c3                	repz ret 
  1027c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001027d0 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  1027d0:	53                   	push   %ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1027d1:	ba 70 00 00 00       	mov    $0x70,%edx
  1027d6:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  1027da:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  1027de:	b8 0f 00 00 00       	mov    $0xf,%eax
  1027e3:	ee                   	out    %al,(%dx)
  1027e4:	ba 71 00 00 00       	mov    $0x71,%edx
  1027e9:	b8 0a 00 00 00       	mov    $0xa,%eax
  1027ee:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  1027ef:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
  1027f1:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
  1027f4:	66 a3 67 04 00 00    	mov    %ax,0x467
  wrv[1] = addr >> 4;
  1027fa:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
  1027fc:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
  1027ff:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
  102802:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
  102804:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
  102807:	66 a3 69 04 00 00    	mov    %ax,0x469
  lapic[index] = value;
  10280d:	a1 78 da 10 00       	mov    0x10da78,%eax
  102812:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102818:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
  10281b:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  102822:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102825:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
  102828:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  10282f:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102832:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
  102835:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10283b:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
  10283e:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102844:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
  102847:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10284d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  102850:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102856:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
  102859:	5b                   	pop    %ebx
  10285a:	c3                   	ret    
  10285b:	66 90                	xchg   %ax,%ax
  10285d:	66 90                	xchg   %ax,%ax
  10285f:	90                   	nop

00102860 <mpmain>:
{
  102860:	53                   	push   %ebx
  102861:	83 ec 08             	sub    $0x8,%esp
  if(cpunum() != mpbcpu())
  102864:	e8 c7 fe ff ff       	call   102730 <cpunum>
  102869:	89 c3                	mov    %eax,%ebx
  10286b:	e8 d0 00 00 00       	call   102940 <mpbcpu>
  102870:	39 c3                	cmp    %eax,%ebx
  102872:	74 11                	je     102885 <mpmain+0x25>
    lapicinit(cpunum());
  102874:	e8 b7 fe ff ff       	call   102730 <cpunum>
  102879:	83 ec 0c             	sub    $0xc,%esp
  10287c:	50                   	push   %eax
  10287d:	e8 be fd ff ff       	call   102640 <lapicinit>
  102882:	83 c4 10             	add    $0x10,%esp
  ksegment();
  102885:	e8 46 09 00 00       	call   1031d0 <ksegment>
  cprintf("cpu%d: mpmain\n", cpu->id);
  10288a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  102890:	83 ec 08             	sub    $0x8,%esp
  102893:	0f b6 00             	movzbl (%eax),%eax
  102896:	50                   	push   %eax
  102897:	68 ec 61 10 00       	push   $0x1061ec
  10289c:	e8 ef dd ff ff       	call   100690 <cprintf>
  idtinit();
  1028a1:	e8 8a 26 00 00       	call   104f30 <idtinit>
  xchg(&cpu->booted, 1);
  1028a6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  asm volatile("lock; xchgl %0, %1" :
  1028ad:	b8 01 00 00 00       	mov    $0x1,%eax
  1028b2:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  cprintf("cpu%d: scheduling\n", cpu->id);
  1028b9:	58                   	pop    %eax
  1028ba:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1028c0:	5a                   	pop    %edx
  1028c1:	0f b6 00             	movzbl (%eax),%eax
  1028c4:	50                   	push   %eax
  1028c5:	68 fb 61 10 00       	push   $0x1061fb
  1028ca:	e8 c1 dd ff ff       	call   100690 <cprintf>
  scheduler();
  1028cf:	e8 4c 0d 00 00       	call   103620 <scheduler>
  1028d4:	66 90                	xchg   %ax,%ax
  1028d6:	66 90                	xchg   %ax,%ax
  1028d8:	66 90                	xchg   %ax,%ax
  1028da:	66 90                	xchg   %ax,%ax
  1028dc:	66 90                	xchg   %ax,%ax
  1028de:	66 90                	xchg   %ax,%ax

001028e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  1028e0:	57                   	push   %edi
  1028e1:	56                   	push   %esi
  1028e2:	89 c6                	mov    %eax,%esi
  1028e4:	53                   	push   %ebx
  uchar *e, *p;

  e = addr+len;
  1028e5:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
  1028e8:	39 d8                	cmp    %ebx,%eax
  1028ea:	73 3a                	jae    102926 <mpsearch1+0x46>
  1028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  1028f0:	83 ec 04             	sub    $0x4,%esp
  1028f3:	8d 7e 10             	lea    0x10(%esi),%edi
  1028f6:	6a 04                	push   $0x4
  1028f8:	68 35 62 10 00       	push   $0x106235
  1028fd:	56                   	push   %esi
  1028fe:	e8 9d 14 00 00       	call   103da0 <memcmp>
  102903:	83 c4 10             	add    $0x10,%esp
  102906:	85 c0                	test   %eax,%eax
  102908:	75 16                	jne    102920 <mpsearch1+0x40>
  10290a:	8d 7e 10             	lea    0x10(%esi),%edi
  10290d:	89 f2                	mov    %esi,%edx
  10290f:	90                   	nop
    sum += addr[i];
  102910:	0f b6 0a             	movzbl (%edx),%ecx
  102913:	83 c2 01             	add    $0x1,%edx
  102916:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  102918:	39 fa                	cmp    %edi,%edx
  10291a:	75 f4                	jne    102910 <mpsearch1+0x30>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10291c:	84 c0                	test   %al,%al
  10291e:	74 0c                	je     10292c <mpsearch1+0x4c>
  for(p = addr; p < e; p += sizeof(struct mp))
  102920:	39 fb                	cmp    %edi,%ebx
  102922:	89 fe                	mov    %edi,%esi
  102924:	77 ca                	ja     1028f0 <mpsearch1+0x10>
      return (struct mp*)p;
  return 0;
}
  102926:	5b                   	pop    %ebx
  return 0;
  102927:	31 c0                	xor    %eax,%eax
}
  102929:	5e                   	pop    %esi
  10292a:	5f                   	pop    %edi
  10292b:	c3                   	ret    
  10292c:	89 f0                	mov    %esi,%eax
  10292e:	5b                   	pop    %ebx
  10292f:	5e                   	pop    %esi
  102930:	5f                   	pop    %edi
  102931:	c3                   	ret    
  102932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102940 <mpbcpu>:
  return bcpu-cpus;
  102940:	a1 3c a8 10 00       	mov    0x10a83c,%eax
  102945:	2d a0 da 10 00       	sub    $0x10daa0,%eax
  10294a:	c1 f8 02             	sar    $0x2,%eax
  10294d:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
  102953:	c3                   	ret    
  102954:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10295a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102960 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  102960:	55                   	push   %ebp
  102961:	57                   	push   %edi
  102962:	56                   	push   %esi
  102963:	53                   	push   %ebx
  102964:	83 ec 1c             	sub    $0x1c,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  102967:	c7 05 3c a8 10 00 a0 	movl   $0x10daa0,0x10a83c
  10296e:	da 10 00 
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102971:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102978:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  10297f:	c1 e0 08             	shl    $0x8,%eax
  102982:	09 d0                	or     %edx,%eax
  102984:	c1 e0 04             	shl    $0x4,%eax
  102987:	85 c0                	test   %eax,%eax
  102989:	75 1b                	jne    1029a6 <mpinit+0x46>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  10298b:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102992:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102999:	c1 e0 08             	shl    $0x8,%eax
  10299c:	09 d0                	or     %edx,%eax
  10299e:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  1029a1:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1((uchar*)p, 1024)))
  1029a6:	ba 00 04 00 00       	mov    $0x400,%edx
  1029ab:	e8 30 ff ff ff       	call   1028e0 <mpsearch1>
  1029b0:	85 c0                	test   %eax,%eax
  1029b2:	89 c6                	mov    %eax,%esi
  1029b4:	0f 84 56 01 00 00    	je     102b10 <mpinit+0x1b0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1029ba:	8b 7e 04             	mov    0x4(%esi),%edi
  1029bd:	85 ff                	test   %edi,%edi
  1029bf:	0f 84 c3 00 00 00    	je     102a88 <mpinit+0x128>
  if(memcmp(conf, "PCMP", 4) != 0)
  1029c5:	83 ec 04             	sub    $0x4,%esp
  1029c8:	6a 04                	push   $0x4
  1029ca:	68 3a 62 10 00       	push   $0x10623a
  1029cf:	57                   	push   %edi
  1029d0:	e8 cb 13 00 00       	call   103da0 <memcmp>
  1029d5:	83 c4 10             	add    $0x10,%esp
  1029d8:	85 c0                	test   %eax,%eax
  1029da:	0f 85 a8 00 00 00    	jne    102a88 <mpinit+0x128>
  if(conf->version != 1 && conf->version != 4)
  1029e0:	0f b6 57 06          	movzbl 0x6(%edi),%edx
  1029e4:	80 fa 01             	cmp    $0x1,%dl
  1029e7:	0f 95 c3             	setne  %bl
  1029ea:	80 fa 04             	cmp    $0x4,%dl
  1029ed:	0f 95 c2             	setne  %dl
  1029f0:	20 d3                	and    %dl,%bl
  1029f2:	0f 85 90 00 00 00    	jne    102a88 <mpinit+0x128>
  if(sum((uchar*)conf, conf->length) != 0)
  1029f8:	0f b7 4f 04          	movzwl 0x4(%edi),%ecx
  for(i=0; i<len; i++)
  1029fc:	85 c9                	test   %ecx,%ecx
  1029fe:	74 19                	je     102a19 <mpinit+0xb9>
  102a00:	31 d2                	xor    %edx,%edx
  102a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  102a08:	0f b6 2c 17          	movzbl (%edi,%edx,1),%ebp
  for(i=0; i<len; i++)
  102a0c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  102a0f:	01 e8                	add    %ebp,%eax
  for(i=0; i<len; i++)
  102a11:	39 d1                	cmp    %edx,%ecx
  102a13:	75 f3                	jne    102a08 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
  102a15:	84 c0                	test   %al,%al
  102a17:	75 6f                	jne    102a88 <mpinit+0x128>
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102a19:	8b 47 24             	mov    0x24(%edi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a1c:	8d 57 2c             	lea    0x2c(%edi),%edx
  ismp = 1;
  102a1f:	c7 05 84 da 10 00 01 	movl   $0x1,0x10da84
  102a26:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102a29:	a3 78 da 10 00       	mov    %eax,0x10da78
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a2e:	8d 04 0f             	lea    (%edi,%ecx,1),%eax
  102a31:	39 c2                	cmp    %eax,%edx
  102a33:	73 38                	jae    102a6d <mpinit+0x10d>
  102a35:	8b 3d 3c a8 10 00    	mov    0x10a83c,%edi
  102a3b:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102a3f:	89 de                	mov    %ebx,%esi
    switch(*p){
  102a41:	0f b6 0a             	movzbl (%edx),%ecx
  102a44:	80 f9 04             	cmp    $0x4,%cl
  102a47:	0f 87 a3 00 00 00    	ja     102af0 <mpinit+0x190>
  102a4d:	ff 24 8d 84 62 10 00 	jmp    *0x106284(,%ecx,4)
  102a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102a58:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102a5b:	39 d0                	cmp    %edx,%eax
  102a5d:	77 e2                	ja     102a41 <mpinit+0xe1>
  102a5f:	89 f3                	mov    %esi,%ebx
  102a61:	8b 74 24 0c          	mov    0xc(%esp),%esi
  102a65:	84 db                	test   %bl,%bl
  102a67:	0f 85 c1 00 00 00    	jne    102b2e <mpinit+0x1ce>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }
  if(mp->imcrp){
  102a6d:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  102a71:	74 15                	je     102a88 <mpinit+0x128>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a73:	ba 22 00 00 00       	mov    $0x22,%edx
  102a78:	b8 70 00 00 00       	mov    $0x70,%eax
  102a7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102a7e:	ba 23 00 00 00       	mov    $0x23,%edx
  102a83:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  102a84:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102a87:	ee                   	out    %al,(%dx)
  }
}
  102a88:	83 c4 1c             	add    $0x1c,%esp
  102a8b:	5b                   	pop    %ebx
  102a8c:	5e                   	pop    %esi
  102a8d:	5f                   	pop    %edi
  102a8e:	5d                   	pop    %ebp
  102a8f:	c3                   	ret    
      if(ncpu != proc->apicid) {
  102a90:	0f b6 6a 01          	movzbl 0x1(%edx),%ebp
  102a94:	8b 0d 80 e0 10 00    	mov    0x10e080,%ecx
  102a9a:	39 cd                	cmp    %ecx,%ebp
  102a9c:	89 eb                	mov    %ebp,%ebx
  102a9e:	0f 85 9d 00 00 00    	jne    102b41 <mpinit+0x1e1>
      if(proc->flags & MPBOOT)
  102aa4:	f6 42 03 02          	testb  $0x2,0x3(%edx)
  102aa8:	74 11                	je     102abb <mpinit+0x15b>
        bcpu = &cpus[ncpu];
  102aaa:	69 f9 bc 00 00 00    	imul   $0xbc,%ecx,%edi
  102ab0:	be 01 00 00 00       	mov    $0x1,%esi
  102ab5:	81 c7 a0 da 10 00    	add    $0x10daa0,%edi
      cpus[ncpu].id = ncpu;
  102abb:	69 e9 bc 00 00 00    	imul   $0xbc,%ecx,%ebp
      ncpu++;
  102ac1:	83 c1 01             	add    $0x1,%ecx
      p += sizeof(struct mpproc);
  102ac4:	83 c2 14             	add    $0x14,%edx
      ncpu++;
  102ac7:	89 0d 80 e0 10 00    	mov    %ecx,0x10e080
      cpus[ncpu].id = ncpu;
  102acd:	88 9d a0 da 10 00    	mov    %bl,0x10daa0(%ebp)
      continue;
  102ad3:	eb 86                	jmp    102a5b <mpinit+0xfb>
  102ad5:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
  102ad8:	0f b6 4a 01          	movzbl 0x1(%edx),%ecx
      p += sizeof(struct mpioapic);
  102adc:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
  102adf:	88 0d 80 da 10 00    	mov    %cl,0x10da80
      continue;
  102ae5:	e9 71 ff ff ff       	jmp    102a5b <mpinit+0xfb>
  102aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102af0:	89 f3                	mov    %esi,%ebx
  102af2:	84 db                	test   %bl,%bl
  102af4:	75 43                	jne    102b39 <mpinit+0x1d9>
      cprintf("mpinit: unknown config type %x\n", *p);
  102af6:	83 ec 08             	sub    $0x8,%esp
  102af9:	51                   	push   %ecx
  102afa:	68 64 62 10 00       	push   $0x106264
  102aff:	e8 8c db ff ff       	call   100690 <cprintf>
      panic("mpinit");
  102b04:	c7 04 24 5a 62 10 00 	movl   $0x10625a,(%esp)
  102b0b:	e8 00 dd ff ff       	call   100810 <panic>
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102b10:	ba 00 00 01 00       	mov    $0x10000,%edx
  102b15:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102b1a:	e8 c1 fd ff ff       	call   1028e0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102b1f:	85 c0                	test   %eax,%eax
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102b21:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102b23:	0f 85 91 fe ff ff    	jne    1029ba <mpinit+0x5a>
  102b29:	e9 5a ff ff ff       	jmp    102a88 <mpinit+0x128>
  102b2e:	89 3d 3c a8 10 00    	mov    %edi,0x10a83c
  102b34:	e9 34 ff ff ff       	jmp    102a6d <mpinit+0x10d>
  102b39:	89 3d 3c a8 10 00    	mov    %edi,0x10a83c
  102b3f:	eb b5                	jmp    102af6 <mpinit+0x196>
  102b41:	89 f3                	mov    %esi,%ebx
  102b43:	84 db                	test   %bl,%bl
  102b45:	74 06                	je     102b4d <mpinit+0x1ed>
  102b47:	89 3d 3c a8 10 00    	mov    %edi,0x10a83c
        cprintf("mpinit: ncpu=%d apicpid=%d", ncpu, proc->apicid);
  102b4d:	50                   	push   %eax
  102b4e:	55                   	push   %ebp
  102b4f:	51                   	push   %ecx
  102b50:	68 3f 62 10 00       	push   $0x10623f
  102b55:	e8 36 db ff ff       	call   100690 <cprintf>
        panic("mpinit");
  102b5a:	c7 04 24 5a 62 10 00 	movl   $0x10625a,(%esp)
  102b61:	e8 aa dc ff ff       	call   100810 <panic>
  102b66:	66 90                	xchg   %ax,%ax
  102b68:	66 90                	xchg   %ax,%ax
  102b6a:	66 90                	xchg   %ax,%ax
  102b6c:	66 90                	xchg   %ax,%ax
  102b6e:	66 90                	xchg   %ax,%ax

00102b70 <picenable>:
}

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
  102b70:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  102b74:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  102b79:	ba 21 00 00 00       	mov    $0x21,%edx
  102b7e:	d3 c0                	rol    %cl,%eax
  102b80:	66 23 05 00 a3 10 00 	and    0x10a300,%ax
  irqmask = mask;
  102b87:	66 a3 00 a3 10 00    	mov    %ax,0x10a300
  102b8d:	ee                   	out    %al,(%dx)
  102b8e:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
  102b93:	66 c1 e8 08          	shr    $0x8,%ax
  102b97:	ee                   	out    %al,(%dx)
  102b98:	c3                   	ret    
  102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102ba0 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102ba0:	55                   	push   %ebp
  102ba1:	57                   	push   %edi
  102ba2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102ba7:	56                   	push   %esi
  102ba8:	53                   	push   %ebx
  102ba9:	bb 21 00 00 00       	mov    $0x21,%ebx
  102bae:	89 da                	mov    %ebx,%edx
  102bb0:	ee                   	out    %al,(%dx)
  102bb1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  102bb6:	89 ca                	mov    %ecx,%edx
  102bb8:	ee                   	out    %al,(%dx)
  102bb9:	bd 11 00 00 00       	mov    $0x11,%ebp
  102bbe:	be 20 00 00 00       	mov    $0x20,%esi
  102bc3:	89 e8                	mov    %ebp,%eax
  102bc5:	89 f2                	mov    %esi,%edx
  102bc7:	ee                   	out    %al,(%dx)
  102bc8:	b8 20 00 00 00       	mov    $0x20,%eax
  102bcd:	89 da                	mov    %ebx,%edx
  102bcf:	ee                   	out    %al,(%dx)
  102bd0:	b8 04 00 00 00       	mov    $0x4,%eax
  102bd5:	ee                   	out    %al,(%dx)
  102bd6:	bf 03 00 00 00       	mov    $0x3,%edi
  102bdb:	89 f8                	mov    %edi,%eax
  102bdd:	ee                   	out    %al,(%dx)
  102bde:	bb a0 00 00 00       	mov    $0xa0,%ebx
  102be3:	89 e8                	mov    %ebp,%eax
  102be5:	89 da                	mov    %ebx,%edx
  102be7:	ee                   	out    %al,(%dx)
  102be8:	b8 28 00 00 00       	mov    $0x28,%eax
  102bed:	89 ca                	mov    %ecx,%edx
  102bef:	ee                   	out    %al,(%dx)
  102bf0:	b8 02 00 00 00       	mov    $0x2,%eax
  102bf5:	ee                   	out    %al,(%dx)
  102bf6:	89 f8                	mov    %edi,%eax
  102bf8:	ee                   	out    %al,(%dx)
  102bf9:	bf 68 00 00 00       	mov    $0x68,%edi
  102bfe:	89 f2                	mov    %esi,%edx
  102c00:	89 f8                	mov    %edi,%eax
  102c02:	ee                   	out    %al,(%dx)
  102c03:	b9 0a 00 00 00       	mov    $0xa,%ecx
  102c08:	89 c8                	mov    %ecx,%eax
  102c0a:	ee                   	out    %al,(%dx)
  102c0b:	89 f8                	mov    %edi,%eax
  102c0d:	89 da                	mov    %ebx,%edx
  102c0f:	ee                   	out    %al,(%dx)
  102c10:	89 c8                	mov    %ecx,%eax
  102c12:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102c13:	0f b7 05 00 a3 10 00 	movzwl 0x10a300,%eax
  102c1a:	66 83 f8 ff          	cmp    $0xffff,%ax
  102c1e:	74 10                	je     102c30 <picinit+0x90>
  102c20:	ba 21 00 00 00       	mov    $0x21,%edx
  102c25:	ee                   	out    %al,(%dx)
  102c26:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
  102c2b:	66 c1 e8 08          	shr    $0x8,%ax
  102c2f:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
  102c30:	5b                   	pop    %ebx
  102c31:	5e                   	pop    %esi
  102c32:	5f                   	pop    %edi
  102c33:	5d                   	pop    %ebp
  102c34:	c3                   	ret    
  102c35:	66 90                	xchg   %ax,%ax
  102c37:	66 90                	xchg   %ax,%ax
  102c39:	66 90                	xchg   %ax,%ax
  102c3b:	66 90                	xchg   %ax,%ax
  102c3d:	66 90                	xchg   %ax,%ax
  102c3f:	90                   	nop

00102c40 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102c40:	57                   	push   %edi
  102c41:	56                   	push   %esi
  102c42:	53                   	push   %ebx
  102c43:	8b 74 24 10          	mov    0x10(%esp),%esi
  102c47:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102c4b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  102c51:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102c57:	e8 04 e2 ff ff       	call   100e60 <filealloc>
  102c5c:	85 c0                	test   %eax,%eax
  102c5e:	89 06                	mov    %eax,(%esi)
  102c60:	0f 84 ac 00 00 00    	je     102d12 <pipealloc+0xd2>
  102c66:	e8 f5 e1 ff ff       	call   100e60 <filealloc>
  102c6b:	85 c0                	test   %eax,%eax
  102c6d:	89 03                	mov    %eax,(%ebx)
  102c6f:	0f 84 8b 00 00 00    	je     102d00 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  102c75:	83 ec 0c             	sub    $0xc,%esp
  102c78:	68 00 10 00 00       	push   $0x1000
  102c7d:	e8 fe f7 ff ff       	call   102480 <kalloc>
  102c82:	83 c4 10             	add    $0x10,%esp
  102c85:	85 c0                	test   %eax,%eax
  102c87:	89 c7                	mov    %eax,%edi
  102c89:	0f 84 a1 00 00 00    	je     102d30 <pipealloc+0xf0>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  102c8f:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
  102c92:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
  102c99:	00 00 00 
  p->writeopen = 1;
  102c9c:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
  102ca3:	00 00 00 
  p->nwrite = 0;
  102ca6:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
  102cad:	00 00 00 
  p->nread = 0;
  102cb0:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
  102cb7:	00 00 00 
  initlock(&p->lock, "pipe");
  102cba:	68 98 62 10 00       	push   $0x106298
  102cbf:	50                   	push   %eax
  102cc0:	e8 ab 0e 00 00       	call   103b70 <initlock>
  (*f0)->type = FD_PIPE;
  102cc5:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
  102cc7:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
  102cca:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
  102cd0:	8b 06                	mov    (%esi),%eax
  102cd2:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
  102cd6:	8b 06                	mov    (%esi),%eax
  102cd8:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102cdc:	8b 06                	mov    (%esi),%eax
  102cde:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102ce1:	8b 03                	mov    (%ebx),%eax
  102ce3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
  102ce9:	8b 03                	mov    (%ebx),%eax
  102ceb:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
  102cef:	8b 03                	mov    (%ebx),%eax
  102cf1:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102cf5:	8b 03                	mov    (%ebx),%eax
  102cf7:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
  102cfa:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
  102cfc:	5b                   	pop    %ebx
  102cfd:	5e                   	pop    %esi
  102cfe:	5f                   	pop    %edi
  102cff:	c3                   	ret    
  if(*f0)
  102d00:	8b 06                	mov    (%esi),%eax
  102d02:	85 c0                	test   %eax,%eax
  102d04:	74 1e                	je     102d24 <pipealloc+0xe4>
    fileclose(*f0);
  102d06:	83 ec 0c             	sub    $0xc,%esp
  102d09:	50                   	push   %eax
  102d0a:	e8 11 e2 ff ff       	call   100f20 <fileclose>
  102d0f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
  102d12:	8b 03                	mov    (%ebx),%eax
  102d14:	85 c0                	test   %eax,%eax
  102d16:	74 0c                	je     102d24 <pipealloc+0xe4>
    fileclose(*f1);
  102d18:	83 ec 0c             	sub    $0xc,%esp
  102d1b:	50                   	push   %eax
  102d1c:	e8 ff e1 ff ff       	call   100f20 <fileclose>
  102d21:	83 c4 10             	add    $0x10,%esp
}
  102d24:	5b                   	pop    %ebx
  return -1;
  102d25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  102d2a:	5e                   	pop    %esi
  102d2b:	5f                   	pop    %edi
  102d2c:	c3                   	ret    
  102d2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
  102d30:	8b 06                	mov    (%esi),%eax
  102d32:	85 c0                	test   %eax,%eax
  102d34:	75 d0                	jne    102d06 <pipealloc+0xc6>
  102d36:	eb da                	jmp    102d12 <pipealloc+0xd2>
  102d38:	90                   	nop
  102d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102d40 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
  102d40:	56                   	push   %esi
  102d41:	53                   	push   %ebx
  102d42:	83 ec 10             	sub    $0x10,%esp
  102d45:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  102d49:	8b 74 24 20          	mov    0x20(%esp),%esi
  acquire(&p->lock);
  102d4d:	53                   	push   %ebx
  102d4e:	e8 3d 0e 00 00       	call   103b90 <acquire>
  if(writable){
  102d53:	83 c4 10             	add    $0x10,%esp
  102d56:	85 f6                	test   %esi,%esi
  102d58:	74 46                	je     102da0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
  102d5a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
  102d60:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
  102d63:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
  102d6a:	00 00 00 
    wakeup(&p->nread);
  102d6d:	50                   	push   %eax
  102d6e:	e8 dd 0a 00 00       	call   103850 <wakeup>
  102d73:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
  102d76:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
  102d7c:	85 d2                	test   %edx,%edx
  102d7e:	75 0a                	jne    102d8a <pipeclose+0x4a>
  102d80:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
  102d86:	85 c0                	test   %eax,%eax
  102d88:	74 36                	je     102dc0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p, PAGE);
  } else
    release(&p->lock);
  102d8a:	89 5c 24 10          	mov    %ebx,0x10(%esp)
}
  102d8e:	83 c4 04             	add    $0x4,%esp
  102d91:	5b                   	pop    %ebx
  102d92:	5e                   	pop    %esi
    release(&p->lock);
  102d93:	e9 98 0f 00 00       	jmp    103d30 <release>
  102d98:	90                   	nop
  102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
  102da0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102da6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
  102da9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
  102db0:	00 00 00 
    wakeup(&p->nwrite);
  102db3:	50                   	push   %eax
  102db4:	e8 97 0a 00 00       	call   103850 <wakeup>
  102db9:	83 c4 10             	add    $0x10,%esp
  102dbc:	eb b8                	jmp    102d76 <pipeclose+0x36>
  102dbe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
  102dc0:	83 ec 0c             	sub    $0xc,%esp
  102dc3:	53                   	push   %ebx
  102dc4:	e8 67 0f 00 00       	call   103d30 <release>
    kfree((char*)p, PAGE);
  102dc9:	89 5c 24 20          	mov    %ebx,0x20(%esp)
  102dcd:	c7 44 24 24 00 10 00 	movl   $0x1000,0x24(%esp)
  102dd4:	00 
}
  102dd5:	83 c4 14             	add    $0x14,%esp
  102dd8:	5b                   	pop    %ebx
  102dd9:	5e                   	pop    %esi
    kfree((char*)p, PAGE);
  102dda:	e9 51 f5 ff ff       	jmp    102330 <kfree>
  102ddf:	90                   	nop

00102de0 <pipewrite>:

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102de0:	55                   	push   %ebp
  102de1:	57                   	push   %edi
  102de2:	56                   	push   %esi
  102de3:	53                   	push   %ebx
  102de4:	83 ec 28             	sub    $0x28,%esp
  102de7:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
  int i;

  acquire(&p->lock);
  102deb:	55                   	push   %ebp
  102dec:	e8 9f 0d 00 00       	call   103b90 <acquire>
  for(i = 0; i < n; i++){
  102df1:	83 c4 10             	add    $0x10,%esp
  102df4:	8b 44 24 38          	mov    0x38(%esp),%eax
  102df8:	85 c0                	test   %eax,%eax
  102dfa:	0f 8e bc 00 00 00    	jle    102ebc <pipewrite+0xdc>
  102e00:	8b 7c 24 34          	mov    0x34(%esp),%edi
  102e04:	8b 44 24 38          	mov    0x38(%esp),%eax
  102e08:	8d b5 34 02 00 00    	lea    0x234(%ebp),%esi
  102e0e:	8b 8d 38 02 00 00    	mov    0x238(%ebp),%ecx
  102e14:	8d 9d 38 02 00 00    	lea    0x238(%ebp),%ebx
  102e1a:	01 f8                	add    %edi,%eax
  102e1c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102e20:	8b 85 34 02 00 00    	mov    0x234(%ebp),%eax
  102e26:	05 00 02 00 00       	add    $0x200,%eax
  102e2b:	39 c1                	cmp    %eax,%ecx
  102e2d:	74 40                	je     102e6f <pipewrite+0x8f>
  102e2f:	eb 61                	jmp    102e92 <pipewrite+0xb2>
  102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || proc->killed){
  102e38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102e3e:	8b 40 24             	mov    0x24(%eax),%eax
  102e41:	85 c0                	test   %eax,%eax
  102e43:	75 34                	jne    102e79 <pipewrite+0x99>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
  102e45:	83 ec 0c             	sub    $0xc,%esp
  102e48:	56                   	push   %esi
  102e49:	e8 02 0a 00 00       	call   103850 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
  102e4e:	5a                   	pop    %edx
  102e4f:	59                   	pop    %ecx
  102e50:	55                   	push   %ebp
  102e51:	53                   	push   %ebx
  102e52:	e8 39 09 00 00       	call   103790 <sleep>
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102e57:	8b 85 34 02 00 00    	mov    0x234(%ebp),%eax
  102e5d:	8b 95 38 02 00 00    	mov    0x238(%ebp),%edx
  102e63:	83 c4 10             	add    $0x10,%esp
  102e66:	05 00 02 00 00       	add    $0x200,%eax
  102e6b:	39 c2                	cmp    %eax,%edx
  102e6d:	75 29                	jne    102e98 <pipewrite+0xb8>
      if(p->readopen == 0 || proc->killed){
  102e6f:	8b 85 3c 02 00 00    	mov    0x23c(%ebp),%eax
  102e75:	85 c0                	test   %eax,%eax
  102e77:	75 bf                	jne    102e38 <pipewrite+0x58>
        release(&p->lock);
  102e79:	83 ec 0c             	sub    $0xc,%esp
  102e7c:	55                   	push   %ebp
  102e7d:	e8 ae 0e 00 00       	call   103d30 <release>
        return -1;
  102e82:	83 c4 10             	add    $0x10,%esp
  102e85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
  102e8a:	83 c4 1c             	add    $0x1c,%esp
  102e8d:	5b                   	pop    %ebx
  102e8e:	5e                   	pop    %esi
  102e8f:	5f                   	pop    %edi
  102e90:	5d                   	pop    %ebp
  102e91:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE) {  //DOC: pipewrite-full
  102e92:	89 ca                	mov    %ecx,%edx
  102e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102e98:	8d 4a 01             	lea    0x1(%edx),%ecx
  102e9b:	83 c7 01             	add    $0x1,%edi
  102e9e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102ea4:	89 8d 38 02 00 00    	mov    %ecx,0x238(%ebp)
  102eaa:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
  for(i = 0; i < n; i++){
  102eae:	39 7c 24 0c          	cmp    %edi,0xc(%esp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  102eb2:	88 44 15 34          	mov    %al,0x34(%ebp,%edx,1)
  for(i = 0; i < n; i++){
  102eb6:	0f 85 64 ff ff ff    	jne    102e20 <pipewrite+0x40>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  102ebc:	8d 95 34 02 00 00    	lea    0x234(%ebp),%edx
  102ec2:	83 ec 0c             	sub    $0xc,%esp
  102ec5:	52                   	push   %edx
  102ec6:	e8 85 09 00 00       	call   103850 <wakeup>
  release(&p->lock);
  102ecb:	89 2c 24             	mov    %ebp,(%esp)
  102ece:	e8 5d 0e 00 00       	call   103d30 <release>
  return n;
  102ed3:	83 c4 10             	add    $0x10,%esp
  102ed6:	8b 44 24 38          	mov    0x38(%esp),%eax
  102eda:	eb ae                	jmp    102e8a <pipewrite+0xaa>
  102edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102ee0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
  102ee0:	55                   	push   %ebp
  102ee1:	57                   	push   %edi
  102ee2:	56                   	push   %esi
  102ee3:	53                   	push   %ebx
  102ee4:	83 ec 18             	sub    $0x18,%esp
  102ee7:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  102eeb:	8b 7c 24 30          	mov    0x30(%esp),%edi
  102eef:	8b 74 24 34          	mov    0x34(%esp),%esi
  int i;

  acquire(&p->lock);
  102ef3:	53                   	push   %ebx
  102ef4:	e8 97 0c 00 00       	call   103b90 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102ef9:	83 c4 10             	add    $0x10,%esp
  102efc:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102f02:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102f08:	75 6e                	jne    102f78 <piperead+0x98>
  102f0a:	8b 8b 40 02 00 00    	mov    0x240(%ebx),%ecx
  102f10:	85 c9                	test   %ecx,%ecx
  102f12:	0f 84 b8 00 00 00    	je     102fd0 <piperead+0xf0>
  102f18:	8d ab 34 02 00 00    	lea    0x234(%ebx),%ebp
  102f1e:	eb 29                	jmp    102f49 <piperead+0x69>
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  102f20:	83 ec 08             	sub    $0x8,%esp
  102f23:	53                   	push   %ebx
  102f24:	55                   	push   %ebp
  102f25:	e8 66 08 00 00       	call   103790 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
  102f2a:	83 c4 10             	add    $0x10,%esp
  102f2d:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102f33:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102f39:	75 3d                	jne    102f78 <piperead+0x98>
  102f3b:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
  102f41:	85 c0                	test   %eax,%eax
  102f43:	0f 84 87 00 00 00    	je     102fd0 <piperead+0xf0>
    if(proc->killed){
  102f49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  102f4f:	8b 50 24             	mov    0x24(%eax),%edx
  102f52:	85 d2                	test   %edx,%edx
  102f54:	74 ca                	je     102f20 <piperead+0x40>
      release(&p->lock);
  102f56:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  102f59:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
      release(&p->lock);
  102f5e:	53                   	push   %ebx
  102f5f:	e8 cc 0d 00 00       	call   103d30 <release>
      return -1;
  102f64:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
  102f67:	89 e8                	mov    %ebp,%eax
  102f69:	83 c4 0c             	add    $0xc,%esp
  102f6c:	5b                   	pop    %ebx
  102f6d:	5e                   	pop    %esi
  102f6e:	5f                   	pop    %edi
  102f6f:	5d                   	pop    %ebp
  102f70:	c3                   	ret    
  102f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102f78:	85 f6                	test   %esi,%esi
  102f7a:	7e 54                	jle    102fd0 <piperead+0xf0>
    if(p->nread == p->nwrite)
  102f7c:	31 ed                	xor    %ebp,%ebp
  102f7e:	eb 0e                	jmp    102f8e <piperead+0xae>
  102f80:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
  102f86:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
  102f8c:	74 1e                	je     102fac <piperead+0xcc>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  102f8e:	8d 42 01             	lea    0x1(%edx),%eax
  102f91:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102f97:	89 83 34 02 00 00    	mov    %eax,0x234(%ebx)
  102f9d:	0f b6 44 13 34       	movzbl 0x34(%ebx,%edx,1),%eax
  102fa2:	88 04 2f             	mov    %al,(%edi,%ebp,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
  102fa5:	83 c5 01             	add    $0x1,%ebp
  102fa8:	39 ee                	cmp    %ebp,%esi
  102faa:	75 d4                	jne    102f80 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  102fac:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  102fb2:	83 ec 0c             	sub    $0xc,%esp
  102fb5:	50                   	push   %eax
  102fb6:	e8 95 08 00 00       	call   103850 <wakeup>
  release(&p->lock);
  102fbb:	89 1c 24             	mov    %ebx,(%esp)
  102fbe:	e8 6d 0d 00 00       	call   103d30 <release>
  return i;
  102fc3:	83 c4 10             	add    $0x10,%esp
}
  102fc6:	89 e8                	mov    %ebp,%eax
  102fc8:	83 c4 0c             	add    $0xc,%esp
  102fcb:	5b                   	pop    %ebx
  102fcc:	5e                   	pop    %esi
  102fcd:	5f                   	pop    %edi
  102fce:	5d                   	pop    %ebp
  102fcf:	c3                   	ret    
    if(p->nread == p->nwrite)
  102fd0:	31 ed                	xor    %ebp,%ebp
  102fd2:	eb d8                	jmp    102fac <piperead+0xcc>
  102fd4:	66 90                	xchg   %ax,%ax
  102fd6:	66 90                	xchg   %ax,%ax
  102fd8:	66 90                	xchg   %ax,%ax
  102fda:	66 90                	xchg   %ax,%ax
  102fdc:	66 90                	xchg   %ax,%ax
  102fde:	66 90                	xchg   %ax,%ax

00102fe0 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  102fe0:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  102fe1:	bb d4 e0 10 00       	mov    $0x10e0d4,%ebx
{
  102fe6:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
  102fe9:	68 a0 e0 10 00       	push   $0x10e0a0
  102fee:	e8 9d 0b 00 00       	call   103b90 <acquire>
  102ff3:	83 c4 10             	add    $0x10,%esp
  102ff6:	eb 17                	jmp    10300f <allocproc+0x2f>
  102ff8:	90                   	nop
  102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103000:	83 c3 7c             	add    $0x7c,%ebx
  103003:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
  103009:	0f 83 81 00 00 00    	jae    103090 <allocproc+0xb0>
    if(p->state == UNUSED)
  10300f:	8b 43 0c             	mov    0xc(%ebx),%eax
  103012:	85 c0                	test   %eax,%eax
  103014:	75 ea                	jne    103000 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  103016:	a1 04 a3 10 00       	mov    0x10a304,%eax
  release(&ptable.lock);
  10301b:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
  10301e:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
  103025:	8d 50 01             	lea    0x1(%eax),%edx
  103028:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
  10302b:	68 a0 e0 10 00       	push   $0x10e0a0
  p->pid = nextpid++;
  103030:	89 15 04 a3 10 00    	mov    %edx,0x10a304
  release(&ptable.lock);
  103036:	e8 f5 0c 00 00       	call   103d30 <release>

  // Allocate kernel stack if necessary.
  if((p->kstack = kalloc(KSTACKSIZE)) == 0){
  10303b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103042:	e8 39 f4 ff ff       	call   102480 <kalloc>
  103047:	83 c4 10             	add    $0x10,%esp
  10304a:	85 c0                	test   %eax,%eax
  10304c:	89 43 08             	mov    %eax,0x8(%ebx)
  10304f:	74 58                	je     1030a9 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  103051:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  103057:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
  10305a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
  10305f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
  103062:	c7 40 14 8a 4e 10 00 	movl   $0x104e8a,0x14(%eax)
  p->context = (struct context*)sp;
  103069:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
  10306c:	6a 14                	push   $0x14
  10306e:	6a 00                	push   $0x0
  103070:	50                   	push   %eax
  103071:	e8 0a 0d 00 00       	call   103d80 <memset>
  p->context->eip = (uint)forkret;
  103076:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
  103079:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
  10307c:	c7 40 10 c0 30 10 00 	movl   $0x1030c0,0x10(%eax)
}
  103083:	83 c4 08             	add    $0x8,%esp
  103086:	89 d8                	mov    %ebx,%eax
  103088:	5b                   	pop    %ebx
  103089:	c3                   	ret    
  10308a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
  103090:	83 ec 0c             	sub    $0xc,%esp
  return 0;
  103093:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
  103095:	68 a0 e0 10 00       	push   $0x10e0a0
  10309a:	e8 91 0c 00 00       	call   103d30 <release>
  return 0;
  10309f:	83 c4 10             	add    $0x10,%esp
}
  1030a2:	89 d8                	mov    %ebx,%eax
  1030a4:	83 c4 08             	add    $0x8,%esp
  1030a7:	5b                   	pop    %ebx
  1030a8:	c3                   	ret    
    p->state = UNUSED;
  1030a9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
  1030b0:	31 db                	xor    %ebx,%ebx
  1030b2:	eb cf                	jmp    103083 <allocproc+0xa3>
  1030b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1030ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001030c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1030c0:	83 ec 18             	sub    $0x18,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  1030c3:	68 a0 e0 10 00       	push   $0x10e0a0
  1030c8:	e8 63 0c 00 00       	call   103d30 <release>
  
  // Return to "caller", actually trapret (see allocproc).
}
  1030cd:	83 c4 1c             	add    $0x1c,%esp
  1030d0:	c3                   	ret    
  1030d1:	eb 0d                	jmp    1030e0 <pinit>
  1030d3:	90                   	nop
  1030d4:	90                   	nop
  1030d5:	90                   	nop
  1030d6:	90                   	nop
  1030d7:	90                   	nop
  1030d8:	90                   	nop
  1030d9:	90                   	nop
  1030da:	90                   	nop
  1030db:	90                   	nop
  1030dc:	90                   	nop
  1030dd:	90                   	nop
  1030de:	90                   	nop
  1030df:	90                   	nop

001030e0 <pinit>:
{
  1030e0:	83 ec 14             	sub    $0x14,%esp
  initlock(&ptable.lock, "ptable");
  1030e3:	68 9d 62 10 00       	push   $0x10629d
  1030e8:	68 a0 e0 10 00       	push   $0x10e0a0
  1030ed:	e8 7e 0a 00 00       	call   103b70 <initlock>
}
  1030f2:	83 c4 1c             	add    $0x1c,%esp
  1030f5:	c3                   	ret    
  1030f6:	8d 76 00             	lea    0x0(%esi),%esi
  1030f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103100 <procdump>:
{
  103100:	55                   	push   %ebp
  103101:	57                   	push   %edi
  103102:	56                   	push   %esi
  103103:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103104:	bb d4 e0 10 00       	mov    $0x10e0d4,%ebx
{
  103109:	83 ec 3c             	sub    $0x3c,%esp
      getcallerpcs((uint*)p->context->ebp+2, pc);
  10310c:	8d 7c 24 08          	lea    0x8(%esp),%edi
  103110:	8d 74 24 30          	lea    0x30(%esp),%esi
  103114:	eb 29                	jmp    10313f <procdump+0x3f>
  103116:	8d 76 00             	lea    0x0(%esi),%esi
  103119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("\n");
  103120:	83 ec 0c             	sub    $0xc,%esp
  103123:	68 33 62 10 00       	push   $0x106233
  103128:	e8 63 d5 ff ff       	call   100690 <cprintf>
  10312d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103130:	83 c3 7c             	add    $0x7c,%ebx
  103133:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
  103139:	0f 83 81 00 00 00    	jae    1031c0 <procdump+0xc0>
    if(p->state == UNUSED)
  10313f:	8b 43 0c             	mov    0xc(%ebx),%eax
  103142:	85 c0                	test   %eax,%eax
  103144:	74 ea                	je     103130 <procdump+0x30>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103146:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
  103149:	ba a4 62 10 00       	mov    $0x1062a4,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  10314e:	77 11                	ja     103161 <procdump+0x61>
  103150:	8b 14 85 58 63 10 00 	mov    0x106358(,%eax,4),%edx
      state = "???";
  103157:	b8 a4 62 10 00       	mov    $0x1062a4,%eax
  10315c:	85 d2                	test   %edx,%edx
  10315e:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
  103161:	8b 43 10             	mov    0x10(%ebx),%eax
  103164:	8d 4b 6c             	lea    0x6c(%ebx),%ecx
  103167:	51                   	push   %ecx
  103168:	52                   	push   %edx
  103169:	50                   	push   %eax
  10316a:	68 a8 62 10 00       	push   $0x1062a8
  10316f:	e8 1c d5 ff ff       	call   100690 <cprintf>
    if(p->state == SLEEPING){
  103174:	83 c4 10             	add    $0x10,%esp
  103177:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
  10317b:	75 a3                	jne    103120 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
  10317d:	8b 43 1c             	mov    0x1c(%ebx),%eax
  103180:	83 ec 08             	sub    $0x8,%esp
  103183:	89 fd                	mov    %edi,%ebp
  103185:	57                   	push   %edi
  103186:	8b 40 0c             	mov    0xc(%eax),%eax
  103189:	83 c0 08             	add    $0x8,%eax
  10318c:	50                   	push   %eax
  10318d:	e8 ae 0a 00 00       	call   103c40 <getcallerpcs>
  103192:	83 c4 10             	add    $0x10,%esp
  103195:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
  103198:	8b 45 00             	mov    0x0(%ebp),%eax
  10319b:	85 c0                	test   %eax,%eax
  10319d:	74 81                	je     103120 <procdump+0x20>
        cprintf(" %p", pc[i]);
  10319f:	83 ec 08             	sub    $0x8,%esp
  1031a2:	83 c5 04             	add    $0x4,%ebp
  1031a5:	50                   	push   %eax
  1031a6:	68 bc 5d 10 00       	push   $0x105dbc
  1031ab:	e8 e0 d4 ff ff       	call   100690 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
  1031b0:	83 c4 10             	add    $0x10,%esp
  1031b3:	39 ee                	cmp    %ebp,%esi
  1031b5:	75 e1                	jne    103198 <procdump+0x98>
  1031b7:	e9 64 ff ff ff       	jmp    103120 <procdump+0x20>
  1031bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
  1031c0:	83 c4 3c             	add    $0x3c,%esp
  1031c3:	5b                   	pop    %ebx
  1031c4:	5e                   	pop    %esi
  1031c5:	5f                   	pop    %edi
  1031c6:	5d                   	pop    %ebp
  1031c7:	c3                   	ret    
  1031c8:	90                   	nop
  1031c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001031d0 <ksegment>:
{
  1031d0:	53                   	push   %ebx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1031d1:	31 db                	xor    %ebx,%ebx
{
  1031d3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpunum()];
  1031d6:	e8 55 f5 ff ff       	call   102730 <cpunum>
  1031db:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1031e1:	b9 0f 01 00 00       	mov    $0x10f,%ecx
  1031e6:	8d 90 a0 da 10 00    	lea    0x10daa0(%eax),%edx
  1031ec:	c6 80 1d db 10 00 9a 	movb   $0x9a,0x10db1d(%eax)
  1031f3:	c6 80 1e db 10 00 c0 	movb   $0xc0,0x10db1e(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1031fa:	c6 80 25 db 10 00 92 	movb   $0x92,0x10db25(%eax)
  103201:	c6 80 26 db 10 00 cf 	movb   $0xcf,0x10db26(%eax)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103208:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  10320c:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103211:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103215:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
  10321c:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10321e:	8d 88 54 db 10 00    	lea    0x10db54(%eax),%ecx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103224:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10322b:	31 db                	xor    %ebx,%ebx
  10322d:	c6 80 2d db 10 00 92 	movb   $0x92,0x10db2d(%eax)
  103234:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
  10323b:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
  103242:	89 cb                	mov    %ecx,%ebx
  103244:	c1 e9 18             	shr    $0x18,%ecx
  103247:	c6 80 2e db 10 00 c0 	movb   $0xc0,0x10db2e(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
  10324e:	05 10 db 10 00       	add    $0x10db10,%eax
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  103253:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  pd[0] = size-1;
  103259:	b9 37 00 00 00       	mov    $0x37,%ecx
  10325e:	c1 eb 10             	shr    $0x10,%ebx
  103261:	66 89 4c 24 0a       	mov    %cx,0xa(%esp)
  pd[1] = (uint)p;
  103266:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  pd[2] = (uint)p >> 16;
  10326b:	c1 e8 10             	shr    $0x10,%eax
  10326e:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103273:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
  asm volatile("lgdt (%0)" : : "r" (pd));
  103277:	8d 44 24 0a          	lea    0xa(%esp),%eax
  10327b:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  10327f:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
  103286:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
  10328d:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
  103293:	0f 01 10             	lgdtl  (%eax)
  asm volatile("movw %0, %%gs" : : "r" (v));
  103296:	b8 18 00 00 00       	mov    $0x18,%eax
  10329b:	8e e8                	mov    %eax,%gs
  proc = 0;
  10329d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  1032a4:	00 00 00 00 
  c = &cpus[cpunum()];
  1032a8:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
}
  1032af:	83 c4 18             	add    $0x18,%esp
  1032b2:	5b                   	pop    %ebx
  1032b3:	c3                   	ret    
  1032b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1032ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001032c0 <usegment>:
{
  1032c0:	57                   	push   %edi
  1032c1:	56                   	push   %esi
  1032c2:	53                   	push   %ebx
  pushcli();
  1032c3:	e8 e8 09 00 00       	call   103cb0 <pushcli>
  cpu->gdt[SEG_UCODE] = SEG(STA_X|STA_R, proc->mem, proc->sz-1, DPL_USER);
  1032c8:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  1032cf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  1032d5:	8b 59 04             	mov    0x4(%ecx),%ebx
  1032d8:	8d 7b ff             	lea    -0x1(%ebx),%edi
  1032db:	8b 19                	mov    (%ecx),%ebx
  1032dd:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
  1032e4:	89 fe                	mov    %edi,%esi
  1032e6:	c1 ef 1c             	shr    $0x1c,%edi
  1032e9:	c1 ee 0c             	shr    $0xc,%esi
  1032ec:	66 89 98 92 00 00 00 	mov    %bx,0x92(%eax)
  1032f3:	66 89 b0 90 00 00 00 	mov    %si,0x90(%eax)
  1032fa:	89 de                	mov    %ebx,%esi
  1032fc:	c1 eb 18             	shr    $0x18,%ebx
  1032ff:	c1 ee 10             	shr    $0x10,%esi
  103302:	88 98 97 00 00 00    	mov    %bl,0x97(%eax)
  103308:	89 f2                	mov    %esi,%edx
  10330a:	88 90 94 00 00 00    	mov    %dl,0x94(%eax)
  103310:	89 fa                	mov    %edi,%edx
  103312:	83 ca c0             	or     $0xffffffc0,%edx
  103315:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
  cpu->gdt[SEG_UDATA] = SEG(STA_W, proc->mem, proc->sz-1, DPL_USER);
  10331b:	8b 59 04             	mov    0x4(%ecx),%ebx
  10331e:	8d 7b ff             	lea    -0x1(%ebx),%edi
  103321:	8b 19                	mov    (%ecx),%ebx
  103323:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  10332a:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  103331:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
  cpu->gdt[SEG_UDATA] = SEG(STA_W, proc->mem, proc->sz-1, DPL_USER);
  103338:	89 fe                	mov    %edi,%esi
  10333a:	c1 ef 1c             	shr    $0x1c,%edi
  10333d:	c1 ee 0c             	shr    $0xc,%esi
  103340:	66 89 98 9a 00 00 00 	mov    %bx,0x9a(%eax)
  103347:	66 89 b0 98 00 00 00 	mov    %si,0x98(%eax)
  10334e:	89 de                	mov    %ebx,%esi
  103350:	c1 eb 18             	shr    $0x18,%ebx
  103353:	c1 ee 10             	shr    $0x10,%esi
  103356:	88 98 9f 00 00 00    	mov    %bl,0x9f(%eax)
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  10335c:	bb 67 00 00 00       	mov    $0x67,%ebx
  cpu->gdt[SEG_UDATA] = SEG(STA_W, proc->mem, proc->sz-1, DPL_USER);
  103361:	89 f2                	mov    %esi,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  103363:	66 89 98 a0 00 00 00 	mov    %bx,0xa0(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  10336a:	be 10 00 00 00       	mov    $0x10,%esi
  cpu->gdt[SEG_UDATA] = SEG(STA_W, proc->mem, proc->sz-1, DPL_USER);
  10336f:	88 90 9c 00 00 00    	mov    %dl,0x9c(%eax)
  103375:	89 fa                	mov    %edi,%edx
  cpu->ts.ss0 = SEG_KDATA << 3;
  103377:	66 89 70 10          	mov    %si,0x10(%eax)
  cpu->gdt[SEG_UDATA] = SEG(STA_W, proc->mem, proc->sz-1, DPL_USER);
  10337b:	83 ca c0             	or     $0xffffffc0,%edx
  10337e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  103384:	8d 50 08             	lea    0x8(%eax),%edx
  103387:	89 d3                	mov    %edx,%ebx
  103389:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
  103390:	c1 ea 18             	shr    $0x18,%edx
  103393:	c1 eb 10             	shr    $0x10,%ebx
  103396:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  10339c:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  1033a2:	8b 51 08             	mov    0x8(%ecx),%edx
  1033a5:	81 c2 00 10 00 00    	add    $0x1000,%edx
  1033ab:	89 50 0c             	mov    %edx,0xc(%eax)
  asm volatile("ltr %0" : : "r" (sel));
  1033ae:	b8 30 00 00 00       	mov    $0x30,%eax
  1033b3:	0f 00 d8             	ltr    %ax
}
  1033b6:	5b                   	pop    %ebx
  1033b7:	5e                   	pop    %esi
  1033b8:	5f                   	pop    %edi
  popcli();
  1033b9:	e9 22 09 00 00       	jmp    103ce0 <popcli>
  1033be:	66 90                	xchg   %ax,%ax

001033c0 <userinit>:
{
  1033c0:	53                   	push   %ebx
  1033c1:	83 ec 08             	sub    $0x8,%esp
  p = allocproc();
  1033c4:	e8 17 fc ff ff       	call   102fe0 <allocproc>
  p->mem = kalloc(p->sz);
  1033c9:	83 ec 0c             	sub    $0xc,%esp
  p->sz = PAGE;
  1033cc:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
  p = allocproc();
  1033d3:	89 c3                	mov    %eax,%ebx
  p->mem = kalloc(p->sz);
  1033d5:	68 00 10 00 00       	push   $0x1000
  initproc = p;
  1033da:	a3 40 a8 10 00       	mov    %eax,0x10a840
  p->mem = kalloc(p->sz);
  1033df:	e8 9c f0 ff ff       	call   102480 <kalloc>
  memset(p->mem, 0, p->sz);
  1033e4:	83 c4 0c             	add    $0xc,%esp
  p->mem = kalloc(p->sz);
  1033e7:	89 03                	mov    %eax,(%ebx)
  memset(p->mem, 0, p->sz);
  1033e9:	ff 73 04             	pushl  0x4(%ebx)
  1033ec:	6a 00                	push   $0x0
  1033ee:	50                   	push   %eax
  1033ef:	e8 8c 09 00 00       	call   103d80 <memset>
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  1033f4:	83 c4 0c             	add    $0xc,%esp
  1033f7:	68 2c 00 00 00       	push   $0x2c
  1033fc:	68 08 a7 10 00       	push   $0x10a708
  103401:	ff 33                	pushl  (%ebx)
  103403:	e8 f8 09 00 00       	call   103e00 <memmove>
  memset(p->tf, 0, sizeof(*p->tf));
  103408:	83 c4 0c             	add    $0xc,%esp
  10340b:	6a 4c                	push   $0x4c
  10340d:	6a 00                	push   $0x0
  10340f:	ff 73 18             	pushl  0x18(%ebx)
  103412:	e8 69 09 00 00       	call   103d80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103417:	8b 43 18             	mov    0x18(%ebx),%eax
  10341a:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  10341f:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
  103424:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103427:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  10342b:	8b 43 18             	mov    0x18(%ebx),%eax
  10342e:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
  103432:	8b 43 18             	mov    0x18(%ebx),%eax
  103435:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
  103439:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
  10343d:	8b 43 18             	mov    0x18(%ebx),%eax
  103440:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
  103444:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
  103448:	8b 43 18             	mov    0x18(%ebx),%eax
  10344b:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = p->sz;
  103452:	8b 43 18             	mov    0x18(%ebx),%eax
  103455:	8b 53 04             	mov    0x4(%ebx),%edx
  103458:	89 50 44             	mov    %edx,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
  10345b:	8b 43 18             	mov    0x18(%ebx),%eax
  10345e:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
  103465:	8d 43 6c             	lea    0x6c(%ebx),%eax
  103468:	6a 10                	push   $0x10
  10346a:	68 b1 62 10 00       	push   $0x1062b1
  10346f:	50                   	push   %eax
  103470:	e8 ab 0a 00 00       	call   103f20 <safestrcpy>
  p->cwd = namei("/");
  103475:	c7 04 24 ba 62 10 00 	movl   $0x1062ba,(%esp)
  10347c:	e8 6f ea ff ff       	call   101ef0 <namei>
  p->state = RUNNABLE;
  103481:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->cwd = namei("/");
  103488:	89 43 68             	mov    %eax,0x68(%ebx)
}
  10348b:	83 c4 18             	add    $0x18,%esp
  10348e:	5b                   	pop    %ebx
  10348f:	c3                   	ret    

00103490 <growproc>:
{
  103490:	56                   	push   %esi
  103491:	53                   	push   %ebx
  103492:	83 ec 10             	sub    $0x10,%esp
  newmem = kalloc(proc->sz + n);
  103495:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
  10349b:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  newmem = kalloc(proc->sz + n);
  10349f:	8b 50 04             	mov    0x4(%eax),%edx
  1034a2:	01 f2                	add    %esi,%edx
  1034a4:	52                   	push   %edx
  1034a5:	e8 d6 ef ff ff       	call   102480 <kalloc>
  if(newmem == 0)
  1034aa:	83 c4 10             	add    $0x10,%esp
  1034ad:	85 c0                	test   %eax,%eax
  1034af:	74 67                	je     103518 <growproc+0x88>
  1034b1:	89 c3                	mov    %eax,%ebx
  memmove(newmem, proc->mem, proc->sz);
  1034b3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034b9:	83 ec 04             	sub    $0x4,%esp
  1034bc:	ff 70 04             	pushl  0x4(%eax)
  1034bf:	ff 30                	pushl  (%eax)
  1034c1:	53                   	push   %ebx
  1034c2:	e8 39 09 00 00       	call   103e00 <memmove>
  memset(newmem + proc->sz, 0, n);
  1034c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034cd:	83 c4 0c             	add    $0xc,%esp
  1034d0:	56                   	push   %esi
  1034d1:	6a 00                	push   $0x0
  1034d3:	8b 48 04             	mov    0x4(%eax),%ecx
  1034d6:	01 d9                	add    %ebx,%ecx
  1034d8:	51                   	push   %ecx
  1034d9:	e8 a2 08 00 00       	call   103d80 <memset>
  kfree(proc->mem, proc->sz);
  1034de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034e4:	5a                   	pop    %edx
  1034e5:	59                   	pop    %ecx
  1034e6:	ff 70 04             	pushl  0x4(%eax)
  1034e9:	ff 30                	pushl  (%eax)
  1034eb:	e8 40 ee ff ff       	call   102330 <kfree>
  proc->mem = newmem;
  1034f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034f6:	89 18                	mov    %ebx,(%eax)
  proc->sz += n;
  1034f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1034fe:	01 70 04             	add    %esi,0x4(%eax)
  usegment();
  103501:	e8 ba fd ff ff       	call   1032c0 <usegment>
  return 0;
  103506:	83 c4 10             	add    $0x10,%esp
  103509:	31 c0                	xor    %eax,%eax
}
  10350b:	83 c4 04             	add    $0x4,%esp
  10350e:	5b                   	pop    %ebx
  10350f:	5e                   	pop    %esi
  103510:	c3                   	ret    
  103511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  103518:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10351d:	eb ec                	jmp    10350b <growproc+0x7b>
  10351f:	90                   	nop

00103520 <fork>:
{
  103520:	55                   	push   %ebp
  103521:	57                   	push   %edi
  103522:	56                   	push   %esi
  103523:	53                   	push   %ebx
  103524:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0)
  103527:	e8 b4 fa ff ff       	call   102fe0 <allocproc>
  10352c:	85 c0                	test   %eax,%eax
  10352e:	0f 84 b6 00 00 00    	je     1035ea <fork+0xca>
  103534:	89 c5                	mov    %eax,%ebp
  np->sz = proc->sz;
  103536:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if((np->mem = kalloc(np->sz)) == 0){
  10353c:	83 ec 0c             	sub    $0xc,%esp
  np->sz = proc->sz;
  10353f:	8b 40 04             	mov    0x4(%eax),%eax
  103542:	89 45 04             	mov    %eax,0x4(%ebp)
  if((np->mem = kalloc(np->sz)) == 0){
  103545:	50                   	push   %eax
  103546:	e8 35 ef ff ff       	call   102480 <kalloc>
  10354b:	83 c4 10             	add    $0x10,%esp
  10354e:	85 c0                	test   %eax,%eax
  103550:	89 45 00             	mov    %eax,0x0(%ebp)
  103553:	0f 84 98 00 00 00    	je     1035f1 <fork+0xd1>
  memmove(np->mem, proc->mem, np->sz);
  103559:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103560:	83 ec 04             	sub    $0x4,%esp
  103563:	ff 75 04             	pushl  0x4(%ebp)
  for(i = 0; i < NOFILE; i++)
  103566:	31 db                	xor    %ebx,%ebx
  memmove(np->mem, proc->mem, np->sz);
  103568:	ff 32                	pushl  (%edx)
  10356a:	50                   	push   %eax
  10356b:	e8 90 08 00 00       	call   103e00 <memmove>
  np->parent = proc;
  103570:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
  103576:	8b 7d 18             	mov    0x18(%ebp),%edi
  103579:	b9 13 00 00 00       	mov    $0x13,%ecx
  10357e:	83 c4 10             	add    $0x10,%esp
  np->parent = proc;
  103581:	89 45 14             	mov    %eax,0x14(%ebp)
  *np->tf = *proc->tf;
  103584:	8b 70 18             	mov    0x18(%eax),%esi
  103587:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
  103589:	8b 45 18             	mov    0x18(%ebp),%eax
  10358c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  103593:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  10359a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[i])
  1035a0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
  1035a4:	85 c0                	test   %eax,%eax
  1035a6:	74 17                	je     1035bf <fork+0x9f>
      np->ofile[i] = filedup(proc->ofile[i]);
  1035a8:	83 ec 0c             	sub    $0xc,%esp
  1035ab:	50                   	push   %eax
  1035ac:	e8 1f d9 ff ff       	call   100ed0 <filedup>
  1035b1:	89 44 9d 28          	mov    %eax,0x28(%ebp,%ebx,4)
  1035b5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  1035bc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
  1035bf:	83 c3 01             	add    $0x1,%ebx
  1035c2:	83 fb 10             	cmp    $0x10,%ebx
  1035c5:	75 d9                	jne    1035a0 <fork+0x80>
  np->cwd = idup(proc->cwd);
  1035c7:	83 ec 0c             	sub    $0xc,%esp
  1035ca:	ff 72 68             	pushl  0x68(%edx)
  1035cd:	e8 1e e0 ff ff       	call   1015f0 <idup>
  1035d2:	89 45 68             	mov    %eax,0x68(%ebp)
  pid = np->pid;
  1035d5:	8b 45 10             	mov    0x10(%ebp),%eax
  return pid;
  1035d8:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
  1035db:	c7 45 0c 03 00 00 00 	movl   $0x3,0xc(%ebp)
}
  1035e2:	83 c4 0c             	add    $0xc,%esp
  1035e5:	5b                   	pop    %ebx
  1035e6:	5e                   	pop    %esi
  1035e7:	5f                   	pop    %edi
  1035e8:	5d                   	pop    %ebp
  1035e9:	c3                   	ret    
    return -1;
  1035ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1035ef:	eb f1                	jmp    1035e2 <fork+0xc2>
    kfree(np->kstack, KSTACKSIZE);
  1035f1:	83 ec 08             	sub    $0x8,%esp
  1035f4:	68 00 10 00 00       	push   $0x1000
  1035f9:	ff 75 08             	pushl  0x8(%ebp)
  1035fc:	e8 2f ed ff ff       	call   102330 <kfree>
    np->kstack = 0;
  103601:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    np->state = UNUSED;
  103608:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    return -1;
  10360f:	83 c4 10             	add    $0x10,%esp
  103612:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103617:	eb c9                	jmp    1035e2 <fork+0xc2>
  103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103620 <scheduler>:
{
  103620:	53                   	push   %ebx
  103621:	83 ec 08             	sub    $0x8,%esp
  103624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
  103628:	fb                   	sti    
    acquire(&ptable.lock);
  103629:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  10362c:	bb d4 e0 10 00       	mov    $0x10e0d4,%ebx
    acquire(&ptable.lock);
  103631:	68 a0 e0 10 00       	push   $0x10e0a0
  103636:	e8 55 05 00 00       	call   103b90 <acquire>
  10363b:	83 c4 10             	add    $0x10,%esp
  10363e:	eb 0b                	jmp    10364b <scheduler+0x2b>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103640:	83 c3 7c             	add    $0x7c,%ebx
  103643:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
  103649:	73 55                	jae    1036a0 <scheduler+0x80>
      if(p->state != RUNNABLE)
  10364b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  10364f:	75 ef                	jne    103640 <scheduler+0x20>
      proc = p;
  103651:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103658:	83 c3 7c             	add    $0x7c,%ebx
      usegment();
  10365b:	e8 60 fc ff ff       	call   1032c0 <usegment>
      swtch(&cpu->scheduler, proc->context);
  103660:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103666:	83 ec 08             	sub    $0x8,%esp
      p->state = RUNNING;
  103669:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&cpu->scheduler, proc->context);
  103670:	ff 70 1c             	pushl  0x1c(%eax)
  103673:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103679:	83 c0 04             	add    $0x4,%eax
  10367c:	50                   	push   %eax
  10367d:	e8 fb 08 00 00       	call   103f7d <swtch>
      proc = 0;
  103682:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103685:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
      proc = 0;
  10368b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
  103692:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103696:	72 b3                	jb     10364b <scheduler+0x2b>
  103698:	90                   	nop
  103699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
  1036a0:	83 ec 0c             	sub    $0xc,%esp
  1036a3:	68 a0 e0 10 00       	push   $0x10e0a0
  1036a8:	e8 83 06 00 00       	call   103d30 <release>
    sti();
  1036ad:	83 c4 10             	add    $0x10,%esp
  1036b0:	e9 73 ff ff ff       	jmp    103628 <scheduler+0x8>
  1036b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001036c0 <sched>:
{
  1036c0:	53                   	push   %ebx
  1036c1:	83 ec 14             	sub    $0x14,%esp
  if(!holding(&ptable.lock))
  1036c4:	68 a0 e0 10 00       	push   $0x10e0a0
  1036c9:	e8 c2 05 00 00       	call   103c90 <holding>
  1036ce:	83 c4 10             	add    $0x10,%esp
  1036d1:	85 c0                	test   %eax,%eax
  1036d3:	74 49                	je     10371e <sched+0x5e>
  if(cpu->ncli != 1)
  1036d5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  1036dc:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
  1036e3:	75 60                	jne    103745 <sched+0x85>
  if(proc->state == RUNNING)
  1036e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1036eb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  1036ef:	74 47                	je     103738 <sched+0x78>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1036f1:	9c                   	pushf  
  1036f2:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
  1036f3:	80 e5 02             	and    $0x2,%ch
  1036f6:	75 33                	jne    10372b <sched+0x6b>
  swtch(&proc->context, cpu->scheduler);
  1036f8:	83 ec 08             	sub    $0x8,%esp
  1036fb:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
  1036fe:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
  103704:	ff 72 04             	pushl  0x4(%edx)
  103707:	50                   	push   %eax
  103708:	e8 70 08 00 00       	call   103f7d <swtch>
  cpu->intena = intena;
  10370d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103713:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
  103719:	83 c4 18             	add    $0x18,%esp
  10371c:	5b                   	pop    %ebx
  10371d:	c3                   	ret    
    panic("sched ptable.lock");
  10371e:	83 ec 0c             	sub    $0xc,%esp
  103721:	68 bc 62 10 00       	push   $0x1062bc
  103726:	e8 e5 d0 ff ff       	call   100810 <panic>
    panic("sched interruptible");
  10372b:	83 ec 0c             	sub    $0xc,%esp
  10372e:	68 e8 62 10 00       	push   $0x1062e8
  103733:	e8 d8 d0 ff ff       	call   100810 <panic>
    panic("sched running");
  103738:	83 ec 0c             	sub    $0xc,%esp
  10373b:	68 da 62 10 00       	push   $0x1062da
  103740:	e8 cb d0 ff ff       	call   100810 <panic>
    panic("sched locks");
  103745:	83 ec 0c             	sub    $0xc,%esp
  103748:	68 ce 62 10 00       	push   $0x1062ce
  10374d:	e8 be d0 ff ff       	call   100810 <panic>
  103752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103760 <yield>:
{
  103760:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
  103763:	68 a0 e0 10 00       	push   $0x10e0a0
  103768:	e8 23 04 00 00       	call   103b90 <acquire>
  proc->state = RUNNABLE;
  10376d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103773:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10377a:	e8 41 ff ff ff       	call   1036c0 <sched>
  release(&ptable.lock);
  10377f:	c7 04 24 a0 e0 10 00 	movl   $0x10e0a0,(%esp)
  103786:	e8 a5 05 00 00       	call   103d30 <release>
}
  10378b:	83 c4 1c             	add    $0x1c,%esp
  10378e:	c3                   	ret    
  10378f:	90                   	nop

00103790 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  103790:	56                   	push   %esi
  103791:	53                   	push   %ebx
  103792:	83 ec 04             	sub    $0x4,%esp
  if(proc == 0)
  103795:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
  10379b:	8b 74 24 10          	mov    0x10(%esp),%esi
  10379f:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  if(proc == 0)
  1037a3:	85 c0                	test   %eax,%eax
  1037a5:	0f 84 94 00 00 00    	je     10383f <sleep+0xaf>
    panic("sleep");

  if(lk == 0)
  1037ab:	85 db                	test   %ebx,%ebx
  1037ad:	0f 84 7f 00 00 00    	je     103832 <sleep+0xa2>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
  1037b3:	81 fb a0 e0 10 00    	cmp    $0x10e0a0,%ebx
  1037b9:	74 55                	je     103810 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
  1037bb:	83 ec 0c             	sub    $0xc,%esp
  1037be:	68 a0 e0 10 00       	push   $0x10e0a0
  1037c3:	e8 c8 03 00 00       	call   103b90 <acquire>
    release(lk);
  1037c8:	89 1c 24             	mov    %ebx,(%esp)
  1037cb:	e8 60 05 00 00       	call   103d30 <release>
  }

  // Go to sleep.
  proc->chan = chan;
  1037d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1037d6:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  1037d9:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1037e0:	e8 db fe ff ff       	call   1036c0 <sched>

  // Tidy up.
  proc->chan = 0;
  1037e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1037eb:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
  1037f2:	c7 04 24 a0 e0 10 00 	movl   $0x10e0a0,(%esp)
  1037f9:	e8 32 05 00 00       	call   103d30 <release>
    acquire(lk);
  1037fe:	89 5c 24 20          	mov    %ebx,0x20(%esp)
  }
}
  103802:	83 c4 14             	add    $0x14,%esp
  103805:	5b                   	pop    %ebx
  103806:	5e                   	pop    %esi
    acquire(lk);
  103807:	e9 84 03 00 00       	jmp    103b90 <acquire>
  10380c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  proc->chan = chan;
  103810:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
  103813:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  10381a:	e8 a1 fe ff ff       	call   1036c0 <sched>
  proc->chan = 0;
  10381f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  103825:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
  10382c:	83 c4 04             	add    $0x4,%esp
  10382f:	5b                   	pop    %ebx
  103830:	5e                   	pop    %esi
  103831:	c3                   	ret    
    panic("sleep without lk");
  103832:	83 ec 0c             	sub    $0xc,%esp
  103835:	68 02 63 10 00       	push   $0x106302
  10383a:	e8 d1 cf ff ff       	call   100810 <panic>
    panic("sleep");
  10383f:	83 ec 0c             	sub    $0xc,%esp
  103842:	68 fc 62 10 00       	push   $0x1062fc
  103847:	e8 c4 cf ff ff       	call   100810 <panic>
  10384c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103850 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103850:	53                   	push   %ebx
  103851:	83 ec 14             	sub    $0x14,%esp
  103854:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&ptable.lock);
  103858:	68 a0 e0 10 00       	push   $0x10e0a0
  10385d:	e8 2e 03 00 00       	call   103b90 <acquire>
  103862:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103865:	b8 d4 e0 10 00       	mov    $0x10e0d4,%eax
  10386a:	eb 0e                	jmp    10387a <wakeup+0x2a>
  10386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103870:	83 c0 7c             	add    $0x7c,%eax
  103873:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  103878:	73 1c                	jae    103896 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
  10387a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  10387e:	75 f0                	jne    103870 <wakeup+0x20>
  103880:	3b 58 20             	cmp    0x20(%eax),%ebx
  103883:	75 eb                	jne    103870 <wakeup+0x20>
      p->state = RUNNABLE;
  103885:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  10388c:	83 c0 7c             	add    $0x7c,%eax
  10388f:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  103894:	72 e4                	jb     10387a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
  103896:	c7 44 24 10 a0 e0 10 	movl   $0x10e0a0,0x10(%esp)
  10389d:	00 
}
  10389e:	83 c4 08             	add    $0x8,%esp
  1038a1:	5b                   	pop    %ebx
  release(&ptable.lock);
  1038a2:	e9 89 04 00 00       	jmp    103d30 <release>
  1038a7:	89 f6                	mov    %esi,%esi
  1038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001038b0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  1038b0:	53                   	push   %ebx
  1038b1:	83 ec 14             	sub    $0x14,%esp
  1038b4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  1038b8:	68 a0 e0 10 00       	push   $0x10e0a0
  1038bd:	e8 ce 02 00 00       	call   103b90 <acquire>
  1038c2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1038c5:	b8 d4 e0 10 00       	mov    $0x10e0d4,%eax
  1038ca:	eb 0e                	jmp    1038da <kill+0x2a>
  1038cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1038d0:	83 c0 7c             	add    $0x7c,%eax
  1038d3:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  1038d8:	73 3e                	jae    103918 <kill+0x68>
    if(p->pid == pid){
  1038da:	8b 50 10             	mov    0x10(%eax),%edx
  1038dd:	39 da                	cmp    %ebx,%edx
  1038df:	75 ef                	jne    1038d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1038e1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
  1038e5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
  1038ec:	74 1a                	je     103908 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
  1038ee:	83 ec 0c             	sub    $0xc,%esp
  1038f1:	68 a0 e0 10 00       	push   $0x10e0a0
  1038f6:	e8 35 04 00 00       	call   103d30 <release>
      return 0;
  1038fb:	83 c4 10             	add    $0x10,%esp
  1038fe:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
  103900:	83 c4 08             	add    $0x8,%esp
  103903:	5b                   	pop    %ebx
  103904:	c3                   	ret    
  103905:	8d 76 00             	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
  103908:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  10390f:	eb dd                	jmp    1038ee <kill+0x3e>
  103911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
  103918:	83 ec 0c             	sub    $0xc,%esp
  10391b:	68 a0 e0 10 00       	push   $0x10e0a0
  103920:	e8 0b 04 00 00       	call   103d30 <release>
  return -1;
  103925:	83 c4 10             	add    $0x10,%esp
  103928:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10392d:	83 c4 08             	add    $0x8,%esp
  103930:	5b                   	pop    %ebx
  103931:	c3                   	ret    
  103932:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103940 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  103940:	56                   	push   %esi
  103941:	53                   	push   %ebx
  103942:	31 db                	xor    %ebx,%ebx
  103944:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
  103947:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10394e:	3b 15 40 a8 10 00    	cmp    0x10a840,%edx
  103954:	0f 84 0d 01 00 00    	je     103a67 <exit+0x127>
  10395a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
  103960:	8d 73 08             	lea    0x8(%ebx),%esi
  103963:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
  103967:	85 c0                	test   %eax,%eax
  103969:	74 1b                	je     103986 <exit+0x46>
      fileclose(proc->ofile[fd]);
  10396b:	83 ec 0c             	sub    $0xc,%esp
  10396e:	50                   	push   %eax
  10396f:	e8 ac d5 ff ff       	call   100f20 <fileclose>
      proc->ofile[fd] = 0;
  103974:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10397b:	83 c4 10             	add    $0x10,%esp
  10397e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
  103985:	00 
  for(fd = 0; fd < NOFILE; fd++){
  103986:	83 c3 01             	add    $0x1,%ebx
  103989:	83 fb 10             	cmp    $0x10,%ebx
  10398c:	75 d2                	jne    103960 <exit+0x20>
    }
  }

  iput(proc->cwd);
  10398e:	83 ec 0c             	sub    $0xc,%esp
  103991:	ff 72 68             	pushl  0x68(%edx)
  103994:	e8 e7 dd ff ff       	call   101780 <iput>
  proc->cwd = 0;
  103999:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10399f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
  1039a6:	c7 04 24 a0 e0 10 00 	movl   $0x10e0a0,(%esp)
  1039ad:	e8 de 01 00 00       	call   103b90 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
  1039b2:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  1039b9:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1039bc:	b8 d4 e0 10 00       	mov    $0x10e0d4,%eax
  wakeup1(proc->parent);
  1039c1:	8b 51 14             	mov    0x14(%ecx),%edx
  1039c4:	eb 14                	jmp    1039da <exit+0x9a>
  1039c6:	8d 76 00             	lea    0x0(%esi),%esi
  1039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1039d0:	83 c0 7c             	add    $0x7c,%eax
  1039d3:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  1039d8:	73 1c                	jae    1039f6 <exit+0xb6>
    if(p->state == SLEEPING && p->chan == chan)
  1039da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  1039de:	75 f0                	jne    1039d0 <exit+0x90>
  1039e0:	3b 50 20             	cmp    0x20(%eax),%edx
  1039e3:	75 eb                	jne    1039d0 <exit+0x90>
      p->state = RUNNABLE;
  1039e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  1039ec:	83 c0 7c             	add    $0x7c,%eax
  1039ef:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  1039f4:	72 e4                	jb     1039da <exit+0x9a>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
  1039f6:	8b 1d 40 a8 10 00    	mov    0x10a840,%ebx
  1039fc:	ba d4 e0 10 00       	mov    $0x10e0d4,%edx
  103a01:	eb 10                	jmp    103a13 <exit+0xd3>
  103a03:	90                   	nop
  103a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103a08:	83 c2 7c             	add    $0x7c,%edx
  103a0b:	81 fa d4 ff 10 00    	cmp    $0x10ffd4,%edx
  103a11:	73 3b                	jae    103a4e <exit+0x10e>
    if(p->parent == proc){
  103a13:	3b 4a 14             	cmp    0x14(%edx),%ecx
  103a16:	75 f0                	jne    103a08 <exit+0xc8>
      if(p->state == ZOMBIE)
  103a18:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
  103a1c:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
  103a1f:	75 e7                	jne    103a08 <exit+0xc8>
  103a21:	b8 d4 e0 10 00       	mov    $0x10e0d4,%eax
  103a26:	eb 12                	jmp    103a3a <exit+0xfa>
  103a28:	90                   	nop
  103a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103a30:	83 c0 7c             	add    $0x7c,%eax
  103a33:	3d d4 ff 10 00       	cmp    $0x10ffd4,%eax
  103a38:	73 ce                	jae    103a08 <exit+0xc8>
    if(p->state == SLEEPING && p->chan == chan)
  103a3a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103a3e:	75 f0                	jne    103a30 <exit+0xf0>
  103a40:	3b 58 20             	cmp    0x20(%eax),%ebx
  103a43:	75 eb                	jne    103a30 <exit+0xf0>
      p->state = RUNNABLE;
  103a45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103a4c:	eb e2                	jmp    103a30 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
  103a4e:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
  103a55:	e8 66 fc ff ff       	call   1036c0 <sched>
  panic("zombie exit");
  103a5a:	83 ec 0c             	sub    $0xc,%esp
  103a5d:	68 20 63 10 00       	push   $0x106320
  103a62:	e8 a9 cd ff ff       	call   100810 <panic>
    panic("init exiting");
  103a67:	83 ec 0c             	sub    $0xc,%esp
  103a6a:	68 13 63 10 00       	push   $0x106313
  103a6f:	e8 9c cd ff ff       	call   100810 <panic>
  103a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103a80 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103a80:	56                   	push   %esi
  103a81:	53                   	push   %ebx
  103a82:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  103a85:	68 a0 e0 10 00       	push   $0x10e0a0
  103a8a:	e8 01 01 00 00       	call   103b90 <acquire>
  103a8f:	83 c4 10             	add    $0x10,%esp
  103a92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  103a98:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103a9a:	bb d4 e0 10 00       	mov    $0x10e0d4,%ebx
  103a9f:	eb 12                	jmp    103ab3 <wait+0x33>
  103aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103aa8:	83 c3 7c             	add    $0x7c,%ebx
  103aab:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
  103ab1:	73 1d                	jae    103ad0 <wait+0x50>
      if(p->parent != proc)
  103ab3:	3b 43 14             	cmp    0x14(%ebx),%eax
  103ab6:	75 f0                	jne    103aa8 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
  103ab8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  103abc:	74 30                	je     103aee <wait+0x6e>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103abe:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
  103ac1:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103ac6:	81 fb d4 ff 10 00    	cmp    $0x10ffd4,%ebx
  103acc:	72 e5                	jb     103ab3 <wait+0x33>
  103ace:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
  103ad0:	85 d2                	test   %edx,%edx
  103ad2:	74 70                	je     103b44 <wait+0xc4>
  103ad4:	8b 50 24             	mov    0x24(%eax),%edx
  103ad7:	85 d2                	test   %edx,%edx
  103ad9:	75 69                	jne    103b44 <wait+0xc4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  103adb:	83 ec 08             	sub    $0x8,%esp
  103ade:	68 a0 e0 10 00       	push   $0x10e0a0
  103ae3:	50                   	push   %eax
  103ae4:	e8 a7 fc ff ff       	call   103790 <sleep>
    havekids = 0;
  103ae9:	83 c4 10             	add    $0x10,%esp
  103aec:	eb a4                	jmp    103a92 <wait+0x12>
        kfree(p->mem, p->sz);
  103aee:	83 ec 08             	sub    $0x8,%esp
  103af1:	ff 73 04             	pushl  0x4(%ebx)
  103af4:	ff 33                	pushl  (%ebx)
        pid = p->pid;
  103af6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->mem, p->sz);
  103af9:	e8 32 e8 ff ff       	call   102330 <kfree>
        kfree(p->kstack, KSTACKSIZE);
  103afe:	59                   	pop    %ecx
  103aff:	58                   	pop    %eax
  103b00:	68 00 10 00 00       	push   $0x1000
  103b05:	ff 73 08             	pushl  0x8(%ebx)
  103b08:	e8 23 e8 ff ff       	call   102330 <kfree>
        p->state = UNUSED;
  103b0d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->pid = 0;
  103b14:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
  103b1b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
  103b22:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
  103b26:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        release(&ptable.lock);
  103b2d:	c7 04 24 a0 e0 10 00 	movl   $0x10e0a0,(%esp)
  103b34:	e8 f7 01 00 00       	call   103d30 <release>
        return pid;
  103b39:	83 c4 10             	add    $0x10,%esp
  }
}
  103b3c:	89 f0                	mov    %esi,%eax
  103b3e:	83 c4 04             	add    $0x4,%esp
  103b41:	5b                   	pop    %ebx
  103b42:	5e                   	pop    %esi
  103b43:	c3                   	ret    
      release(&ptable.lock);
  103b44:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  103b47:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
  103b4c:	68 a0 e0 10 00       	push   $0x10e0a0
  103b51:	e8 da 01 00 00       	call   103d30 <release>
      return -1;
  103b56:	83 c4 10             	add    $0x10,%esp
}
  103b59:	89 f0                	mov    %esi,%eax
  103b5b:	83 c4 04             	add    $0x4,%esp
  103b5e:	5b                   	pop    %ebx
  103b5f:	5e                   	pop    %esi
  103b60:	c3                   	ret    
  103b61:	66 90                	xchg   %ax,%ax
  103b63:	66 90                	xchg   %ax,%ax
  103b65:	66 90                	xchg   %ax,%ax
  103b67:	66 90                	xchg   %ax,%ax
  103b69:	66 90                	xchg   %ax,%ax
  103b6b:	66 90                	xchg   %ax,%ax
  103b6d:	66 90                	xchg   %ax,%ax
  103b6f:	90                   	nop

00103b70 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  103b70:	8b 44 24 04          	mov    0x4(%esp),%eax
  lk->name = name;
  103b74:	8b 54 24 08          	mov    0x8(%esp),%edx
  lk->locked = 0;
  103b78:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
  103b7e:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
  103b81:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  103b88:	c3                   	ret    
  103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103b90 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  103b90:	53                   	push   %ebx
  103b91:	83 ec 08             	sub    $0x8,%esp
  103b94:	9c                   	pushf  
  103b95:	59                   	pop    %ecx
  asm volatile("cli");
  103b96:	fa                   	cli    
{
  int eflags;
  
  eflags = readeflags();
  cli();
  if(cpu->ncli++ == 0)
  103b97:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103b9d:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103ba3:	8d 5a 01             	lea    0x1(%edx),%ebx
  103ba6:	85 d2                	test   %edx,%edx
  103ba8:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
  103bae:	75 0c                	jne    103bbc <acquire+0x2c>
    cpu->intena = eflags & FL_IF;
  103bb0:	81 e1 00 02 00 00    	and    $0x200,%ecx
  103bb6:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
  if(holding(lk))
  103bbc:	8b 54 24 10          	mov    0x10(%esp),%edx
  return lock->locked && lock->cpu == cpu;
  103bc0:	8b 0a                	mov    (%edx),%ecx
  103bc2:	85 c9                	test   %ecx,%ecx
  103bc4:	74 05                	je     103bcb <acquire+0x3b>
  103bc6:	39 42 08             	cmp    %eax,0x8(%edx)
  103bc9:	74 65                	je     103c30 <acquire+0xa0>
  asm volatile("lock; xchgl %0, %1" :
  103bcb:	b9 01 00 00 00       	mov    $0x1,%ecx
  103bd0:	89 c8                	mov    %ecx,%eax
  103bd2:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
  103bd5:	85 c0                	test   %eax,%eax
  103bd7:	75 f7                	jne    103bd0 <acquire+0x40>
  lk->cpu = cpu;
  103bd9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  ebp = (uint*)v - 2;
  103bdf:	8d 4c 24 08          	lea    0x8(%esp),%ecx
  getcallerpcs(&lk, lk->pcs);
  103be3:	83 c2 0c             	add    $0xc,%edx
  lk->cpu = cpu;
  103be6:	89 42 fc             	mov    %eax,-0x4(%edx)
  for(i = 0; i < 10; i++){
  103be9:	31 c0                	xor    %eax,%eax
  103beb:	90                   	nop
  103bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103bf0:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  103bf3:	83 fb fd             	cmp    $0xfffffffd,%ebx
  103bf6:	77 18                	ja     103c10 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
  103bf8:	8b 59 04             	mov    0x4(%ecx),%ebx
  103bfb:	89 1c 82             	mov    %ebx,(%edx,%eax,4)
  for(i = 0; i < 10; i++){
  103bfe:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
  103c01:	8b 09                	mov    (%ecx),%ecx
  for(i = 0; i < 10; i++){
  103c03:	83 f8 0a             	cmp    $0xa,%eax
  103c06:	75 e8                	jne    103bf0 <acquire+0x60>
}
  103c08:	83 c4 08             	add    $0x8,%esp
  103c0b:	5b                   	pop    %ebx
  103c0c:	c3                   	ret    
  103c0d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
  103c10:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
  for(; i < 10; i++)
  103c17:	83 c0 01             	add    $0x1,%eax
  103c1a:	83 f8 0a             	cmp    $0xa,%eax
  103c1d:	74 e9                	je     103c08 <acquire+0x78>
    pcs[i] = 0;
  103c1f:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
  for(; i < 10; i++)
  103c26:	83 c0 01             	add    $0x1,%eax
  103c29:	83 f8 0a             	cmp    $0xa,%eax
  103c2c:	75 e2                	jne    103c10 <acquire+0x80>
  103c2e:	eb d8                	jmp    103c08 <acquire+0x78>
    panic("acquire");
  103c30:	83 ec 0c             	sub    $0xc,%esp
  103c33:	68 70 63 10 00       	push   $0x106370
  103c38:	e8 d3 cb ff ff       	call   100810 <panic>
  103c3d:	8d 76 00             	lea    0x0(%esi),%esi

00103c40 <getcallerpcs>:
{
  103c40:	53                   	push   %ebx
  ebp = (uint*)v - 2;
  103c41:	8b 44 24 08          	mov    0x8(%esp),%eax
{
  103c45:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  ebp = (uint*)v - 2;
  103c49:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
  103c4c:	31 c0                	xor    %eax,%eax
  103c4e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103c50:	8d 5a ff             	lea    -0x1(%edx),%ebx
  103c53:	83 fb fd             	cmp    $0xfffffffd,%ebx
  103c56:	77 18                	ja     103c70 <getcallerpcs+0x30>
    pcs[i] = ebp[1];     // saved %eip
  103c58:	8b 5a 04             	mov    0x4(%edx),%ebx
  103c5b:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
  103c5e:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
  103c61:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
  103c63:	83 f8 0a             	cmp    $0xa,%eax
  103c66:	75 e8                	jne    103c50 <getcallerpcs+0x10>
}
  103c68:	5b                   	pop    %ebx
  103c69:	c3                   	ret    
  103c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pcs[i] = 0;
  103c70:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
  103c77:	83 c0 01             	add    $0x1,%eax
  103c7a:	83 f8 0a             	cmp    $0xa,%eax
  103c7d:	74 e9                	je     103c68 <getcallerpcs+0x28>
    pcs[i] = 0;
  103c7f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
  103c86:	83 c0 01             	add    $0x1,%eax
  103c89:	83 f8 0a             	cmp    $0xa,%eax
  103c8c:	75 e2                	jne    103c70 <getcallerpcs+0x30>
  103c8e:	eb d8                	jmp    103c68 <getcallerpcs+0x28>

00103c90 <holding>:
{
  103c90:	8b 54 24 04          	mov    0x4(%esp),%edx
  103c94:	31 c0                	xor    %eax,%eax
  return lock->locked && lock->cpu == cpu;
  103c96:	8b 0a                	mov    (%edx),%ecx
  103c98:	85 c9                	test   %ecx,%ecx
  103c9a:	74 0c                	je     103ca8 <holding+0x18>
  103c9c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103ca2:	39 42 08             	cmp    %eax,0x8(%edx)
  103ca5:	0f 94 c0             	sete   %al
  103ca8:	0f b6 c0             	movzbl %al,%eax
}
  103cab:	c3                   	ret    
  103cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103cb0 <pushcli>:
{
  103cb0:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103cb1:	9c                   	pushf  
  103cb2:	59                   	pop    %ecx
  asm volatile("cli");
  103cb3:	fa                   	cli    
  if(cpu->ncli++ == 0)
  103cb4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103cba:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103cc0:	8d 5a 01             	lea    0x1(%edx),%ebx
  103cc3:	85 d2                	test   %edx,%edx
  103cc5:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
  103ccb:	75 0c                	jne    103cd9 <pushcli+0x29>
    cpu->intena = eflags & FL_IF;
  103ccd:	81 e1 00 02 00 00    	and    $0x200,%ecx
  103cd3:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
  103cd9:	5b                   	pop    %ebx
  103cda:	c3                   	ret    
  103cdb:	90                   	nop
  103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103ce0 <popcli>:

void
popcli(void)
{
  103ce0:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103ce3:	9c                   	pushf  
  103ce4:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103ce5:	f6 c4 02             	test   $0x2,%ah
  103ce8:	75 2e                	jne    103d18 <popcli+0x38>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
  103cea:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
  103cf1:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
  103cf8:	78 11                	js     103d0b <popcli+0x2b>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
  103cfa:	75 0b                	jne    103d07 <popcli+0x27>
  103cfc:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
  103d02:	85 c0                	test   %eax,%eax
  103d04:	74 01                	je     103d07 <popcli+0x27>
  asm volatile("sti");
  103d06:	fb                   	sti    
    sti();
}
  103d07:	83 c4 0c             	add    $0xc,%esp
  103d0a:	c3                   	ret    
    panic("popcli");
  103d0b:	83 ec 0c             	sub    $0xc,%esp
  103d0e:	68 8f 63 10 00       	push   $0x10638f
  103d13:	e8 f8 ca ff ff       	call   100810 <panic>
    panic("popcli - interruptible");
  103d18:	83 ec 0c             	sub    $0xc,%esp
  103d1b:	68 78 63 10 00       	push   $0x106378
  103d20:	e8 eb ca ff ff       	call   100810 <panic>
  103d25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103d30 <release>:
{
  103d30:	83 ec 0c             	sub    $0xc,%esp
  103d33:	8b 54 24 10          	mov    0x10(%esp),%edx
  return lock->locked && lock->cpu == cpu;
  103d37:	8b 02                	mov    (%edx),%eax
  103d39:	85 c0                	test   %eax,%eax
  103d3b:	74 0b                	je     103d48 <release+0x18>
  103d3d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  103d43:	39 42 08             	cmp    %eax,0x8(%edx)
  103d46:	74 10                	je     103d58 <release+0x28>
    panic("release");
  103d48:	83 ec 0c             	sub    $0xc,%esp
  103d4b:	68 96 63 10 00       	push   $0x106396
  103d50:	e8 bb ca ff ff       	call   100810 <panic>
  103d55:	8d 76 00             	lea    0x0(%esi),%esi
  lk->pcs[0] = 0;
  103d58:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
  lk->cpu = 0;
  103d5f:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
  asm volatile("lock; xchgl %0, %1" :
  103d66:	31 c0                	xor    %eax,%eax
  103d68:	f0 87 02             	lock xchg %eax,(%edx)
}
  103d6b:	83 c4 0c             	add    $0xc,%esp
  popcli();
  103d6e:	e9 6d ff ff ff       	jmp    103ce0 <popcli>
  103d73:	66 90                	xchg   %ax,%ax
  103d75:	66 90                	xchg   %ax,%ax
  103d77:	66 90                	xchg   %ax,%ax
  103d79:	66 90                	xchg   %ax,%ax
  103d7b:	66 90                	xchg   %ax,%ax
  103d7d:	66 90                	xchg   %ax,%ax
  103d7f:	90                   	nop

00103d80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103d80:	57                   	push   %edi
  103d81:	8b 54 24 08          	mov    0x8(%esp),%edx
  asm volatile("cld; rep stosb" :
  103d85:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  103d89:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103d8d:	89 d7                	mov    %edx,%edi
  103d8f:	fc                   	cld    
  103d90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103d92:	89 d0                	mov    %edx,%eax
  103d94:	5f                   	pop    %edi
  103d95:	c3                   	ret    
  103d96:	8d 76 00             	lea    0x0(%esi),%esi
  103d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103da0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103da0:	57                   	push   %edi
  103da1:	56                   	push   %esi
  103da2:	53                   	push   %ebx
  103da3:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  103da7:	8b 74 24 10          	mov    0x10(%esp),%esi
  103dab:	8b 7c 24 14          	mov    0x14(%esp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103daf:	85 db                	test   %ebx,%ebx
  103db1:	74 29                	je     103ddc <memcmp+0x3c>
    if(*s1 != *s2)
  103db3:	0f b6 16             	movzbl (%esi),%edx
  103db6:	0f b6 0f             	movzbl (%edi),%ecx
  103db9:	38 d1                	cmp    %dl,%cl
  103dbb:	75 2b                	jne    103de8 <memcmp+0x48>
  103dbd:	b8 01 00 00 00       	mov    $0x1,%eax
  103dc2:	eb 14                	jmp    103dd8 <memcmp+0x38>
  103dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103dc8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
  103dcc:	83 c0 01             	add    $0x1,%eax
  103dcf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
  103dd4:	38 ca                	cmp    %cl,%dl
  103dd6:	75 10                	jne    103de8 <memcmp+0x48>
  while(n-- > 0){
  103dd8:	39 d8                	cmp    %ebx,%eax
  103dda:	75 ec                	jne    103dc8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103ddc:	5b                   	pop    %ebx
  return 0;
  103ddd:	31 c0                	xor    %eax,%eax
}
  103ddf:	5e                   	pop    %esi
  103de0:	5f                   	pop    %edi
  103de1:	c3                   	ret    
  103de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      return *s1 - *s2;
  103de8:	0f b6 c2             	movzbl %dl,%eax
}
  103deb:	5b                   	pop    %ebx
      return *s1 - *s2;
  103dec:	29 c8                	sub    %ecx,%eax
}
  103dee:	5e                   	pop    %esi
  103def:	5f                   	pop    %edi
  103df0:	c3                   	ret    
  103df1:	eb 0d                	jmp    103e00 <memmove>
  103df3:	90                   	nop
  103df4:	90                   	nop
  103df5:	90                   	nop
  103df6:	90                   	nop
  103df7:	90                   	nop
  103df8:	90                   	nop
  103df9:	90                   	nop
  103dfa:	90                   	nop
  103dfb:	90                   	nop
  103dfc:	90                   	nop
  103dfd:	90                   	nop
  103dfe:	90                   	nop
  103dff:	90                   	nop

00103e00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103e00:	56                   	push   %esi
  103e01:	53                   	push   %ebx
  103e02:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103e06:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103e0a:	8b 74 24 14          	mov    0x14(%esp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103e0e:	39 c3                	cmp    %eax,%ebx
  103e10:	73 26                	jae    103e38 <memmove+0x38>
  103e12:	8d 14 33             	lea    (%ebx,%esi,1),%edx
  103e15:	39 d0                	cmp    %edx,%eax
  103e17:	73 1f                	jae    103e38 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
  103e19:	85 f6                	test   %esi,%esi
  103e1b:	8d 56 ff             	lea    -0x1(%esi),%edx
  103e1e:	74 0f                	je     103e2f <memmove+0x2f>
      *--d = *--s;
  103e20:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  103e24:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
  103e27:	83 ea 01             	sub    $0x1,%edx
  103e2a:	83 fa ff             	cmp    $0xffffffff,%edx
  103e2d:	75 f1                	jne    103e20 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  103e2f:	5b                   	pop    %ebx
  103e30:	5e                   	pop    %esi
  103e31:	c3                   	ret    
  103e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
  103e38:	31 d2                	xor    %edx,%edx
  103e3a:	85 f6                	test   %esi,%esi
  103e3c:	74 f1                	je     103e2f <memmove+0x2f>
  103e3e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  103e40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  103e44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  103e47:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
  103e4a:	39 f2                	cmp    %esi,%edx
  103e4c:	75 f2                	jne    103e40 <memmove+0x40>
}
  103e4e:	5b                   	pop    %ebx
  103e4f:	5e                   	pop    %esi
  103e50:	c3                   	ret    
  103e51:	eb 0d                	jmp    103e60 <strncmp>
  103e53:	90                   	nop
  103e54:	90                   	nop
  103e55:	90                   	nop
  103e56:	90                   	nop
  103e57:	90                   	nop
  103e58:	90                   	nop
  103e59:	90                   	nop
  103e5a:	90                   	nop
  103e5b:	90                   	nop
  103e5c:	90                   	nop
  103e5d:	90                   	nop
  103e5e:	90                   	nop
  103e5f:	90                   	nop

00103e60 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  103e60:	57                   	push   %edi
  103e61:	56                   	push   %esi
  103e62:	53                   	push   %ebx
  103e63:	8b 7c 24 18          	mov    0x18(%esp),%edi
  103e67:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  103e6b:	8b 74 24 14          	mov    0x14(%esp),%esi
  while(n > 0 && *p && *p == *q)
  103e6f:	85 ff                	test   %edi,%edi
  103e71:	74 2f                	je     103ea2 <strncmp+0x42>
  103e73:	0f b6 11             	movzbl (%ecx),%edx
  103e76:	0f b6 1e             	movzbl (%esi),%ebx
  103e79:	84 d2                	test   %dl,%dl
  103e7b:	74 37                	je     103eb4 <strncmp+0x54>
  103e7d:	38 d3                	cmp    %dl,%bl
  103e7f:	75 33                	jne    103eb4 <strncmp+0x54>
  103e81:	01 f7                	add    %esi,%edi
  103e83:	eb 13                	jmp    103e98 <strncmp+0x38>
  103e85:	8d 76 00             	lea    0x0(%esi),%esi
  103e88:	0f b6 11             	movzbl (%ecx),%edx
  103e8b:	84 d2                	test   %dl,%dl
  103e8d:	74 21                	je     103eb0 <strncmp+0x50>
  103e8f:	0f b6 18             	movzbl (%eax),%ebx
  103e92:	89 c6                	mov    %eax,%esi
  103e94:	38 da                	cmp    %bl,%dl
  103e96:	75 1c                	jne    103eb4 <strncmp+0x54>
    n--, p++, q++;
  103e98:	8d 46 01             	lea    0x1(%esi),%eax
  103e9b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
  103e9e:	39 f8                	cmp    %edi,%eax
  103ea0:	75 e6                	jne    103e88 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  103ea2:	5b                   	pop    %ebx
    return 0;
  103ea3:	31 c0                	xor    %eax,%eax
}
  103ea5:	5e                   	pop    %esi
  103ea6:	5f                   	pop    %edi
  103ea7:	c3                   	ret    
  103ea8:	90                   	nop
  103ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103eb0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
  103eb4:	0f b6 c2             	movzbl %dl,%eax
  103eb7:	29 d8                	sub    %ebx,%eax
}
  103eb9:	5b                   	pop    %ebx
  103eba:	5e                   	pop    %esi
  103ebb:	5f                   	pop    %edi
  103ebc:	c3                   	ret    
  103ebd:	8d 76 00             	lea    0x0(%esi),%esi

00103ec0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  103ec0:	56                   	push   %esi
  103ec1:	53                   	push   %ebx
  103ec2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103ec6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103eca:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  103ece:	89 c2                	mov    %eax,%edx
  103ed0:	eb 19                	jmp    103eeb <strncpy+0x2b>
  103ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103ed8:	83 c3 01             	add    $0x1,%ebx
  103edb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
  103edf:	83 c2 01             	add    $0x1,%edx
  103ee2:	84 c9                	test   %cl,%cl
  103ee4:	88 4a ff             	mov    %cl,-0x1(%edx)
  103ee7:	74 09                	je     103ef2 <strncpy+0x32>
  103ee9:	89 f1                	mov    %esi,%ecx
  103eeb:	85 c9                	test   %ecx,%ecx
  103eed:	8d 71 ff             	lea    -0x1(%ecx),%esi
  103ef0:	7f e6                	jg     103ed8 <strncpy+0x18>
    ;
  while(n-- > 0)
  103ef2:	31 c9                	xor    %ecx,%ecx
  103ef4:	85 f6                	test   %esi,%esi
  103ef6:	7e 17                	jle    103f0f <strncpy+0x4f>
  103ef8:	90                   	nop
  103ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
  103f00:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
  103f04:	89 f3                	mov    %esi,%ebx
  103f06:	83 c1 01             	add    $0x1,%ecx
  103f09:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
  103f0b:	85 db                	test   %ebx,%ebx
  103f0d:	7f f1                	jg     103f00 <strncpy+0x40>
  return os;
}
  103f0f:	5b                   	pop    %ebx
  103f10:	5e                   	pop    %esi
  103f11:	c3                   	ret    
  103f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103f20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  103f20:	56                   	push   %esi
  103f21:	53                   	push   %ebx
  103f22:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  103f26:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103f2a:	8b 54 24 10          	mov    0x10(%esp),%edx
  char *os;
  
  os = s;
  if(n <= 0)
  103f2e:	85 c9                	test   %ecx,%ecx
  103f30:	7e 26                	jle    103f58 <safestrcpy+0x38>
  103f32:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
  103f36:	89 c1                	mov    %eax,%ecx
  103f38:	eb 17                	jmp    103f51 <safestrcpy+0x31>
  103f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  103f40:	83 c2 01             	add    $0x1,%edx
  103f43:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
  103f47:	83 c1 01             	add    $0x1,%ecx
  103f4a:	84 db                	test   %bl,%bl
  103f4c:	88 59 ff             	mov    %bl,-0x1(%ecx)
  103f4f:	74 04                	je     103f55 <safestrcpy+0x35>
  103f51:	39 f2                	cmp    %esi,%edx
  103f53:	75 eb                	jne    103f40 <safestrcpy+0x20>
    ;
  *s = 0;
  103f55:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  103f58:	5b                   	pop    %ebx
  103f59:	5e                   	pop    %esi
  103f5a:	c3                   	ret    
  103f5b:	90                   	nop
  103f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103f60 <strlen>:

int
strlen(const char *s)
{
  103f60:	8b 54 24 04          	mov    0x4(%esp),%edx
  int n;

  for(n = 0; s[n]; n++)
  103f64:	31 c0                	xor    %eax,%eax
  103f66:	80 3a 00             	cmpb   $0x0,(%edx)
  103f69:	74 10                	je     103f7b <strlen+0x1b>
  103f6b:	90                   	nop
  103f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103f70:	83 c0 01             	add    $0x1,%eax
  103f73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  103f77:	75 f7                	jne    103f70 <strlen+0x10>
  103f79:	f3 c3                	repz ret 
    ;
  return n;
}
  103f7b:	f3 c3                	repz ret 

00103f7d <swtch>:
  103f7d:	8b 44 24 04          	mov    0x4(%esp),%eax
  103f81:	8b 54 24 08          	mov    0x8(%esp),%edx
  103f85:	55                   	push   %ebp
  103f86:	53                   	push   %ebx
  103f87:	56                   	push   %esi
  103f88:	57                   	push   %edi
  103f89:	89 20                	mov    %esp,(%eax)
  103f8b:	89 d4                	mov    %edx,%esp
  103f8d:	5f                   	pop    %edi
  103f8e:	5e                   	pop    %esi
  103f8f:	5b                   	pop    %ebx
  103f90:	5d                   	pop    %ebp
  103f91:	c3                   	ret    
  103f92:	66 90                	xchg   %ax,%ax
  103f94:	66 90                	xchg   %ax,%ax
  103f96:	66 90                	xchg   %ax,%ax
  103f98:	66 90                	xchg   %ax,%ax
  103f9a:	66 90                	xchg   %ax,%ax
  103f9c:	66 90                	xchg   %ax,%ax
  103f9e:	66 90                	xchg   %ax,%ax

00103fa0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  103fa0:	53                   	push   %ebx
  103fa1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  103fa5:	8b 44 24 0c          	mov    0xc(%esp),%eax
  if(addr >= p->sz || addr+4 > p->sz)
  103fa9:	8b 51 04             	mov    0x4(%ecx),%edx
  103fac:	39 c2                	cmp    %eax,%edx
  103fae:	76 20                	jbe    103fd0 <fetchint+0x30>
  103fb0:	8d 58 04             	lea    0x4(%eax),%ebx
  103fb3:	39 da                	cmp    %ebx,%edx
  103fb5:	72 19                	jb     103fd0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(p->mem + addr);
  103fb7:	8b 11                	mov    (%ecx),%edx
  103fb9:	8b 14 02             	mov    (%edx,%eax,1),%edx
  103fbc:	8b 44 24 10          	mov    0x10(%esp),%eax
  103fc0:	89 10                	mov    %edx,(%eax)
  return 0;
  103fc2:	31 c0                	xor    %eax,%eax
}
  103fc4:	5b                   	pop    %ebx
  103fc5:	c3                   	ret    
  103fc6:	8d 76 00             	lea    0x0(%esi),%esi
  103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  103fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103fd5:	5b                   	pop    %ebx
  103fd6:	c3                   	ret    
  103fd7:	89 f6                	mov    %esi,%esi
  103fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103fe0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  103fe0:	8b 44 24 04          	mov    0x4(%esp),%eax
  103fe4:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  char *s, *ep;

  if(addr >= p->sz)
  103fe8:	39 48 04             	cmp    %ecx,0x4(%eax)
  103feb:	76 2f                	jbe    10401c <fetchstr+0x3c>
    return -1;
  *pp = p->mem + addr;
  103fed:	03 08                	add    (%eax),%ecx
  103fef:	8b 54 24 0c          	mov    0xc(%esp),%edx
  103ff3:	89 0a                	mov    %ecx,(%edx)
  ep = p->mem + p->sz;
  103ff5:	8b 50 04             	mov    0x4(%eax),%edx
  103ff8:	03 10                	add    (%eax),%edx
  for(s = *pp; s < ep; s++)
  103ffa:	39 d1                	cmp    %edx,%ecx
  103ffc:	73 1e                	jae    10401c <fetchstr+0x3c>
    if(*s == 0)
  103ffe:	80 39 00             	cmpb   $0x0,(%ecx)
  104001:	74 28                	je     10402b <fetchstr+0x4b>
  104003:	89 c8                	mov    %ecx,%eax
  104005:	eb 0e                	jmp    104015 <fetchstr+0x35>
  104007:	89 f6                	mov    %esi,%esi
  104009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  104010:	80 38 00             	cmpb   $0x0,(%eax)
  104013:	74 13                	je     104028 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
  104015:	83 c0 01             	add    $0x1,%eax
  104018:	39 c2                	cmp    %eax,%edx
  10401a:	75 f4                	jne    104010 <fetchstr+0x30>
    return -1;
  10401c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104021:	c3                   	ret    
  104022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104028:	29 c8                	sub    %ecx,%eax
  10402a:	c3                   	ret    
    if(*s == 0)
  10402b:	31 c0                	xor    %eax,%eax
      return s - *pp;
  10402d:	c3                   	ret    
  10402e:	66 90                	xchg   %ax,%ax

00104030 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104030:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
  104036:	53                   	push   %ebx
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104037:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  10403b:	8b 50 18             	mov    0x18(%eax),%edx
  10403e:	8b 52 44             	mov    0x44(%edx),%edx
  104041:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
  if(addr >= p->sz || addr+4 > p->sz)
  104044:	8b 48 04             	mov    0x4(%eax),%ecx
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104047:	8d 5a 04             	lea    0x4(%edx),%ebx
  if(addr >= p->sz || addr+4 > p->sz)
  10404a:	39 cb                	cmp    %ecx,%ebx
  10404c:	73 1a                	jae    104068 <argint+0x38>
  10404e:	8d 5a 08             	lea    0x8(%edx),%ebx
  104051:	39 d9                	cmp    %ebx,%ecx
  104053:	72 13                	jb     104068 <argint+0x38>
  *ip = *(int*)(p->mem + addr);
  104055:	8b 00                	mov    (%eax),%eax
  104057:	8b 54 10 04          	mov    0x4(%eax,%edx,1),%edx
  10405b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10405f:	89 10                	mov    %edx,(%eax)
  return 0;
  104061:	31 c0                	xor    %eax,%eax
}
  104063:	5b                   	pop    %ebx
  104064:	c3                   	ret    
  104065:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  104068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10406d:	5b                   	pop    %ebx
  10406e:	c3                   	ret    
  10406f:	90                   	nop

00104070 <argptr>:
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104070:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  104077:	56                   	push   %esi
  104078:	53                   	push   %ebx
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  104079:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  10407d:	8b 42 18             	mov    0x18(%edx),%eax
  104080:	8b 40 44             	mov    0x44(%eax),%eax
  104083:	8d 1c 88             	lea    (%eax,%ecx,4),%ebx
  if(addr >= p->sz || addr+4 > p->sz)
  104086:	8b 4a 04             	mov    0x4(%edx),%ecx
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  104089:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  10408e:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= p->sz || addr+4 > p->sz)
  104091:	39 ce                	cmp    %ecx,%esi
  104093:	73 25                	jae    1040ba <argptr+0x4a>
  104095:	8d 73 08             	lea    0x8(%ebx),%esi
  104098:	39 f1                	cmp    %esi,%ecx
  10409a:	72 1e                	jb     1040ba <argptr+0x4a>
  *ip = *(int*)(p->mem + addr);
  10409c:	8b 12                	mov    (%edx),%edx
  if((uint)i >= proc->sz || (uint)i+size >= proc->sz)
  10409e:	8b 5c 1a 04          	mov    0x4(%edx,%ebx,1),%ebx
  1040a2:	39 cb                	cmp    %ecx,%ebx
  1040a4:	73 14                	jae    1040ba <argptr+0x4a>
  1040a6:	8b 74 24 14          	mov    0x14(%esp),%esi
  1040aa:	01 de                	add    %ebx,%esi
  1040ac:	39 ce                	cmp    %ecx,%esi
  1040ae:	73 0a                	jae    1040ba <argptr+0x4a>
    return -1;
  *pp = proc->mem + i;
  1040b0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1040b4:	01 da                	add    %ebx,%edx
  1040b6:	89 10                	mov    %edx,(%eax)
  return 0;
  1040b8:	31 c0                	xor    %eax,%eax
}
  1040ba:	5b                   	pop    %ebx
  1040bb:	5e                   	pop    %esi
  1040bc:	c3                   	ret    
  1040bd:	8d 76 00             	lea    0x0(%esi),%esi

001040c0 <argstr>:
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  1040c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  1040c6:	53                   	push   %ebx
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  1040c7:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1040cb:	8b 50 18             	mov    0x18(%eax),%edx
  1040ce:	8b 52 44             	mov    0x44(%edx),%edx
  1040d1:	8d 1c 8a             	lea    (%edx,%ecx,4),%ebx
  if(addr >= p->sz || addr+4 > p->sz)
  1040d4:	8b 50 04             	mov    0x4(%eax),%edx
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
  1040d7:	8d 4b 04             	lea    0x4(%ebx),%ecx
  if(addr >= p->sz || addr+4 > p->sz)
  1040da:	39 d1                	cmp    %edx,%ecx
  1040dc:	73 3e                	jae    10411c <argstr+0x5c>
  1040de:	8d 4b 08             	lea    0x8(%ebx),%ecx
  1040e1:	39 ca                	cmp    %ecx,%edx
  1040e3:	72 37                	jb     10411c <argstr+0x5c>
  *ip = *(int*)(p->mem + addr);
  1040e5:	8b 08                	mov    (%eax),%ecx
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(proc, addr, pp);
  1040e7:	8b 5c 19 04          	mov    0x4(%ecx,%ebx,1),%ebx
  if(addr >= p->sz)
  1040eb:	39 d3                	cmp    %edx,%ebx
  1040ed:	73 2d                	jae    10411c <argstr+0x5c>
  *pp = p->mem + addr;
  1040ef:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1040f3:	01 d9                	add    %ebx,%ecx
  1040f5:	89 0a                	mov    %ecx,(%edx)
  ep = p->mem + p->sz;
  1040f7:	8b 50 04             	mov    0x4(%eax),%edx
  1040fa:	03 10                	add    (%eax),%edx
  for(s = *pp; s < ep; s++)
  1040fc:	39 d1                	cmp    %edx,%ecx
  1040fe:	73 1c                	jae    10411c <argstr+0x5c>
    if(*s == 0)
  104100:	80 39 00             	cmpb   $0x0,(%ecx)
  104103:	74 27                	je     10412c <argstr+0x6c>
  104105:	89 c8                	mov    %ecx,%eax
  104107:	eb 0c                	jmp    104115 <argstr+0x55>
  104109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104110:	80 38 00             	cmpb   $0x0,(%eax)
  104113:	74 13                	je     104128 <argstr+0x68>
  for(s = *pp; s < ep; s++)
  104115:	83 c0 01             	add    $0x1,%eax
  104118:	39 c2                	cmp    %eax,%edx
  10411a:	75 f4                	jne    104110 <argstr+0x50>
    return -1;
  10411c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104121:	5b                   	pop    %ebx
  104122:	c3                   	ret    
  104123:	90                   	nop
  104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104128:	29 c8                	sub    %ecx,%eax
  10412a:	5b                   	pop    %ebx
  10412b:	c3                   	ret    
    if(*s == 0)
  10412c:	31 c0                	xor    %eax,%eax
}
  10412e:	5b                   	pop    %ebx
  10412f:	c3                   	ret    

00104130 <syscall>:
[SYS_write]   sys_write,
};

void
syscall(void)
{
  104130:	53                   	push   %ebx
  104131:	83 ec 08             	sub    $0x8,%esp
  int num;
  
  num = proc->tf->eax;
  104134:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10413a:	8b 58 18             	mov    0x18(%eax),%ebx
  10413d:	8b 53 1c             	mov    0x1c(%ebx),%edx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  104140:	83 fa 14             	cmp    $0x14,%edx
  104143:	77 1b                	ja     104160 <syscall+0x30>
  104145:	8b 0c 95 c0 63 10 00 	mov    0x1063c0(,%edx,4),%ecx
  10414c:	85 c9                	test   %ecx,%ecx
  10414e:	74 10                	je     104160 <syscall+0x30>
    proc->tf->eax = syscalls[num]();
  104150:	ff d1                	call   *%ecx
  104152:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
  104155:	83 c4 08             	add    $0x8,%esp
  104158:	5b                   	pop    %ebx
  104159:	c3                   	ret    
  10415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
  104160:	8b 48 10             	mov    0x10(%eax),%ecx
            proc->pid, proc->name, num);
  104163:	83 c0 6c             	add    $0x6c,%eax
    cprintf("%d %s: unknown sys call %d\n",
  104166:	52                   	push   %edx
  104167:	50                   	push   %eax
  104168:	51                   	push   %ecx
  104169:	68 9e 63 10 00       	push   $0x10639e
  10416e:	e8 1d c5 ff ff       	call   100690 <cprintf>
    proc->tf->eax = -1;
  104173:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104179:	83 c4 10             	add    $0x10,%esp
  10417c:	8b 40 18             	mov    0x18(%eax),%eax
  10417f:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
  104186:	83 c4 08             	add    $0x8,%esp
  104189:	5b                   	pop    %ebx
  10418a:	c3                   	ret    
  10418b:	66 90                	xchg   %ax,%ax
  10418d:	66 90                	xchg   %ax,%ax
  10418f:	90                   	nop

00104190 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  104190:	55                   	push   %ebp
  104191:	57                   	push   %edi
  104192:	56                   	push   %esi
  104193:	53                   	push   %ebx
  104194:	89 d6                	mov    %edx,%esi
  104196:	83 ec 44             	sub    $0x44,%esp
  104199:	8b 54 24 58          	mov    0x58(%esp),%edx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  10419d:	8d 5c 24 2a          	lea    0x2a(%esp),%ebx
{
  1041a1:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  1041a5:	89 54 24 14          	mov    %edx,0x14(%esp)
  if((dp = nameiparent(path, name)) == 0)
  1041a9:	53                   	push   %ebx
  1041aa:	50                   	push   %eax
  1041ab:	e8 60 dd ff ff       	call   101f10 <nameiparent>
  1041b0:	83 c4 10             	add    $0x10,%esp
  1041b3:	85 c0                	test   %eax,%eax
  1041b5:	0f 84 f5 00 00 00    	je     1042b0 <create+0x120>
    return 0;
  ilock(dp);
  1041bb:	83 ec 0c             	sub    $0xc,%esp
  1041be:	89 c5                	mov    %eax,%ebp
  1041c0:	50                   	push   %eax
  1041c1:	e8 5a d4 ff ff       	call   101620 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  1041c6:	83 c4 0c             	add    $0xc,%esp
  1041c9:	8d 44 24 20          	lea    0x20(%esp),%eax
  1041cd:	50                   	push   %eax
  1041ce:	53                   	push   %ebx
  1041cf:	55                   	push   %ebp
  1041d0:	e8 bb d9 ff ff       	call   101b90 <dirlookup>
  1041d5:	83 c4 10             	add    $0x10,%esp
  1041d8:	85 c0                	test   %eax,%eax
  1041da:	89 c7                	mov    %eax,%edi
  1041dc:	74 52                	je     104230 <create+0xa0>
    iunlockput(dp);
  1041de:	83 ec 0c             	sub    $0xc,%esp
  1041e1:	55                   	push   %ebp
  1041e2:	e8 f9 d6 ff ff       	call   1018e0 <iunlockput>
    ilock(ip);
  1041e7:	89 3c 24             	mov    %edi,(%esp)
  1041ea:	e8 31 d4 ff ff       	call   101620 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
  1041ef:	83 c4 10             	add    $0x10,%esp
  1041f2:	66 83 fe 02          	cmp    $0x2,%si
  1041f6:	75 18                	jne    104210 <create+0x80>
  1041f8:	66 83 7f 10 02       	cmpw   $0x2,0x10(%edi)
  1041fd:	75 11                	jne    104210 <create+0x80>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  1041ff:	83 c4 3c             	add    $0x3c,%esp
  104202:	89 f8                	mov    %edi,%eax
  104204:	5b                   	pop    %ebx
  104205:	5e                   	pop    %esi
  104206:	5f                   	pop    %edi
  104207:	5d                   	pop    %ebp
  104208:	c3                   	ret    
  104209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
  104210:	83 ec 0c             	sub    $0xc,%esp
  104213:	57                   	push   %edi
    return 0;
  104214:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
  104216:	e8 c5 d6 ff ff       	call   1018e0 <iunlockput>
    return 0;
  10421b:	83 c4 10             	add    $0x10,%esp
}
  10421e:	89 f8                	mov    %edi,%eax
  104220:	83 c4 3c             	add    $0x3c,%esp
  104223:	5b                   	pop    %ebx
  104224:	5e                   	pop    %esi
  104225:	5f                   	pop    %edi
  104226:	5d                   	pop    %ebp
  104227:	c3                   	ret    
  104228:	90                   	nop
  104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
  104230:	83 ec 08             	sub    $0x8,%esp
  104233:	0f bf c6             	movswl %si,%eax
  104236:	50                   	push   %eax
  104237:	ff 75 00             	pushl  0x0(%ebp)
  10423a:	e8 71 d2 ff ff       	call   1014b0 <ialloc>
  10423f:	83 c4 10             	add    $0x10,%esp
  104242:	85 c0                	test   %eax,%eax
  104244:	89 c7                	mov    %eax,%edi
  104246:	0f 84 cc 00 00 00    	je     104318 <create+0x188>
  ilock(ip);
  10424c:	83 ec 0c             	sub    $0xc,%esp
  10424f:	50                   	push   %eax
  104250:	e8 cb d3 ff ff       	call   101620 <ilock>
  ip->major = major;
  104255:	0f b7 44 24 18       	movzwl 0x18(%esp),%eax
  10425a:	66 89 47 12          	mov    %ax,0x12(%edi)
  ip->minor = minor;
  10425e:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  104263:	66 89 47 14          	mov    %ax,0x14(%edi)
  ip->nlink = 1;
  104267:	b8 01 00 00 00       	mov    $0x1,%eax
  10426c:	66 89 47 16          	mov    %ax,0x16(%edi)
  iupdate(ip);
  104270:	89 3c 24             	mov    %edi,(%esp)
  104273:	e8 f8 d2 ff ff       	call   101570 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
  104278:	83 c4 10             	add    $0x10,%esp
  10427b:	66 83 fe 01          	cmp    $0x1,%si
  10427f:	74 3f                	je     1042c0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
  104281:	83 ec 04             	sub    $0x4,%esp
  104284:	ff 77 04             	pushl  0x4(%edi)
  104287:	53                   	push   %ebx
  104288:	55                   	push   %ebp
  104289:	e8 a2 db ff ff       	call   101e30 <dirlink>
  10428e:	83 c4 10             	add    $0x10,%esp
  104291:	85 c0                	test   %eax,%eax
  104293:	78 76                	js     10430b <create+0x17b>
  iunlockput(dp);
  104295:	83 ec 0c             	sub    $0xc,%esp
  104298:	55                   	push   %ebp
  104299:	e8 42 d6 ff ff       	call   1018e0 <iunlockput>
  return ip;
  10429e:	83 c4 10             	add    $0x10,%esp
}
  1042a1:	89 f8                	mov    %edi,%eax
  1042a3:	83 c4 3c             	add    $0x3c,%esp
  1042a6:	5b                   	pop    %ebx
  1042a7:	5e                   	pop    %esi
  1042a8:	5f                   	pop    %edi
  1042a9:	5d                   	pop    %ebp
  1042aa:	c3                   	ret    
  1042ab:	90                   	nop
  1042ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  1042b0:	31 ff                	xor    %edi,%edi
  1042b2:	e9 48 ff ff ff       	jmp    1041ff <create+0x6f>
  1042b7:	89 f6                	mov    %esi,%esi
  1042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    dp->nlink++;  // for ".."
  1042c0:	66 83 45 16 01       	addw   $0x1,0x16(%ebp)
    iupdate(dp);
  1042c5:	83 ec 0c             	sub    $0xc,%esp
  1042c8:	55                   	push   %ebp
  1042c9:	e8 a2 d2 ff ff       	call   101570 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  1042ce:	83 c4 0c             	add    $0xc,%esp
  1042d1:	ff 77 04             	pushl  0x4(%edi)
  1042d4:	68 30 64 10 00       	push   $0x106430
  1042d9:	57                   	push   %edi
  1042da:	e8 51 db ff ff       	call   101e30 <dirlink>
  1042df:	83 c4 10             	add    $0x10,%esp
  1042e2:	85 c0                	test   %eax,%eax
  1042e4:	78 18                	js     1042fe <create+0x16e>
  1042e6:	83 ec 04             	sub    $0x4,%esp
  1042e9:	ff 75 04             	pushl  0x4(%ebp)
  1042ec:	68 2f 64 10 00       	push   $0x10642f
  1042f1:	57                   	push   %edi
  1042f2:	e8 39 db ff ff       	call   101e30 <dirlink>
  1042f7:	83 c4 10             	add    $0x10,%esp
  1042fa:	85 c0                	test   %eax,%eax
  1042fc:	79 83                	jns    104281 <create+0xf1>
      panic("create dots");
  1042fe:	83 ec 0c             	sub    $0xc,%esp
  104301:	68 23 64 10 00       	push   $0x106423
  104306:	e8 05 c5 ff ff       	call   100810 <panic>
    panic("create: dirlink");
  10430b:	83 ec 0c             	sub    $0xc,%esp
  10430e:	68 32 64 10 00       	push   $0x106432
  104313:	e8 f8 c4 ff ff       	call   100810 <panic>
    panic("create: ialloc");
  104318:	83 ec 0c             	sub    $0xc,%esp
  10431b:	68 14 64 10 00       	push   $0x106414
  104320:	e8 eb c4 ff ff       	call   100810 <panic>
  104325:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104330 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
  104330:	56                   	push   %esi
  104331:	53                   	push   %ebx
  104332:	89 c6                	mov    %eax,%esi
  104334:	89 d3                	mov    %edx,%ebx
  104336:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(n, &fd) < 0)
  104339:	8d 44 24 14          	lea    0x14(%esp),%eax
  10433d:	50                   	push   %eax
  10433e:	6a 00                	push   $0x0
  104340:	e8 eb fc ff ff       	call   104030 <argint>
  104345:	83 c4 10             	add    $0x10,%esp
  104348:	85 c0                	test   %eax,%eax
  10434a:	78 3c                	js     104388 <argfd.constprop.0+0x58>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
  10434c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104350:	83 f8 0f             	cmp    $0xf,%eax
  104353:	77 33                	ja     104388 <argfd.constprop.0+0x58>
  104355:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  10435c:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
  104360:	85 d2                	test   %edx,%edx
  104362:	74 24                	je     104388 <argfd.constprop.0+0x58>
  if(pfd)
  104364:	85 f6                	test   %esi,%esi
  104366:	74 02                	je     10436a <argfd.constprop.0+0x3a>
    *pfd = fd;
  104368:	89 06                	mov    %eax,(%esi)
  if(pf)
  10436a:	85 db                	test   %ebx,%ebx
  10436c:	74 12                	je     104380 <argfd.constprop.0+0x50>
    *pf = f;
  10436e:	89 13                	mov    %edx,(%ebx)
  return 0;
  104370:	31 c0                	xor    %eax,%eax
}
  104372:	83 c4 14             	add    $0x14,%esp
  104375:	5b                   	pop    %ebx
  104376:	5e                   	pop    %esi
  104377:	c3                   	ret    
  104378:	90                   	nop
  104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
  104380:	31 c0                	xor    %eax,%eax
  104382:	eb ee                	jmp    104372 <argfd.constprop.0+0x42>
  104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  104388:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10438d:	eb e3                	jmp    104372 <argfd.constprop.0+0x42>
  10438f:	90                   	nop

00104390 <sys_dup>:
{
  104390:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
  104391:	31 c0                	xor    %eax,%eax
{
  104393:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0)
  104396:	8d 54 24 0c          	lea    0xc(%esp),%edx
  10439a:	e8 91 ff ff ff       	call   104330 <argfd.constprop.0>
  10439f:	85 c0                	test   %eax,%eax
  1043a1:	78 1d                	js     1043c0 <sys_dup+0x30>
  if((fd=fdalloc(f)) < 0)
  1043a3:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1043a7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
  1043ad:	31 db                	xor    %ebx,%ebx
  1043af:	90                   	nop
    if(proc->ofile[fd] == 0){
  1043b0:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
  1043b4:	85 c9                	test   %ecx,%ecx
  1043b6:	74 18                	je     1043d0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
  1043b8:	83 c3 01             	add    $0x1,%ebx
  1043bb:	83 fb 10             	cmp    $0x10,%ebx
  1043be:	75 f0                	jne    1043b0 <sys_dup+0x20>
    return -1;
  1043c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  1043c5:	83 c4 18             	add    $0x18,%esp
  1043c8:	89 d8                	mov    %ebx,%eax
  1043ca:	5b                   	pop    %ebx
  1043cb:	c3                   	ret    
  1043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
  1043d0:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
  1043d3:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
  1043d7:	52                   	push   %edx
  1043d8:	e8 f3 ca ff ff       	call   100ed0 <filedup>
  return fd;
  1043dd:	83 c4 10             	add    $0x10,%esp
}
  1043e0:	89 d8                	mov    %ebx,%eax
  1043e2:	83 c4 18             	add    $0x18,%esp
  1043e5:	5b                   	pop    %ebx
  1043e6:	c3                   	ret    
  1043e7:	89 f6                	mov    %esi,%esi
  1043e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001043f0 <sys_read>:
{
  1043f0:	83 ec 1c             	sub    $0x1c,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1043f3:	31 c0                	xor    %eax,%eax
  1043f5:	8d 54 24 04          	lea    0x4(%esp),%edx
  1043f9:	e8 32 ff ff ff       	call   104330 <argfd.constprop.0>
  1043fe:	85 c0                	test   %eax,%eax
  104400:	78 4e                	js     104450 <sys_read+0x60>
  104402:	83 ec 08             	sub    $0x8,%esp
  104405:	8d 44 24 10          	lea    0x10(%esp),%eax
  104409:	50                   	push   %eax
  10440a:	6a 02                	push   $0x2
  10440c:	e8 1f fc ff ff       	call   104030 <argint>
  104411:	83 c4 10             	add    $0x10,%esp
  104414:	85 c0                	test   %eax,%eax
  104416:	78 38                	js     104450 <sys_read+0x60>
  104418:	83 ec 04             	sub    $0x4,%esp
  10441b:	ff 74 24 0c          	pushl  0xc(%esp)
  10441f:	8d 44 24 14          	lea    0x14(%esp),%eax
  104423:	50                   	push   %eax
  104424:	6a 01                	push   $0x1
  104426:	e8 45 fc ff ff       	call   104070 <argptr>
  10442b:	83 c4 10             	add    $0x10,%esp
  10442e:	85 c0                	test   %eax,%eax
  104430:	78 1e                	js     104450 <sys_read+0x60>
  return fileread(f, p, n);
  104432:	83 ec 04             	sub    $0x4,%esp
  104435:	ff 74 24 0c          	pushl  0xc(%esp)
  104439:	ff 74 24 14          	pushl  0x14(%esp)
  10443d:	ff 74 24 10          	pushl  0x10(%esp)
  104441:	e8 ea cb ff ff       	call   101030 <fileread>
  104446:	83 c4 10             	add    $0x10,%esp
}
  104449:	83 c4 1c             	add    $0x1c,%esp
  10444c:	c3                   	ret    
  10444d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  104450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104455:	83 c4 1c             	add    $0x1c,%esp
  104458:	c3                   	ret    
  104459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104460 <sys_write>:
{
  104460:	83 ec 1c             	sub    $0x1c,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104463:	31 c0                	xor    %eax,%eax
  104465:	8d 54 24 04          	lea    0x4(%esp),%edx
  104469:	e8 c2 fe ff ff       	call   104330 <argfd.constprop.0>
  10446e:	85 c0                	test   %eax,%eax
  104470:	78 4e                	js     1044c0 <sys_write+0x60>
  104472:	83 ec 08             	sub    $0x8,%esp
  104475:	8d 44 24 10          	lea    0x10(%esp),%eax
  104479:	50                   	push   %eax
  10447a:	6a 02                	push   $0x2
  10447c:	e8 af fb ff ff       	call   104030 <argint>
  104481:	83 c4 10             	add    $0x10,%esp
  104484:	85 c0                	test   %eax,%eax
  104486:	78 38                	js     1044c0 <sys_write+0x60>
  104488:	83 ec 04             	sub    $0x4,%esp
  10448b:	ff 74 24 0c          	pushl  0xc(%esp)
  10448f:	8d 44 24 14          	lea    0x14(%esp),%eax
  104493:	50                   	push   %eax
  104494:	6a 01                	push   $0x1
  104496:	e8 d5 fb ff ff       	call   104070 <argptr>
  10449b:	83 c4 10             	add    $0x10,%esp
  10449e:	85 c0                	test   %eax,%eax
  1044a0:	78 1e                	js     1044c0 <sys_write+0x60>
  return filewrite(f, p, n);
  1044a2:	83 ec 04             	sub    $0x4,%esp
  1044a5:	ff 74 24 0c          	pushl  0xc(%esp)
  1044a9:	ff 74 24 14          	pushl  0x14(%esp)
  1044ad:	ff 74 24 10          	pushl  0x10(%esp)
  1044b1:	e8 0a cc ff ff       	call   1010c0 <filewrite>
  1044b6:	83 c4 10             	add    $0x10,%esp
}
  1044b9:	83 c4 1c             	add    $0x1c,%esp
  1044bc:	c3                   	ret    
  1044bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  1044c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1044c5:	83 c4 1c             	add    $0x1c,%esp
  1044c8:	c3                   	ret    
  1044c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001044d0 <sys_close>:
{
  1044d0:	83 ec 1c             	sub    $0x1c,%esp
  if(argfd(0, &fd, &f) < 0)
  1044d3:	8d 54 24 0c          	lea    0xc(%esp),%edx
  1044d7:	8d 44 24 08          	lea    0x8(%esp),%eax
  1044db:	e8 50 fe ff ff       	call   104330 <argfd.constprop.0>
  1044e0:	85 c0                	test   %eax,%eax
  1044e2:	78 2c                	js     104510 <sys_close+0x40>
  proc->ofile[fd] = 0;
  1044e4:	8b 54 24 08          	mov    0x8(%esp),%edx
  1044e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
  1044ee:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
  1044f1:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
  1044f8:	00 
  fileclose(f);
  1044f9:	ff 74 24 18          	pushl  0x18(%esp)
  1044fd:	e8 1e ca ff ff       	call   100f20 <fileclose>
  return 0;
  104502:	83 c4 10             	add    $0x10,%esp
  104505:	31 c0                	xor    %eax,%eax
}
  104507:	83 c4 1c             	add    $0x1c,%esp
  10450a:	c3                   	ret    
  10450b:	90                   	nop
  10450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  104510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104515:	eb f0                	jmp    104507 <sys_close+0x37>
  104517:	89 f6                	mov    %esi,%esi
  104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104520 <sys_fstat>:
{
  104520:	83 ec 1c             	sub    $0x1c,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104523:	31 c0                	xor    %eax,%eax
  104525:	8d 54 24 08          	lea    0x8(%esp),%edx
  104529:	e8 02 fe ff ff       	call   104330 <argfd.constprop.0>
  10452e:	85 c0                	test   %eax,%eax
  104530:	78 36                	js     104568 <sys_fstat+0x48>
  104532:	83 ec 04             	sub    $0x4,%esp
  104535:	6a 14                	push   $0x14
  104537:	8d 44 24 14          	lea    0x14(%esp),%eax
  10453b:	50                   	push   %eax
  10453c:	6a 01                	push   $0x1
  10453e:	e8 2d fb ff ff       	call   104070 <argptr>
  104543:	83 c4 10             	add    $0x10,%esp
  104546:	85 c0                	test   %eax,%eax
  104548:	78 1e                	js     104568 <sys_fstat+0x48>
  return filestat(f, st);
  10454a:	83 ec 08             	sub    $0x8,%esp
  10454d:	ff 74 24 14          	pushl  0x14(%esp)
  104551:	ff 74 24 14          	pushl  0x14(%esp)
  104555:	e8 86 ca ff ff       	call   100fe0 <filestat>
  10455a:	83 c4 10             	add    $0x10,%esp
}
  10455d:	83 c4 1c             	add    $0x1c,%esp
  104560:	c3                   	ret    
  104561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  104568:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10456d:	eb ee                	jmp    10455d <sys_fstat+0x3d>
  10456f:	90                   	nop

00104570 <sys_link>:
{
  104570:	57                   	push   %edi
  104571:	56                   	push   %esi
  104572:	53                   	push   %ebx
  104573:	83 ec 28             	sub    $0x28,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104576:	8d 44 24 14          	lea    0x14(%esp),%eax
  10457a:	50                   	push   %eax
  10457b:	6a 00                	push   $0x0
  10457d:	e8 3e fb ff ff       	call   1040c0 <argstr>
  104582:	83 c4 10             	add    $0x10,%esp
  104585:	85 c0                	test   %eax,%eax
  104587:	0f 88 f0 00 00 00    	js     10467d <sys_link+0x10d>
  10458d:	83 ec 08             	sub    $0x8,%esp
  104590:	8d 44 24 10          	lea    0x10(%esp),%eax
  104594:	50                   	push   %eax
  104595:	6a 01                	push   $0x1
  104597:	e8 24 fb ff ff       	call   1040c0 <argstr>
  10459c:	83 c4 10             	add    $0x10,%esp
  10459f:	85 c0                	test   %eax,%eax
  1045a1:	0f 88 d6 00 00 00    	js     10467d <sys_link+0x10d>
  if((ip = namei(old)) == 0)
  1045a7:	83 ec 0c             	sub    $0xc,%esp
  1045aa:	ff 74 24 18          	pushl  0x18(%esp)
  1045ae:	e8 3d d9 ff ff       	call   101ef0 <namei>
  1045b3:	83 c4 10             	add    $0x10,%esp
  1045b6:	85 c0                	test   %eax,%eax
  1045b8:	89 c3                	mov    %eax,%ebx
  1045ba:	0f 84 bd 00 00 00    	je     10467d <sys_link+0x10d>
  ilock(ip);
  1045c0:	83 ec 0c             	sub    $0xc,%esp
  1045c3:	50                   	push   %eax
  1045c4:	e8 57 d0 ff ff       	call   101620 <ilock>
  if(ip->type == T_DIR){
  1045c9:	83 c4 10             	add    $0x10,%esp
  1045cc:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1045d1:	0f 84 b9 00 00 00    	je     104690 <sys_link+0x120>
  ip->nlink++;
  1045d7:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  1045dc:	83 ec 0c             	sub    $0xc,%esp
  1045df:	53                   	push   %ebx
  1045e0:	e8 8b cf ff ff       	call   101570 <iupdate>
  iunlock(ip);
  1045e5:	89 1c 24             	mov    %ebx,(%esp)
  1045e8:	e8 43 d1 ff ff       	call   101730 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
  1045ed:	58                   	pop    %eax
  1045ee:	5a                   	pop    %edx
  1045ef:	8d 7c 24 1a          	lea    0x1a(%esp),%edi
  1045f3:	57                   	push   %edi
  1045f4:	ff 74 24 14          	pushl  0x14(%esp)
  1045f8:	e8 13 d9 ff ff       	call   101f10 <nameiparent>
  1045fd:	83 c4 10             	add    $0x10,%esp
  104600:	85 c0                	test   %eax,%eax
  104602:	89 c6                	mov    %eax,%esi
  104604:	74 56                	je     10465c <sys_link+0xec>
  ilock(dp);
  104606:	83 ec 0c             	sub    $0xc,%esp
  104609:	50                   	push   %eax
  10460a:	e8 11 d0 ff ff       	call   101620 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  10460f:	83 c4 10             	add    $0x10,%esp
  104612:	8b 03                	mov    (%ebx),%eax
  104614:	39 06                	cmp    %eax,(%esi)
  104616:	75 38                	jne    104650 <sys_link+0xe0>
  104618:	83 ec 04             	sub    $0x4,%esp
  10461b:	ff 73 04             	pushl  0x4(%ebx)
  10461e:	57                   	push   %edi
  10461f:	56                   	push   %esi
  104620:	e8 0b d8 ff ff       	call   101e30 <dirlink>
  104625:	83 c4 10             	add    $0x10,%esp
  104628:	85 c0                	test   %eax,%eax
  10462a:	78 24                	js     104650 <sys_link+0xe0>
  iunlockput(dp);
  10462c:	83 ec 0c             	sub    $0xc,%esp
  10462f:	56                   	push   %esi
  104630:	e8 ab d2 ff ff       	call   1018e0 <iunlockput>
  iput(ip);
  104635:	89 1c 24             	mov    %ebx,(%esp)
  104638:	e8 43 d1 ff ff       	call   101780 <iput>
  return 0;
  10463d:	83 c4 10             	add    $0x10,%esp
  104640:	31 c0                	xor    %eax,%eax
}
  104642:	83 c4 20             	add    $0x20,%esp
  104645:	5b                   	pop    %ebx
  104646:	5e                   	pop    %esi
  104647:	5f                   	pop    %edi
  104648:	c3                   	ret    
  104649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
  104650:	83 ec 0c             	sub    $0xc,%esp
  104653:	56                   	push   %esi
  104654:	e8 87 d2 ff ff       	call   1018e0 <iunlockput>
    goto bad;
  104659:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
  10465c:	83 ec 0c             	sub    $0xc,%esp
  10465f:	53                   	push   %ebx
  104660:	e8 bb cf ff ff       	call   101620 <ilock>
  ip->nlink--;
  104665:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  10466a:	89 1c 24             	mov    %ebx,(%esp)
  10466d:	e8 fe ce ff ff       	call   101570 <iupdate>
  iunlockput(ip);
  104672:	89 1c 24             	mov    %ebx,(%esp)
  104675:	e8 66 d2 ff ff       	call   1018e0 <iunlockput>
  return -1;
  10467a:	83 c4 10             	add    $0x10,%esp
}
  10467d:	83 c4 20             	add    $0x20,%esp
  return -1;
  104680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104685:	5b                   	pop    %ebx
  104686:	5e                   	pop    %esi
  104687:	5f                   	pop    %edi
  104688:	c3                   	ret    
  104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
  104690:	83 ec 0c             	sub    $0xc,%esp
  104693:	53                   	push   %ebx
  104694:	e8 47 d2 ff ff       	call   1018e0 <iunlockput>
    return -1;
  104699:	83 c4 10             	add    $0x10,%esp
  10469c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1046a1:	eb 9f                	jmp    104642 <sys_link+0xd2>
  1046a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001046b0 <sys_unlink>:
{
  1046b0:	55                   	push   %ebp
  1046b1:	57                   	push   %edi
  1046b2:	56                   	push   %esi
  1046b3:	53                   	push   %ebx
  1046b4:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
  1046b7:	8d 44 24 10          	lea    0x10(%esp),%eax
  1046bb:	50                   	push   %eax
  1046bc:	6a 00                	push   $0x0
  1046be:	e8 fd f9 ff ff       	call   1040c0 <argstr>
  1046c3:	83 c4 10             	add    $0x10,%esp
  1046c6:	85 c0                	test   %eax,%eax
  1046c8:	0f 88 38 01 00 00    	js     104806 <sys_unlink+0x156>
  if((dp = nameiparent(path, name)) == 0)
  1046ce:	83 ec 08             	sub    $0x8,%esp
  1046d1:	8d 5c 24 1a          	lea    0x1a(%esp),%ebx
  1046d5:	53                   	push   %ebx
  1046d6:	ff 74 24 14          	pushl  0x14(%esp)
  1046da:	e8 31 d8 ff ff       	call   101f10 <nameiparent>
  1046df:	83 c4 10             	add    $0x10,%esp
  1046e2:	85 c0                	test   %eax,%eax
  1046e4:	89 c5                	mov    %eax,%ebp
  1046e6:	0f 84 1a 01 00 00    	je     104806 <sys_unlink+0x156>
  ilock(dp);
  1046ec:	83 ec 0c             	sub    $0xc,%esp
  1046ef:	50                   	push   %eax
  1046f0:	e8 2b cf ff ff       	call   101620 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  1046f5:	58                   	pop    %eax
  1046f6:	5a                   	pop    %edx
  1046f7:	68 30 64 10 00       	push   $0x106430
  1046fc:	53                   	push   %ebx
  1046fd:	e8 6e d4 ff ff       	call   101b70 <namecmp>
  104702:	83 c4 10             	add    $0x10,%esp
  104705:	85 c0                	test   %eax,%eax
  104707:	0f 84 0b 01 00 00    	je     104818 <sys_unlink+0x168>
  10470d:	83 ec 08             	sub    $0x8,%esp
  104710:	68 2f 64 10 00       	push   $0x10642f
  104715:	53                   	push   %ebx
  104716:	e8 55 d4 ff ff       	call   101b70 <namecmp>
  10471b:	83 c4 10             	add    $0x10,%esp
  10471e:	85 c0                	test   %eax,%eax
  104720:	0f 84 f2 00 00 00    	je     104818 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0){
  104726:	83 ec 04             	sub    $0x4,%esp
  104729:	8d 44 24 10          	lea    0x10(%esp),%eax
  10472d:	50                   	push   %eax
  10472e:	53                   	push   %ebx
  10472f:	55                   	push   %ebp
  104730:	e8 5b d4 ff ff       	call   101b90 <dirlookup>
  104735:	83 c4 10             	add    $0x10,%esp
  104738:	85 c0                	test   %eax,%eax
  10473a:	89 c3                	mov    %eax,%ebx
  10473c:	0f 84 d6 00 00 00    	je     104818 <sys_unlink+0x168>
  ilock(ip);
  104742:	83 ec 0c             	sub    $0xc,%esp
  104745:	50                   	push   %eax
  104746:	e8 d5 ce ff ff       	call   101620 <ilock>
  if(ip->nlink < 1)
  10474b:	83 c4 10             	add    $0x10,%esp
  10474e:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
  104753:	0f 8e 0f 01 00 00    	jle    104868 <sys_unlink+0x1b8>
  if(ip->type == T_DIR && !isdirempty(ip)){
  104759:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10475e:	8d 7c 24 20          	lea    0x20(%esp),%edi
  104762:	74 5c                	je     1047c0 <sys_unlink+0x110>
  memset(&de, 0, sizeof(de));
  104764:	83 ec 04             	sub    $0x4,%esp
  104767:	6a 10                	push   $0x10
  104769:	6a 00                	push   $0x0
  10476b:	57                   	push   %edi
  10476c:	e8 0f f6 ff ff       	call   103d80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104771:	6a 10                	push   $0x10
  104773:	ff 74 24 20          	pushl  0x20(%esp)
  104777:	57                   	push   %edi
  104778:	55                   	push   %ebp
  104779:	e8 b2 d2 ff ff       	call   101a30 <writei>
  10477e:	83 c4 20             	add    $0x20,%esp
  104781:	83 f8 10             	cmp    $0x10,%eax
  104784:	0f 85 d1 00 00 00    	jne    10485b <sys_unlink+0x1ab>
  if(ip->type == T_DIR){
  10478a:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10478f:	0f 84 a3 00 00 00    	je     104838 <sys_unlink+0x188>
  iunlockput(dp);
  104795:	83 ec 0c             	sub    $0xc,%esp
  104798:	55                   	push   %ebp
  104799:	e8 42 d1 ff ff       	call   1018e0 <iunlockput>
  ip->nlink--;
  10479e:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  1047a3:	89 1c 24             	mov    %ebx,(%esp)
  1047a6:	e8 c5 cd ff ff       	call   101570 <iupdate>
  iunlockput(ip);
  1047ab:	89 1c 24             	mov    %ebx,(%esp)
  1047ae:	e8 2d d1 ff ff       	call   1018e0 <iunlockput>
  return 0;
  1047b3:	83 c4 10             	add    $0x10,%esp
  1047b6:	31 c0                	xor    %eax,%eax
}
  1047b8:	83 c4 3c             	add    $0x3c,%esp
  1047bb:	5b                   	pop    %ebx
  1047bc:	5e                   	pop    %esi
  1047bd:	5f                   	pop    %edi
  1047be:	5d                   	pop    %ebp
  1047bf:	c3                   	ret    
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  1047c0:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
  1047c4:	76 9e                	jbe    104764 <sys_unlink+0xb4>
  1047c6:	be 20 00 00 00       	mov    $0x20,%esi
  1047cb:	eb 0b                	jmp    1047d8 <sys_unlink+0x128>
  1047cd:	8d 76 00             	lea    0x0(%esi),%esi
  1047d0:	83 c6 10             	add    $0x10,%esi
  1047d3:	3b 73 18             	cmp    0x18(%ebx),%esi
  1047d6:	73 8c                	jae    104764 <sys_unlink+0xb4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1047d8:	6a 10                	push   $0x10
  1047da:	56                   	push   %esi
  1047db:	57                   	push   %edi
  1047dc:	53                   	push   %ebx
  1047dd:	e8 4e d1 ff ff       	call   101930 <readi>
  1047e2:	83 c4 10             	add    $0x10,%esp
  1047e5:	83 f8 10             	cmp    $0x10,%eax
  1047e8:	75 64                	jne    10484e <sys_unlink+0x19e>
    if(de.inum != 0)
  1047ea:	66 83 7c 24 20 00    	cmpw   $0x0,0x20(%esp)
  1047f0:	74 de                	je     1047d0 <sys_unlink+0x120>
    iunlockput(ip);
  1047f2:	83 ec 0c             	sub    $0xc,%esp
  1047f5:	53                   	push   %ebx
  1047f6:	e8 e5 d0 ff ff       	call   1018e0 <iunlockput>
    iunlockput(dp);
  1047fb:	89 2c 24             	mov    %ebp,(%esp)
  1047fe:	e8 dd d0 ff ff       	call   1018e0 <iunlockput>
    return -1;
  104803:	83 c4 10             	add    $0x10,%esp
}
  104806:	83 c4 3c             	add    $0x3c,%esp
    return -1;
  104809:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10480e:	5b                   	pop    %ebx
  10480f:	5e                   	pop    %esi
  104810:	5f                   	pop    %edi
  104811:	5d                   	pop    %ebp
  104812:	c3                   	ret    
  104813:	90                   	nop
  104814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
  104818:	83 ec 0c             	sub    $0xc,%esp
  10481b:	55                   	push   %ebp
  10481c:	e8 bf d0 ff ff       	call   1018e0 <iunlockput>
    return -1;
  104821:	83 c4 10             	add    $0x10,%esp
  104824:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104829:	83 c4 3c             	add    $0x3c,%esp
  10482c:	5b                   	pop    %ebx
  10482d:	5e                   	pop    %esi
  10482e:	5f                   	pop    %edi
  10482f:	5d                   	pop    %ebp
  104830:	c3                   	ret    
  104831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
  104838:	66 83 6d 16 01       	subw   $0x1,0x16(%ebp)
    iupdate(dp);
  10483d:	83 ec 0c             	sub    $0xc,%esp
  104840:	55                   	push   %ebp
  104841:	e8 2a cd ff ff       	call   101570 <iupdate>
  104846:	83 c4 10             	add    $0x10,%esp
  104849:	e9 47 ff ff ff       	jmp    104795 <sys_unlink+0xe5>
      panic("isdirempty: readi");
  10484e:	83 ec 0c             	sub    $0xc,%esp
  104851:	68 54 64 10 00       	push   $0x106454
  104856:	e8 b5 bf ff ff       	call   100810 <panic>
    panic("unlink: writei");
  10485b:	83 ec 0c             	sub    $0xc,%esp
  10485e:	68 66 64 10 00       	push   $0x106466
  104863:	e8 a8 bf ff ff       	call   100810 <panic>
    panic("unlink: nlink < 1");
  104868:	83 ec 0c             	sub    $0xc,%esp
  10486b:	68 42 64 10 00       	push   $0x106442
  104870:	e8 9b bf ff ff       	call   100810 <panic>
  104875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104880 <sys_open>:

int
sys_open(void)
{
  104880:	57                   	push   %edi
  104881:	56                   	push   %esi
  104882:	53                   	push   %ebx
  104883:	83 ec 18             	sub    $0x18,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104886:	8d 44 24 10          	lea    0x10(%esp),%eax
  10488a:	50                   	push   %eax
  10488b:	6a 00                	push   $0x0
  10488d:	e8 2e f8 ff ff       	call   1040c0 <argstr>
  104892:	83 c4 10             	add    $0x10,%esp
  104895:	85 c0                	test   %eax,%eax
  104897:	0f 88 8b 00 00 00    	js     104928 <sys_open+0xa8>
  10489d:	83 ec 08             	sub    $0x8,%esp
  1048a0:	8d 44 24 14          	lea    0x14(%esp),%eax
  1048a4:	50                   	push   %eax
  1048a5:	6a 01                	push   $0x1
  1048a7:	e8 84 f7 ff ff       	call   104030 <argint>
  1048ac:	83 c4 10             	add    $0x10,%esp
  1048af:	85 c0                	test   %eax,%eax
  1048b1:	78 75                	js     104928 <sys_open+0xa8>
    return -1;

  if(omode & O_CREATE){
  1048b3:	f6 44 24 0d 02       	testb  $0x2,0xd(%esp)
  1048b8:	0f 85 82 00 00 00    	jne    104940 <sys_open+0xc0>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  1048be:	83 ec 0c             	sub    $0xc,%esp
  1048c1:	ff 74 24 14          	pushl  0x14(%esp)
  1048c5:	e8 26 d6 ff ff       	call   101ef0 <namei>
  1048ca:	83 c4 10             	add    $0x10,%esp
  1048cd:	85 c0                	test   %eax,%eax
  1048cf:	89 c7                	mov    %eax,%edi
  1048d1:	74 55                	je     104928 <sys_open+0xa8>
      return -1;
    ilock(ip);
  1048d3:	83 ec 0c             	sub    $0xc,%esp
  1048d6:	50                   	push   %eax
  1048d7:	e8 44 cd ff ff       	call   101620 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  1048dc:	83 c4 10             	add    $0x10,%esp
  1048df:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  1048e4:	0f 84 b6 00 00 00    	je     1049a0 <sys_open+0x120>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  1048ea:	e8 71 c5 ff ff       	call   100e60 <filealloc>
  1048ef:	85 c0                	test   %eax,%eax
  1048f1:	89 c6                	mov    %eax,%esi
  1048f3:	74 27                	je     10491c <sys_open+0x9c>
  1048f5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  1048fc:	31 db                	xor    %ebx,%ebx
  1048fe:	66 90                	xchg   %ax,%ax
    if(proc->ofile[fd] == 0){
  104900:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
  104904:	85 c0                	test   %eax,%eax
  104906:	74 58                	je     104960 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
  104908:	83 c3 01             	add    $0x1,%ebx
  10490b:	83 fb 10             	cmp    $0x10,%ebx
  10490e:	75 f0                	jne    104900 <sys_open+0x80>
    if(f)
      fileclose(f);
  104910:	83 ec 0c             	sub    $0xc,%esp
  104913:	56                   	push   %esi
  104914:	e8 07 c6 ff ff       	call   100f20 <fileclose>
  104919:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
  10491c:	83 ec 0c             	sub    $0xc,%esp
  10491f:	57                   	push   %edi
  104920:	e8 bb cf ff ff       	call   1018e0 <iunlockput>
    return -1;
  104925:	83 c4 10             	add    $0x10,%esp
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
}
  104928:	83 c4 10             	add    $0x10,%esp
    return -1;
  10492b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  104930:	89 d8                	mov    %ebx,%eax
  104932:	5b                   	pop    %ebx
  104933:	5e                   	pop    %esi
  104934:	5f                   	pop    %edi
  104935:	c3                   	ret    
  104936:	8d 76 00             	lea    0x0(%esi),%esi
  104939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104940:	83 ec 0c             	sub    $0xc,%esp
  104943:	31 c9                	xor    %ecx,%ecx
  104945:	ba 02 00 00 00       	mov    $0x2,%edx
  10494a:	6a 00                	push   $0x0
  10494c:	8b 44 24 18          	mov    0x18(%esp),%eax
  104950:	e8 3b f8 ff ff       	call   104190 <create>
  104955:	83 c4 10             	add    $0x10,%esp
  104958:	85 c0                	test   %eax,%eax
  10495a:	89 c7                	mov    %eax,%edi
  10495c:	75 8c                	jne    1048ea <sys_open+0x6a>
  10495e:	eb c8                	jmp    104928 <sys_open+0xa8>
  iunlock(ip);
  104960:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
  104963:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
  iunlock(ip);
  104967:	57                   	push   %edi
  104968:	e8 c3 cd ff ff       	call   101730 <iunlock>
  f->type = FD_INODE;
  10496d:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->readable = !(omode & O_WRONLY);
  104973:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104977:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  10497a:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  10497d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104984:	89 c2                	mov    %eax,%edx
  104986:	f7 d2                	not    %edx
  104988:	88 56 08             	mov    %dl,0x8(%esi)
  10498b:	80 66 08 01          	andb   $0x1,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  10498f:	a8 03                	test   $0x3,%al
  104991:	0f 95 46 09          	setne  0x9(%esi)
}
  104995:	83 c4 10             	add    $0x10,%esp
  104998:	89 d8                	mov    %ebx,%eax
  10499a:	5b                   	pop    %ebx
  10499b:	5e                   	pop    %esi
  10499c:	5f                   	pop    %edi
  10499d:	c3                   	ret    
  10499e:	66 90                	xchg   %ax,%ax
    if(ip->type == T_DIR && omode != O_RDONLY){
  1049a0:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1049a4:	85 d2                	test   %edx,%edx
  1049a6:	0f 84 3e ff ff ff    	je     1048ea <sys_open+0x6a>
  1049ac:	e9 6b ff ff ff       	jmp    10491c <sys_open+0x9c>
  1049b1:	eb 0d                	jmp    1049c0 <sys_mkdir>
  1049b3:	90                   	nop
  1049b4:	90                   	nop
  1049b5:	90                   	nop
  1049b6:	90                   	nop
  1049b7:	90                   	nop
  1049b8:	90                   	nop
  1049b9:	90                   	nop
  1049ba:	90                   	nop
  1049bb:	90                   	nop
  1049bc:	90                   	nop
  1049bd:	90                   	nop
  1049be:	90                   	nop
  1049bf:	90                   	nop

001049c0 <sys_mkdir>:

int
sys_mkdir(void)
{
  1049c0:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  1049c3:	8d 44 24 14          	lea    0x14(%esp),%eax
  1049c7:	50                   	push   %eax
  1049c8:	6a 00                	push   $0x0
  1049ca:	e8 f1 f6 ff ff       	call   1040c0 <argstr>
  1049cf:	83 c4 10             	add    $0x10,%esp
  1049d2:	85 c0                	test   %eax,%eax
  1049d4:	78 32                	js     104a08 <sys_mkdir+0x48>
  1049d6:	83 ec 0c             	sub    $0xc,%esp
  1049d9:	31 c9                	xor    %ecx,%ecx
  1049db:	ba 01 00 00 00       	mov    $0x1,%edx
  1049e0:	6a 00                	push   $0x0
  1049e2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1049e6:	e8 a5 f7 ff ff       	call   104190 <create>
  1049eb:	83 c4 10             	add    $0x10,%esp
  1049ee:	85 c0                	test   %eax,%eax
  1049f0:	74 16                	je     104a08 <sys_mkdir+0x48>
    return -1;
  iunlockput(ip);
  1049f2:	83 ec 0c             	sub    $0xc,%esp
  1049f5:	50                   	push   %eax
  1049f6:	e8 e5 ce ff ff       	call   1018e0 <iunlockput>
  return 0;
  1049fb:	83 c4 10             	add    $0x10,%esp
  1049fe:	31 c0                	xor    %eax,%eax
}
  104a00:	83 c4 1c             	add    $0x1c,%esp
  104a03:	c3                   	ret    
  104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104a0d:	eb f1                	jmp    104a00 <sys_mkdir+0x40>
  104a0f:	90                   	nop

00104a10 <sys_mknod>:

int
sys_mknod(void)
{
  104a10:	83 ec 24             	sub    $0x24,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104a13:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104a17:	50                   	push   %eax
  104a18:	6a 00                	push   $0x0
  104a1a:	e8 a1 f6 ff ff       	call   1040c0 <argstr>
  104a1f:	83 c4 10             	add    $0x10,%esp
  104a22:	85 c0                	test   %eax,%eax
  104a24:	78 6a                	js     104a90 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
  104a26:	83 ec 08             	sub    $0x8,%esp
  104a29:	8d 44 24 10          	lea    0x10(%esp),%eax
  104a2d:	50                   	push   %eax
  104a2e:	6a 01                	push   $0x1
  104a30:	e8 fb f5 ff ff       	call   104030 <argint>
  if((len=argstr(0, &path)) < 0 ||
  104a35:	83 c4 10             	add    $0x10,%esp
  104a38:	85 c0                	test   %eax,%eax
  104a3a:	78 54                	js     104a90 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
  104a3c:	83 ec 08             	sub    $0x8,%esp
  104a3f:	8d 44 24 14          	lea    0x14(%esp),%eax
  104a43:	50                   	push   %eax
  104a44:	6a 02                	push   $0x2
  104a46:	e8 e5 f5 ff ff       	call   104030 <argint>
     argint(1, &major) < 0 ||
  104a4b:	83 c4 10             	add    $0x10,%esp
  104a4e:	85 c0                	test   %eax,%eax
  104a50:	78 3e                	js     104a90 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0)
  104a52:	0f bf 4c 24 08       	movswl 0x8(%esp),%ecx
     argint(2, &minor) < 0 ||
  104a57:	83 ec 0c             	sub    $0xc,%esp
  104a5a:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0)
  104a5f:	0f bf 44 24 18       	movswl 0x18(%esp),%eax
     argint(2, &minor) < 0 ||
  104a64:	50                   	push   %eax
  104a65:	8b 44 24 14          	mov    0x14(%esp),%eax
  104a69:	e8 22 f7 ff ff       	call   104190 <create>
  104a6e:	83 c4 10             	add    $0x10,%esp
  104a71:	85 c0                	test   %eax,%eax
  104a73:	74 1b                	je     104a90 <sys_mknod+0x80>
    return -1;
  iunlockput(ip);
  104a75:	83 ec 0c             	sub    $0xc,%esp
  104a78:	50                   	push   %eax
  104a79:	e8 62 ce ff ff       	call   1018e0 <iunlockput>
  return 0;
  104a7e:	83 c4 10             	add    $0x10,%esp
  104a81:	31 c0                	xor    %eax,%eax
}
  104a83:	83 c4 1c             	add    $0x1c,%esp
  104a86:	c3                   	ret    
  104a87:	89 f6                	mov    %esi,%esi
  104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  104a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a95:	83 c4 1c             	add    $0x1c,%esp
  104a98:	c3                   	ret    
  104a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104aa0 <sys_chdir>:

int
sys_chdir(void)
{
  104aa0:	53                   	push   %ebx
  104aa1:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104aa4:	8d 44 24 14          	lea    0x14(%esp),%eax
  104aa8:	50                   	push   %eax
  104aa9:	6a 00                	push   $0x0
  104aab:	e8 10 f6 ff ff       	call   1040c0 <argstr>
  104ab0:	83 c4 10             	add    $0x10,%esp
  104ab3:	85 c0                	test   %eax,%eax
  104ab5:	78 65                	js     104b1c <sys_chdir+0x7c>
  104ab7:	83 ec 0c             	sub    $0xc,%esp
  104aba:	ff 74 24 18          	pushl  0x18(%esp)
  104abe:	e8 2d d4 ff ff       	call   101ef0 <namei>
  104ac3:	83 c4 10             	add    $0x10,%esp
  104ac6:	85 c0                	test   %eax,%eax
  104ac8:	89 c3                	mov    %eax,%ebx
  104aca:	74 50                	je     104b1c <sys_chdir+0x7c>
    return -1;
  ilock(ip);
  104acc:	83 ec 0c             	sub    $0xc,%esp
  104acf:	50                   	push   %eax
  104ad0:	e8 4b cb ff ff       	call   101620 <ilock>
  if(ip->type != T_DIR){
  104ad5:	83 c4 10             	add    $0x10,%esp
  104ad8:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  104add:	75 31                	jne    104b10 <sys_chdir+0x70>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104adf:	83 ec 0c             	sub    $0xc,%esp
  104ae2:	53                   	push   %ebx
  104ae3:	e8 48 cc ff ff       	call   101730 <iunlock>
  iput(proc->cwd);
  104ae8:	58                   	pop    %eax
  104ae9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104aef:	ff 70 68             	pushl  0x68(%eax)
  104af2:	e8 89 cc ff ff       	call   101780 <iput>
  proc->cwd = ip;
  104af7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
  104afd:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
  104b00:	89 58 68             	mov    %ebx,0x68(%eax)
}
  104b03:	83 c4 18             	add    $0x18,%esp
  return 0;
  104b06:	31 c0                	xor    %eax,%eax
}
  104b08:	5b                   	pop    %ebx
  104b09:	c3                   	ret    
  104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
  104b10:	83 ec 0c             	sub    $0xc,%esp
  104b13:	53                   	push   %ebx
  104b14:	e8 c7 cd ff ff       	call   1018e0 <iunlockput>
    return -1;
  104b19:	83 c4 10             	add    $0x10,%esp
}
  104b1c:	83 c4 18             	add    $0x18,%esp
    return -1;
  104b1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104b24:	5b                   	pop    %ebx
  104b25:	c3                   	ret    
  104b26:	8d 76 00             	lea    0x0(%esi),%esi
  104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104b30 <sys_exec>:

int
sys_exec(void)
{
  104b30:	55                   	push   %ebp
  104b31:	57                   	push   %edi
  104b32:	56                   	push   %esi
  104b33:	53                   	push   %ebx
  104b34:	83 ec 74             	sub    $0x74,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104b37:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104b3b:	50                   	push   %eax
  104b3c:	6a 00                	push   $0x0
  104b3e:	e8 7d f5 ff ff       	call   1040c0 <argstr>
  104b43:	83 c4 10             	add    $0x10,%esp
  104b46:	85 c0                	test   %eax,%eax
  104b48:	0f 88 7c 00 00 00    	js     104bca <sys_exec+0x9a>
  104b4e:	83 ec 08             	sub    $0x8,%esp
  104b51:	8d 44 24 10          	lea    0x10(%esp),%eax
  104b55:	50                   	push   %eax
  104b56:	6a 01                	push   $0x1
  104b58:	e8 d3 f4 ff ff       	call   104030 <argint>
  104b5d:	83 c4 10             	add    $0x10,%esp
  104b60:	85 c0                	test   %eax,%eax
  104b62:	78 66                	js     104bca <sys_exec+0x9a>
    return -1;
  memset(argv, 0, sizeof(argv));
  104b64:	83 ec 04             	sub    $0x4,%esp
  104b67:	31 db                	xor    %ebx,%ebx
  104b69:	6a 50                	push   $0x50
  104b6b:	6a 00                	push   $0x0
  104b6d:	8d 6c 24 1c          	lea    0x1c(%esp),%ebp
  104b71:	55                   	push   %ebp
  104b72:	89 ee                	mov    %ebp,%esi
  104b74:	e8 07 f2 ff ff       	call   103d80 <memset>
  104b79:	83 c4 10             	add    $0x10,%esp
  104b7c:	8d 7c 24 0c          	lea    0xc(%esp),%edi
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
  104b80:	83 ec 04             	sub    $0x4,%esp
  104b83:	57                   	push   %edi
  104b84:	8b 44 24 10          	mov    0x10(%esp),%eax
  104b88:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  104b8b:	50                   	push   %eax
  104b8c:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
  104b93:	e8 08 f4 ff ff       	call   103fa0 <fetchint>
  104b98:	83 c4 10             	add    $0x10,%esp
  104b9b:	85 c0                	test   %eax,%eax
  104b9d:	78 2b                	js     104bca <sys_exec+0x9a>
      return -1;
    if(uarg == 0){
  104b9f:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104ba3:	85 c0                	test   %eax,%eax
  104ba5:	74 39                	je     104be0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
  104ba7:	83 ec 04             	sub    $0x4,%esp
  104baa:	56                   	push   %esi
  104bab:	50                   	push   %eax
  104bac:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
  104bb3:	e8 28 f4 ff ff       	call   103fe0 <fetchstr>
  104bb8:	83 c4 10             	add    $0x10,%esp
  104bbb:	85 c0                	test   %eax,%eax
  104bbd:	78 0b                	js     104bca <sys_exec+0x9a>
  for(i=0;; i++){
  104bbf:	83 c3 01             	add    $0x1,%ebx
  104bc2:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
  104bc5:	83 fb 14             	cmp    $0x14,%ebx
  104bc8:	75 b6                	jne    104b80 <sys_exec+0x50>
      return -1;
  }
  return exec(path, argv);
}
  104bca:	83 c4 6c             	add    $0x6c,%esp
    return -1;
  104bcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104bd2:	5b                   	pop    %ebx
  104bd3:	5e                   	pop    %esi
  104bd4:	5f                   	pop    %edi
  104bd5:	5d                   	pop    %ebp
  104bd6:	c3                   	ret    
  104bd7:	89 f6                	mov    %esi,%esi
  104bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      argv[i] = 0;
  104be0:	c7 44 9c 10 00 00 00 	movl   $0x0,0x10(%esp,%ebx,4)
  104be7:	00 
  return exec(path, argv);
  104be8:	83 ec 08             	sub    $0x8,%esp
  104beb:	55                   	push   %ebp
  104bec:	ff 74 24 10          	pushl  0x10(%esp)
  104bf0:	e8 6b be ff ff       	call   100a60 <exec>
  104bf5:	83 c4 10             	add    $0x10,%esp
}
  104bf8:	83 c4 6c             	add    $0x6c,%esp
  104bfb:	5b                   	pop    %ebx
  104bfc:	5e                   	pop    %esi
  104bfd:	5f                   	pop    %edi
  104bfe:	5d                   	pop    %ebp
  104bff:	c3                   	ret    

00104c00 <sys_pipe>:

int
sys_pipe(void)
{
  104c00:	57                   	push   %edi
  104c01:	56                   	push   %esi
  104c02:	53                   	push   %ebx
  104c03:	83 ec 14             	sub    $0x14,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  104c06:	6a 08                	push   $0x8
  104c08:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104c0c:	50                   	push   %eax
  104c0d:	6a 00                	push   $0x0
  104c0f:	e8 5c f4 ff ff       	call   104070 <argptr>
  104c14:	83 c4 10             	add    $0x10,%esp
  104c17:	85 c0                	test   %eax,%eax
  104c19:	78 53                	js     104c6e <sys_pipe+0x6e>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  104c1b:	83 ec 08             	sub    $0x8,%esp
  104c1e:	8d 44 24 14          	lea    0x14(%esp),%eax
  104c22:	50                   	push   %eax
  104c23:	8d 44 24 14          	lea    0x14(%esp),%eax
  104c27:	50                   	push   %eax
  104c28:	e8 13 e0 ff ff       	call   102c40 <pipealloc>
  104c2d:	83 c4 10             	add    $0x10,%esp
  104c30:	85 c0                	test   %eax,%eax
  104c32:	78 3a                	js     104c6e <sys_pipe+0x6e>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  104c34:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  104c38:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
  104c3f:	31 c0                	xor    %eax,%eax
  104c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
  104c48:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
  104c4c:	85 d2                	test   %edx,%edx
  104c4e:	74 28                	je     104c78 <sys_pipe+0x78>
  for(fd = 0; fd < NOFILE; fd++){
  104c50:	83 c0 01             	add    $0x1,%eax
  104c53:	83 f8 10             	cmp    $0x10,%eax
  104c56:	75 f0                	jne    104c48 <sys_pipe+0x48>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
  104c58:	83 ec 0c             	sub    $0xc,%esp
  104c5b:	53                   	push   %ebx
  104c5c:	e8 bf c2 ff ff       	call   100f20 <fileclose>
    fileclose(wf);
  104c61:	58                   	pop    %eax
  104c62:	ff 74 24 18          	pushl  0x18(%esp)
  104c66:	e8 b5 c2 ff ff       	call   100f20 <fileclose>
    return -1;
  104c6b:	83 c4 10             	add    $0x10,%esp
  104c6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104c73:	eb 3e                	jmp    104cb3 <sys_pipe+0xb3>
  104c75:	8d 76 00             	lea    0x0(%esi),%esi
  104c78:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  104c7b:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  for(fd = 0; fd < NOFILE; fd++){
  104c7f:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
  104c81:	89 5e 28             	mov    %ebx,0x28(%esi)
  104c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
  104c88:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
  104c8d:	74 11                	je     104ca0 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
  104c8f:	83 c2 01             	add    $0x1,%edx
  104c92:	83 fa 10             	cmp    $0x10,%edx
  104c95:	75 f1                	jne    104c88 <sys_pipe+0x88>
      proc->ofile[fd0] = 0;
  104c97:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
  104c9e:	eb b8                	jmp    104c58 <sys_pipe+0x58>
      proc->ofile[fd] = f;
  104ca0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
  104ca4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104ca8:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
  104caa:	8b 44 24 04          	mov    0x4(%esp),%eax
  104cae:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
  104cb1:	31 c0                	xor    %eax,%eax
}
  104cb3:	83 c4 10             	add    $0x10,%esp
  104cb6:	5b                   	pop    %ebx
  104cb7:	5e                   	pop    %esi
  104cb8:	5f                   	pop    %edi
  104cb9:	c3                   	ret    
  104cba:	66 90                	xchg   %ax,%ax
  104cbc:	66 90                	xchg   %ax,%ax
  104cbe:	66 90                	xchg   %ax,%ax

00104cc0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
  104cc0:	e9 5b e8 ff ff       	jmp    103520 <fork>
  104cc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104cd0 <sys_exit>:
}

int
sys_exit(void)
{
  104cd0:	83 ec 0c             	sub    $0xc,%esp
  exit();
  104cd3:	e8 68 ec ff ff       	call   103940 <exit>
  return 0;  // not reached
}
  104cd8:	31 c0                	xor    %eax,%eax
  104cda:	83 c4 0c             	add    $0xc,%esp
  104cdd:	c3                   	ret    
  104cde:	66 90                	xchg   %ax,%ax

00104ce0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
  104ce0:	e9 9b ed ff ff       	jmp    103a80 <wait>
  104ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104cf0 <sys_kill>:
}

int
sys_kill(void)
{
  104cf0:	83 ec 24             	sub    $0x24,%esp
  int pid;

  if(argint(0, &pid) < 0)
  104cf3:	8d 44 24 14          	lea    0x14(%esp),%eax
  104cf7:	50                   	push   %eax
  104cf8:	6a 00                	push   $0x0
  104cfa:	e8 31 f3 ff ff       	call   104030 <argint>
  104cff:	83 c4 10             	add    $0x10,%esp
  104d02:	85 c0                	test   %eax,%eax
  104d04:	78 1a                	js     104d20 <sys_kill+0x30>
    return -1;
  return kill(pid);
  104d06:	83 ec 0c             	sub    $0xc,%esp
  104d09:	ff 74 24 18          	pushl  0x18(%esp)
  104d0d:	e8 9e eb ff ff       	call   1038b0 <kill>
  104d12:	83 c4 10             	add    $0x10,%esp
}
  104d15:	83 c4 1c             	add    $0x1c,%esp
  104d18:	c3                   	ret    
  104d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  104d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104d25:	eb ee                	jmp    104d15 <sys_kill+0x25>
  104d27:	89 f6                	mov    %esi,%esi
  104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104d30 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
  104d30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104d36:	8b 40 10             	mov    0x10(%eax),%eax
}
  104d39:	c3                   	ret    
  104d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104d40 <sys_sbrk>:

int
sys_sbrk(void)
{
  104d40:	53                   	push   %ebx
  104d41:	83 ec 20             	sub    $0x20,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104d44:	8d 44 24 14          	lea    0x14(%esp),%eax
  104d48:	50                   	push   %eax
  104d49:	6a 00                	push   $0x0
  104d4b:	e8 e0 f2 ff ff       	call   104030 <argint>
  104d50:	83 c4 10             	add    $0x10,%esp
  104d53:	85 c0                	test   %eax,%eax
  104d55:	78 29                	js     104d80 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
  104d57:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
  104d5d:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
  104d60:	8b 58 04             	mov    0x4(%eax),%ebx
  if(growproc(n) < 0)
  104d63:	ff 74 24 18          	pushl  0x18(%esp)
  104d67:	e8 24 e7 ff ff       	call   103490 <growproc>
  104d6c:	83 c4 10             	add    $0x10,%esp
  104d6f:	85 c0                	test   %eax,%eax
  104d71:	78 0d                	js     104d80 <sys_sbrk+0x40>
    return -1;
  return addr;
}
  104d73:	83 c4 18             	add    $0x18,%esp
  104d76:	89 d8                	mov    %ebx,%eax
  104d78:	5b                   	pop    %ebx
  104d79:	c3                   	ret    
  104d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  104d80:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  104d85:	eb ec                	jmp    104d73 <sys_sbrk+0x33>
  104d87:	89 f6                	mov    %esi,%esi
  104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104d90 <sys_sleep>:

int
sys_sleep(void)
{
  104d90:	53                   	push   %ebx
  104d91:	83 ec 20             	sub    $0x20,%esp
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  104d94:	8d 44 24 14          	lea    0x14(%esp),%eax
  104d98:	50                   	push   %eax
  104d99:	6a 00                	push   $0x0
  104d9b:	e8 90 f2 ff ff       	call   104030 <argint>
  104da0:	83 c4 10             	add    $0x10,%esp
  104da3:	85 c0                	test   %eax,%eax
  104da5:	0f 88 8c 00 00 00    	js     104e37 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
  104dab:	83 ec 0c             	sub    $0xc,%esp
  104dae:	68 e0 ff 10 00       	push   $0x10ffe0
  104db3:	e8 d8 ed ff ff       	call   103b90 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104db8:	83 c4 10             	add    $0x10,%esp
  104dbb:	8b 54 24 0c          	mov    0xc(%esp),%edx
  ticks0 = ticks;
  104dbf:	8b 1d 20 08 11 00    	mov    0x110820,%ebx
  while(ticks - ticks0 < n){
  104dc5:	85 d2                	test   %edx,%edx
  104dc7:	7f 29                	jg     104df2 <sys_sleep+0x62>
  104dc9:	eb 55                	jmp    104e20 <sys_sleep+0x90>
  104dcb:	90                   	nop
  104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  104dd0:	83 ec 08             	sub    $0x8,%esp
  104dd3:	68 e0 ff 10 00       	push   $0x10ffe0
  104dd8:	68 20 08 11 00       	push   $0x110820
  104ddd:	e8 ae e9 ff ff       	call   103790 <sleep>
  while(ticks - ticks0 < n){
  104de2:	a1 20 08 11 00       	mov    0x110820,%eax
  104de7:	83 c4 10             	add    $0x10,%esp
  104dea:	29 d8                	sub    %ebx,%eax
  104dec:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  104df0:	7d 2e                	jge    104e20 <sys_sleep+0x90>
    if(proc->killed){
  104df2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104df8:	8b 40 24             	mov    0x24(%eax),%eax
  104dfb:	85 c0                	test   %eax,%eax
  104dfd:	74 d1                	je     104dd0 <sys_sleep+0x40>
      release(&tickslock);
  104dff:	83 ec 0c             	sub    $0xc,%esp
  104e02:	68 e0 ff 10 00       	push   $0x10ffe0
  104e07:	e8 24 ef ff ff       	call   103d30 <release>
      return -1;
  104e0c:	83 c4 10             	add    $0x10,%esp
  104e0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
  104e14:	83 c4 18             	add    $0x18,%esp
  104e17:	5b                   	pop    %ebx
  104e18:	c3                   	ret    
  104e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
  104e20:	83 ec 0c             	sub    $0xc,%esp
  104e23:	68 e0 ff 10 00       	push   $0x10ffe0
  104e28:	e8 03 ef ff ff       	call   103d30 <release>
  return 0;
  104e2d:	83 c4 10             	add    $0x10,%esp
  104e30:	31 c0                	xor    %eax,%eax
}
  104e32:	83 c4 18             	add    $0x18,%esp
  104e35:	5b                   	pop    %ebx
  104e36:	c3                   	ret    
    return -1;
  104e37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104e3c:	eb d6                	jmp    104e14 <sys_sleep+0x84>
  104e3e:	66 90                	xchg   %ax,%ax

00104e40 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  104e40:	83 ec 18             	sub    $0x18,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  104e43:	ba 43 00 00 00       	mov    $0x43,%edx
  104e48:	b8 34 00 00 00       	mov    $0x34,%eax
  104e4d:	ee                   	out    %al,(%dx)
  104e4e:	ba 40 00 00 00       	mov    $0x40,%edx
  104e53:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  104e58:	ee                   	out    %al,(%dx)
  104e59:	b8 2e 00 00 00       	mov    $0x2e,%eax
  104e5e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  104e5f:	6a 00                	push   $0x0
  104e61:	e8 0a dd ff ff       	call   102b70 <picenable>
}
  104e66:	83 c4 1c             	add    $0x1c,%esp
  104e69:	c3                   	ret    

00104e6a <alltraps>:
  104e6a:	1e                   	push   %ds
  104e6b:	06                   	push   %es
  104e6c:	0f a0                	push   %fs
  104e6e:	0f a8                	push   %gs
  104e70:	60                   	pusha  
  104e71:	66 b8 10 00          	mov    $0x10,%ax
  104e75:	8e d8                	mov    %eax,%ds
  104e77:	8e c0                	mov    %eax,%es
  104e79:	66 b8 18 00          	mov    $0x18,%ax
  104e7d:	8e e0                	mov    %eax,%fs
  104e7f:	8e e8                	mov    %eax,%gs
  104e81:	54                   	push   %esp
  104e82:	e8 d9 00 00 00       	call   104f60 <trap>
  104e87:	83 c4 04             	add    $0x4,%esp

00104e8a <trapret>:
  104e8a:	61                   	popa   
  104e8b:	0f a9                	pop    %gs
  104e8d:	0f a1                	pop    %fs
  104e8f:	07                   	pop    %es
  104e90:	1f                   	pop    %ds
  104e91:	83 c4 08             	add    $0x8,%esp
  104e94:	cf                   	iret   
  104e95:	66 90                	xchg   %ax,%ax
  104e97:	66 90                	xchg   %ax,%ax
  104e99:	66 90                	xchg   %ax,%ax
  104e9b:	66 90                	xchg   %ax,%ax
  104e9d:	66 90                	xchg   %ax,%ax
  104e9f:	90                   	nop

00104ea0 <tvinit>:
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  104ea0:	83 ec 0c             	sub    $0xc,%esp
  int i;

  for(i = 0; i < 256; i++)
  104ea3:	31 c0                	xor    %eax,%eax
  104ea5:	8d 76 00             	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  104ea8:	8b 14 85 08 a3 10 00 	mov    0x10a308(,%eax,4),%edx
  104eaf:	b9 08 00 00 00       	mov    $0x8,%ecx
  104eb4:	c6 04 c5 24 00 11 00 	movb   $0x0,0x110024(,%eax,8)
  104ebb:	00 
  104ebc:	66 89 0c c5 22 00 11 	mov    %cx,0x110022(,%eax,8)
  104ec3:	00 
  104ec4:	c6 04 c5 25 00 11 00 	movb   $0x8e,0x110025(,%eax,8)
  104ecb:	8e 
  104ecc:	66 89 14 c5 20 00 11 	mov    %dx,0x110020(,%eax,8)
  104ed3:	00 
  104ed4:	c1 ea 10             	shr    $0x10,%edx
  104ed7:	66 89 14 c5 26 00 11 	mov    %dx,0x110026(,%eax,8)
  104ede:	00 
  for(i = 0; i < 256; i++)
  104edf:	83 c0 01             	add    $0x1,%eax
  104ee2:	3d 00 01 00 00       	cmp    $0x100,%eax
  104ee7:	75 bf                	jne    104ea8 <tvinit+0x8>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104ee9:	a1 08 a4 10 00       	mov    0x10a408,%eax
  
  initlock(&tickslock, "time");
  104eee:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104ef1:	ba 08 00 00 00       	mov    $0x8,%edx
  initlock(&tickslock, "time");
  104ef6:	68 75 64 10 00       	push   $0x106475
  104efb:	68 e0 ff 10 00       	push   $0x10ffe0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  104f00:	66 89 15 22 02 11 00 	mov    %dx,0x110222
  104f07:	c6 05 24 02 11 00 00 	movb   $0x0,0x110224
  104f0e:	66 a3 20 02 11 00    	mov    %ax,0x110220
  104f14:	c1 e8 10             	shr    $0x10,%eax
  104f17:	c6 05 25 02 11 00 ef 	movb   $0xef,0x110225
  104f1e:	66 a3 26 02 11 00    	mov    %ax,0x110226
  initlock(&tickslock, "time");
  104f24:	e8 47 ec ff ff       	call   103b70 <initlock>
}
  104f29:	83 c4 1c             	add    $0x1c,%esp
  104f2c:	c3                   	ret    
  104f2d:	8d 76 00             	lea    0x0(%esi),%esi

00104f30 <idtinit>:

void
idtinit(void)
{
  104f30:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
  104f33:	b8 ff 07 00 00       	mov    $0x7ff,%eax
  104f38:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
  pd[1] = (uint)p;
  104f3d:	b8 20 00 11 00       	mov    $0x110020,%eax
  104f42:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  pd[2] = (uint)p >> 16;
  104f47:	c1 e8 10             	shr    $0x10,%eax
  104f4a:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  asm volatile("lidt (%0)" : : "r" (pd));
  104f4f:	8d 44 24 0a          	lea    0xa(%esp),%eax
  104f53:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  104f56:	83 c4 10             	add    $0x10,%esp
  104f59:	c3                   	ret    
  104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104f60 <trap>:

void
trap(struct trapframe *tf)
{
  104f60:	56                   	push   %esi
  104f61:	53                   	push   %ebx
  104f62:	83 ec 04             	sub    $0x4,%esp
  104f65:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(tf->trapno == T_SYSCALL){
  104f69:	8b 43 30             	mov    0x30(%ebx),%eax
  104f6c:	83 f8 40             	cmp    $0x40,%eax
  104f6f:	74 17                	je     104f88 <trap+0x28>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  104f71:	8d 50 e0             	lea    -0x20(%eax),%edx
  104f74:	83 fa 1f             	cmp    $0x1f,%edx
  104f77:	0f 87 03 01 00 00    	ja     105080 <trap+0x120>
  104f7d:	ff 24 95 08 65 10 00 	jmp    *0x106508(,%edx,4)
  104f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
  104f88:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104f8e:	8b 70 24             	mov    0x24(%eax),%esi
  104f91:	85 f6                	test   %esi,%esi
  104f93:	0f 85 d7 00 00 00    	jne    105070 <trap+0x110>
    proc->tf = tf;
  104f99:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
  104f9c:	e8 8f f1 ff ff       	call   104130 <syscall>
    if(proc->killed)
  104fa1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104fa7:	8b 48 24             	mov    0x24(%eax),%ecx
  104faa:	85 c9                	test   %ecx,%ecx
  104fac:	75 47                	jne    104ff5 <trap+0x95>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  104fae:	83 c4 04             	add    $0x4,%esp
  104fb1:	5b                   	pop    %ebx
  104fb2:	5e                   	pop    %esi
  104fb3:	c3                   	ret    
  104fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
  104fb8:	e8 c3 d0 ff ff       	call   102080 <ideintr>
    lapiceoi();
  104fbd:	e8 de d7 ff ff       	call   1027a0 <lapiceoi>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104fc2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  104fc8:	85 c0                	test   %eax,%eax
  104fca:	74 e2                	je     104fae <trap+0x4e>
  104fcc:	8b 50 24             	mov    0x24(%eax),%edx
  104fcf:	85 d2                	test   %edx,%edx
  104fd1:	0f 85 f9 00 00 00    	jne    1050d0 <trap+0x170>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  104fd7:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  104fdb:	0f 84 1f 01 00 00    	je     105100 <trap+0x1a0>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  104fe1:	8b 40 24             	mov    0x24(%eax),%eax
  104fe4:	85 c0                	test   %eax,%eax
  104fe6:	74 c6                	je     104fae <trap+0x4e>
  104fe8:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  104fec:	83 e0 03             	and    $0x3,%eax
  104fef:	66 83 f8 03          	cmp    $0x3,%ax
  104ff3:	75 b9                	jne    104fae <trap+0x4e>
}
  104ff5:	83 c4 04             	add    $0x4,%esp
  104ff8:	5b                   	pop    %ebx
  104ff9:	5e                   	pop    %esi
      exit();
  104ffa:	e9 41 e9 ff ff       	jmp    103940 <exit>
  104fff:	90                   	nop
    if(cpu->id == 0){
  105000:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  105006:	80 38 00             	cmpb   $0x0,(%eax)
  105009:	0f 84 19 01 00 00    	je     105128 <trap+0x1c8>
    lapiceoi();
  10500f:	e8 8c d7 ff ff       	call   1027a0 <lapiceoi>
    break;
  105014:	eb ac                	jmp    104fc2 <trap+0x62>
  105016:	8d 76 00             	lea    0x0(%esi),%esi
  105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    kbdintr();
  105020:	e8 fb d5 ff ff       	call   102620 <kbdintr>
    lapiceoi();
  105025:	e8 76 d7 ff ff       	call   1027a0 <lapiceoi>
    break;
  10502a:	eb 96                	jmp    104fc2 <trap+0x62>
  10502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
  105030:	e8 ab 02 00 00       	call   1052e0 <uartintr>
  105035:	eb d8                	jmp    10500f <trap+0xaf>
  105037:	89 f6                	mov    %esi,%esi
  105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  105040:	ff 73 38             	pushl  0x38(%ebx)
  105043:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  105047:	50                   	push   %eax
            cpu->id, tf->cs, tf->eip);
  105048:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  10504e:	0f b6 00             	movzbl (%eax),%eax
  105051:	50                   	push   %eax
  105052:	68 80 64 10 00       	push   $0x106480
  105057:	e8 34 b6 ff ff       	call   100690 <cprintf>
    lapiceoi();
  10505c:	e8 3f d7 ff ff       	call   1027a0 <lapiceoi>
    break;
  105061:	83 c4 10             	add    $0x10,%esp
  105064:	e9 59 ff ff ff       	jmp    104fc2 <trap+0x62>
  105069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      exit();
  105070:	e8 cb e8 ff ff       	call   103940 <exit>
  105075:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  10507b:	e9 19 ff ff ff       	jmp    104f99 <trap+0x39>
    if(proc == 0 || (tf->cs&3) == 0){
  105080:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  105087:	85 d2                	test   %edx,%edx
  105089:	0f 84 cd 00 00 00    	je     10515c <trap+0x1fc>
  10508f:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  105093:	0f 84 c3 00 00 00    	je     10515c <trap+0x1fc>
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip);
  105099:	65 8b 35 00 00 00 00 	mov    %gs:0x0,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1050a0:	8b 4a 10             	mov    0x10(%edx),%ecx
  1050a3:	83 ec 04             	sub    $0x4,%esp
  1050a6:	ff 73 38             	pushl  0x38(%ebx)
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip);
  1050a9:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1050ac:	0f b6 36             	movzbl (%esi),%esi
  1050af:	56                   	push   %esi
  1050b0:	ff 73 34             	pushl  0x34(%ebx)
  1050b3:	50                   	push   %eax
  1050b4:	52                   	push   %edx
  1050b5:	51                   	push   %ecx
  1050b6:	68 cc 64 10 00       	push   $0x1064cc
  1050bb:	e8 d0 b5 ff ff       	call   100690 <cprintf>
    proc->killed = 1;
  1050c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  1050c6:	83 c4 20             	add    $0x20,%esp
  1050c9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  1050d0:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
  1050d4:	83 e2 03             	and    $0x3,%edx
  1050d7:	66 83 fa 03          	cmp    $0x3,%dx
  1050db:	0f 85 f6 fe ff ff    	jne    104fd7 <trap+0x77>
    exit();
  1050e1:	e8 5a e8 ff ff       	call   103940 <exit>
  1050e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  1050ec:	85 c0                	test   %eax,%eax
  1050ee:	0f 85 e3 fe ff ff    	jne    104fd7 <trap+0x77>
  1050f4:	e9 b5 fe ff ff       	jmp    104fae <trap+0x4e>
  1050f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105100:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  105104:	0f 85 d7 fe ff ff    	jne    104fe1 <trap+0x81>
    yield();
  10510a:	e8 51 e6 ff ff       	call   103760 <yield>
  10510f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
  105115:	85 c0                	test   %eax,%eax
  105117:	0f 85 c4 fe ff ff    	jne    104fe1 <trap+0x81>
  10511d:	e9 8c fe ff ff       	jmp    104fae <trap+0x4e>
  105122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
  105128:	83 ec 0c             	sub    $0xc,%esp
  10512b:	68 e0 ff 10 00       	push   $0x10ffe0
  105130:	e8 5b ea ff ff       	call   103b90 <acquire>
      wakeup(&ticks);
  105135:	c7 04 24 20 08 11 00 	movl   $0x110820,(%esp)
      ticks++;
  10513c:	83 05 20 08 11 00 01 	addl   $0x1,0x110820
      wakeup(&ticks);
  105143:	e8 08 e7 ff ff       	call   103850 <wakeup>
      release(&tickslock);
  105148:	c7 04 24 e0 ff 10 00 	movl   $0x10ffe0,(%esp)
  10514f:	e8 dc eb ff ff       	call   103d30 <release>
  105154:	83 c4 10             	add    $0x10,%esp
  105157:	e9 b3 fe ff ff       	jmp    10500f <trap+0xaf>
              tf->trapno, cpu->id, tf->eip);
  10515c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  105163:	ff 73 38             	pushl  0x38(%ebx)
  105166:	0f b6 12             	movzbl (%edx),%edx
  105169:	52                   	push   %edx
  10516a:	50                   	push   %eax
  10516b:	68 a4 64 10 00       	push   $0x1064a4
  105170:	e8 1b b5 ff ff       	call   100690 <cprintf>
      panic("trap");
  105175:	c7 04 24 7a 64 10 00 	movl   $0x10647a,(%esp)
  10517c:	e8 8f b6 ff ff       	call   100810 <panic>
  105181:	66 90                	xchg   %ax,%ax
  105183:	66 90                	xchg   %ax,%ax
  105185:	66 90                	xchg   %ax,%ax
  105187:	66 90                	xchg   %ax,%ax
  105189:	66 90                	xchg   %ax,%ax
  10518b:	66 90                	xchg   %ax,%ax
  10518d:	66 90                	xchg   %ax,%ax
  10518f:	90                   	nop

00105190 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
  105190:	a1 44 a8 10 00       	mov    0x10a844,%eax
  105195:	85 c0                	test   %eax,%eax
  105197:	74 17                	je     1051b0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  105199:	ba fd 03 00 00       	mov    $0x3fd,%edx
  10519e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
  10519f:	a8 01                	test   $0x1,%al
  1051a1:	74 0d                	je     1051b0 <uartgetc+0x20>
  1051a3:	ba f8 03 00 00       	mov    $0x3f8,%edx
  1051a8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  1051a9:	0f b6 c0             	movzbl %al,%eax
  1051ac:	c3                   	ret    
  1051ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  1051b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1051b5:	c3                   	ret    
  1051b6:	8d 76 00             	lea    0x0(%esi),%esi
  1051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001051c0 <uartputc.part.0>:
uartputc(int c)
  1051c0:	57                   	push   %edi
  1051c1:	89 c7                	mov    %eax,%edi
  1051c3:	56                   	push   %esi
  1051c4:	be fd 03 00 00       	mov    $0x3fd,%esi
  1051c9:	53                   	push   %ebx
  1051ca:	bb 80 00 00 00       	mov    $0x80,%ebx
  1051cf:	eb 19                	jmp    1051ea <uartputc.part.0+0x2a>
  1051d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    microdelay(10);
  1051d8:	83 ec 0c             	sub    $0xc,%esp
  1051db:	6a 0a                	push   $0xa
  1051dd:	e8 de d5 ff ff       	call   1027c0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  1051e2:	83 c4 10             	add    $0x10,%esp
  1051e5:	83 eb 01             	sub    $0x1,%ebx
  1051e8:	74 07                	je     1051f1 <uartputc.part.0+0x31>
  1051ea:	89 f2                	mov    %esi,%edx
  1051ec:	ec                   	in     (%dx),%al
  1051ed:	a8 20                	test   $0x20,%al
  1051ef:	74 e7                	je     1051d8 <uartputc.part.0+0x18>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1051f1:	ba f8 03 00 00       	mov    $0x3f8,%edx
  1051f6:	89 f8                	mov    %edi,%eax
  1051f8:	ee                   	out    %al,(%dx)
}
  1051f9:	5b                   	pop    %ebx
  1051fa:	5e                   	pop    %esi
  1051fb:	5f                   	pop    %edi
  1051fc:	c3                   	ret    
  1051fd:	8d 76 00             	lea    0x0(%esi),%esi

00105200 <uartinit>:
{
  105200:	55                   	push   %ebp
  105201:	57                   	push   %edi
  105202:	31 c9                	xor    %ecx,%ecx
  105204:	56                   	push   %esi
  105205:	53                   	push   %ebx
  105206:	be fa 03 00 00       	mov    $0x3fa,%esi
  10520b:	89 c8                	mov    %ecx,%eax
  10520d:	89 f2                	mov    %esi,%edx
  10520f:	83 ec 0c             	sub    $0xc,%esp
  105212:	ee                   	out    %al,(%dx)
  105213:	bd fb 03 00 00       	mov    $0x3fb,%ebp
  105218:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  10521d:	89 ea                	mov    %ebp,%edx
  10521f:	ee                   	out    %al,(%dx)
  105220:	bb f8 03 00 00       	mov    $0x3f8,%ebx
  105225:	b8 0c 00 00 00       	mov    $0xc,%eax
  10522a:	89 da                	mov    %ebx,%edx
  10522c:	ee                   	out    %al,(%dx)
  10522d:	bf f9 03 00 00       	mov    $0x3f9,%edi
  105232:	89 c8                	mov    %ecx,%eax
  105234:	89 fa                	mov    %edi,%edx
  105236:	ee                   	out    %al,(%dx)
  105237:	b8 03 00 00 00       	mov    $0x3,%eax
  10523c:	89 ea                	mov    %ebp,%edx
  10523e:	ee                   	out    %al,(%dx)
  10523f:	ba fc 03 00 00       	mov    $0x3fc,%edx
  105244:	89 c8                	mov    %ecx,%eax
  105246:	ee                   	out    %al,(%dx)
  105247:	b8 01 00 00 00       	mov    $0x1,%eax
  10524c:	89 fa                	mov    %edi,%edx
  10524e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10524f:	ba fd 03 00 00       	mov    $0x3fd,%edx
  105254:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
  105255:	3c ff                	cmp    $0xff,%al
  105257:	74 5a                	je     1052b3 <uartinit+0xb3>
  uart = 1;
  105259:	c7 05 44 a8 10 00 01 	movl   $0x1,0x10a844
  105260:	00 00 00 
  105263:	89 f2                	mov    %esi,%edx
  105265:	ec                   	in     (%dx),%al
  105266:	89 da                	mov    %ebx,%edx
  105268:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
  105269:	83 ec 0c             	sub    $0xc,%esp
  10526c:	6a 04                	push   $0x4
  10526e:	e8 fd d8 ff ff       	call   102b70 <picenable>
  ioapicenable(IRQ_COM1, 0);
  105273:	59                   	pop    %ecx
  105274:	5b                   	pop    %ebx
  105275:	6a 00                	push   $0x0
  105277:	6a 04                	push   $0x4
  105279:	bb 88 65 10 00       	mov    $0x106588,%ebx
  10527e:	e8 6d d0 ff ff       	call   1022f0 <ioapicenable>
  105283:	83 c4 10             	add    $0x10,%esp
  105286:	b8 78 00 00 00       	mov    $0x78,%eax
  10528b:	eb 0d                	jmp    10529a <uartinit+0x9a>
  10528d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p="xv6...\n"; *p; p++)
  105290:	83 c3 01             	add    $0x1,%ebx
  105293:	0f be 03             	movsbl (%ebx),%eax
  105296:	84 c0                	test   %al,%al
  105298:	74 19                	je     1052b3 <uartinit+0xb3>
  if(!uart)
  10529a:	8b 15 44 a8 10 00    	mov    0x10a844,%edx
  1052a0:	85 d2                	test   %edx,%edx
  1052a2:	74 ec                	je     105290 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
  1052a4:	83 c3 01             	add    $0x1,%ebx
  1052a7:	e8 14 ff ff ff       	call   1051c0 <uartputc.part.0>
  1052ac:	0f be 03             	movsbl (%ebx),%eax
  1052af:	84 c0                	test   %al,%al
  1052b1:	75 e7                	jne    10529a <uartinit+0x9a>
}
  1052b3:	83 c4 0c             	add    $0xc,%esp
  1052b6:	5b                   	pop    %ebx
  1052b7:	5e                   	pop    %esi
  1052b8:	5f                   	pop    %edi
  1052b9:	5d                   	pop    %ebp
  1052ba:	c3                   	ret    
  1052bb:	90                   	nop
  1052bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001052c0 <uartputc>:
  if(!uart)
  1052c0:	8b 15 44 a8 10 00    	mov    0x10a844,%edx
{
  1052c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  if(!uart)
  1052ca:	85 d2                	test   %edx,%edx
  1052cc:	74 0a                	je     1052d8 <uartputc+0x18>
  1052ce:	e9 ed fe ff ff       	jmp    1051c0 <uartputc.part.0>
  1052d3:	90                   	nop
  1052d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1052d8:	f3 c3                	repz ret 
  1052da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001052e0 <uartintr>:

void
uartintr(void)
{
  1052e0:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
  1052e3:	68 90 51 10 00       	push   $0x105190
  1052e8:	e8 a3 b5 ff ff       	call   100890 <consoleintr>
}
  1052ed:	83 c4 1c             	add    $0x1c,%esp
  1052f0:	c3                   	ret    

001052f1 <vector0>:
  1052f1:	6a 00                	push   $0x0
  1052f3:	6a 00                	push   $0x0
  1052f5:	e9 70 fb ff ff       	jmp    104e6a <alltraps>

001052fa <vector1>:
  1052fa:	6a 00                	push   $0x0
  1052fc:	6a 01                	push   $0x1
  1052fe:	e9 67 fb ff ff       	jmp    104e6a <alltraps>

00105303 <vector2>:
  105303:	6a 00                	push   $0x0
  105305:	6a 02                	push   $0x2
  105307:	e9 5e fb ff ff       	jmp    104e6a <alltraps>

0010530c <vector3>:
  10530c:	6a 00                	push   $0x0
  10530e:	6a 03                	push   $0x3
  105310:	e9 55 fb ff ff       	jmp    104e6a <alltraps>

00105315 <vector4>:
  105315:	6a 00                	push   $0x0
  105317:	6a 04                	push   $0x4
  105319:	e9 4c fb ff ff       	jmp    104e6a <alltraps>

0010531e <vector5>:
  10531e:	6a 00                	push   $0x0
  105320:	6a 05                	push   $0x5
  105322:	e9 43 fb ff ff       	jmp    104e6a <alltraps>

00105327 <vector6>:
  105327:	6a 00                	push   $0x0
  105329:	6a 06                	push   $0x6
  10532b:	e9 3a fb ff ff       	jmp    104e6a <alltraps>

00105330 <vector7>:
  105330:	6a 00                	push   $0x0
  105332:	6a 07                	push   $0x7
  105334:	e9 31 fb ff ff       	jmp    104e6a <alltraps>

00105339 <vector8>:
  105339:	6a 08                	push   $0x8
  10533b:	e9 2a fb ff ff       	jmp    104e6a <alltraps>

00105340 <vector9>:
  105340:	6a 00                	push   $0x0
  105342:	6a 09                	push   $0x9
  105344:	e9 21 fb ff ff       	jmp    104e6a <alltraps>

00105349 <vector10>:
  105349:	6a 0a                	push   $0xa
  10534b:	e9 1a fb ff ff       	jmp    104e6a <alltraps>

00105350 <vector11>:
  105350:	6a 0b                	push   $0xb
  105352:	e9 13 fb ff ff       	jmp    104e6a <alltraps>

00105357 <vector12>:
  105357:	6a 0c                	push   $0xc
  105359:	e9 0c fb ff ff       	jmp    104e6a <alltraps>

0010535e <vector13>:
  10535e:	6a 0d                	push   $0xd
  105360:	e9 05 fb ff ff       	jmp    104e6a <alltraps>

00105365 <vector14>:
  105365:	6a 0e                	push   $0xe
  105367:	e9 fe fa ff ff       	jmp    104e6a <alltraps>

0010536c <vector15>:
  10536c:	6a 00                	push   $0x0
  10536e:	6a 0f                	push   $0xf
  105370:	e9 f5 fa ff ff       	jmp    104e6a <alltraps>

00105375 <vector16>:
  105375:	6a 00                	push   $0x0
  105377:	6a 10                	push   $0x10
  105379:	e9 ec fa ff ff       	jmp    104e6a <alltraps>

0010537e <vector17>:
  10537e:	6a 11                	push   $0x11
  105380:	e9 e5 fa ff ff       	jmp    104e6a <alltraps>

00105385 <vector18>:
  105385:	6a 00                	push   $0x0
  105387:	6a 12                	push   $0x12
  105389:	e9 dc fa ff ff       	jmp    104e6a <alltraps>

0010538e <vector19>:
  10538e:	6a 00                	push   $0x0
  105390:	6a 13                	push   $0x13
  105392:	e9 d3 fa ff ff       	jmp    104e6a <alltraps>

00105397 <vector20>:
  105397:	6a 00                	push   $0x0
  105399:	6a 14                	push   $0x14
  10539b:	e9 ca fa ff ff       	jmp    104e6a <alltraps>

001053a0 <vector21>:
  1053a0:	6a 00                	push   $0x0
  1053a2:	6a 15                	push   $0x15
  1053a4:	e9 c1 fa ff ff       	jmp    104e6a <alltraps>

001053a9 <vector22>:
  1053a9:	6a 00                	push   $0x0
  1053ab:	6a 16                	push   $0x16
  1053ad:	e9 b8 fa ff ff       	jmp    104e6a <alltraps>

001053b2 <vector23>:
  1053b2:	6a 00                	push   $0x0
  1053b4:	6a 17                	push   $0x17
  1053b6:	e9 af fa ff ff       	jmp    104e6a <alltraps>

001053bb <vector24>:
  1053bb:	6a 00                	push   $0x0
  1053bd:	6a 18                	push   $0x18
  1053bf:	e9 a6 fa ff ff       	jmp    104e6a <alltraps>

001053c4 <vector25>:
  1053c4:	6a 00                	push   $0x0
  1053c6:	6a 19                	push   $0x19
  1053c8:	e9 9d fa ff ff       	jmp    104e6a <alltraps>

001053cd <vector26>:
  1053cd:	6a 00                	push   $0x0
  1053cf:	6a 1a                	push   $0x1a
  1053d1:	e9 94 fa ff ff       	jmp    104e6a <alltraps>

001053d6 <vector27>:
  1053d6:	6a 00                	push   $0x0
  1053d8:	6a 1b                	push   $0x1b
  1053da:	e9 8b fa ff ff       	jmp    104e6a <alltraps>

001053df <vector28>:
  1053df:	6a 00                	push   $0x0
  1053e1:	6a 1c                	push   $0x1c
  1053e3:	e9 82 fa ff ff       	jmp    104e6a <alltraps>

001053e8 <vector29>:
  1053e8:	6a 00                	push   $0x0
  1053ea:	6a 1d                	push   $0x1d
  1053ec:	e9 79 fa ff ff       	jmp    104e6a <alltraps>

001053f1 <vector30>:
  1053f1:	6a 00                	push   $0x0
  1053f3:	6a 1e                	push   $0x1e
  1053f5:	e9 70 fa ff ff       	jmp    104e6a <alltraps>

001053fa <vector31>:
  1053fa:	6a 00                	push   $0x0
  1053fc:	6a 1f                	push   $0x1f
  1053fe:	e9 67 fa ff ff       	jmp    104e6a <alltraps>

00105403 <vector32>:
  105403:	6a 00                	push   $0x0
  105405:	6a 20                	push   $0x20
  105407:	e9 5e fa ff ff       	jmp    104e6a <alltraps>

0010540c <vector33>:
  10540c:	6a 00                	push   $0x0
  10540e:	6a 21                	push   $0x21
  105410:	e9 55 fa ff ff       	jmp    104e6a <alltraps>

00105415 <vector34>:
  105415:	6a 00                	push   $0x0
  105417:	6a 22                	push   $0x22
  105419:	e9 4c fa ff ff       	jmp    104e6a <alltraps>

0010541e <vector35>:
  10541e:	6a 00                	push   $0x0
  105420:	6a 23                	push   $0x23
  105422:	e9 43 fa ff ff       	jmp    104e6a <alltraps>

00105427 <vector36>:
  105427:	6a 00                	push   $0x0
  105429:	6a 24                	push   $0x24
  10542b:	e9 3a fa ff ff       	jmp    104e6a <alltraps>

00105430 <vector37>:
  105430:	6a 00                	push   $0x0
  105432:	6a 25                	push   $0x25
  105434:	e9 31 fa ff ff       	jmp    104e6a <alltraps>

00105439 <vector38>:
  105439:	6a 00                	push   $0x0
  10543b:	6a 26                	push   $0x26
  10543d:	e9 28 fa ff ff       	jmp    104e6a <alltraps>

00105442 <vector39>:
  105442:	6a 00                	push   $0x0
  105444:	6a 27                	push   $0x27
  105446:	e9 1f fa ff ff       	jmp    104e6a <alltraps>

0010544b <vector40>:
  10544b:	6a 00                	push   $0x0
  10544d:	6a 28                	push   $0x28
  10544f:	e9 16 fa ff ff       	jmp    104e6a <alltraps>

00105454 <vector41>:
  105454:	6a 00                	push   $0x0
  105456:	6a 29                	push   $0x29
  105458:	e9 0d fa ff ff       	jmp    104e6a <alltraps>

0010545d <vector42>:
  10545d:	6a 00                	push   $0x0
  10545f:	6a 2a                	push   $0x2a
  105461:	e9 04 fa ff ff       	jmp    104e6a <alltraps>

00105466 <vector43>:
  105466:	6a 00                	push   $0x0
  105468:	6a 2b                	push   $0x2b
  10546a:	e9 fb f9 ff ff       	jmp    104e6a <alltraps>

0010546f <vector44>:
  10546f:	6a 00                	push   $0x0
  105471:	6a 2c                	push   $0x2c
  105473:	e9 f2 f9 ff ff       	jmp    104e6a <alltraps>

00105478 <vector45>:
  105478:	6a 00                	push   $0x0
  10547a:	6a 2d                	push   $0x2d
  10547c:	e9 e9 f9 ff ff       	jmp    104e6a <alltraps>

00105481 <vector46>:
  105481:	6a 00                	push   $0x0
  105483:	6a 2e                	push   $0x2e
  105485:	e9 e0 f9 ff ff       	jmp    104e6a <alltraps>

0010548a <vector47>:
  10548a:	6a 00                	push   $0x0
  10548c:	6a 2f                	push   $0x2f
  10548e:	e9 d7 f9 ff ff       	jmp    104e6a <alltraps>

00105493 <vector48>:
  105493:	6a 00                	push   $0x0
  105495:	6a 30                	push   $0x30
  105497:	e9 ce f9 ff ff       	jmp    104e6a <alltraps>

0010549c <vector49>:
  10549c:	6a 00                	push   $0x0
  10549e:	6a 31                	push   $0x31
  1054a0:	e9 c5 f9 ff ff       	jmp    104e6a <alltraps>

001054a5 <vector50>:
  1054a5:	6a 00                	push   $0x0
  1054a7:	6a 32                	push   $0x32
  1054a9:	e9 bc f9 ff ff       	jmp    104e6a <alltraps>

001054ae <vector51>:
  1054ae:	6a 00                	push   $0x0
  1054b0:	6a 33                	push   $0x33
  1054b2:	e9 b3 f9 ff ff       	jmp    104e6a <alltraps>

001054b7 <vector52>:
  1054b7:	6a 00                	push   $0x0
  1054b9:	6a 34                	push   $0x34
  1054bb:	e9 aa f9 ff ff       	jmp    104e6a <alltraps>

001054c0 <vector53>:
  1054c0:	6a 00                	push   $0x0
  1054c2:	6a 35                	push   $0x35
  1054c4:	e9 a1 f9 ff ff       	jmp    104e6a <alltraps>

001054c9 <vector54>:
  1054c9:	6a 00                	push   $0x0
  1054cb:	6a 36                	push   $0x36
  1054cd:	e9 98 f9 ff ff       	jmp    104e6a <alltraps>

001054d2 <vector55>:
  1054d2:	6a 00                	push   $0x0
  1054d4:	6a 37                	push   $0x37
  1054d6:	e9 8f f9 ff ff       	jmp    104e6a <alltraps>

001054db <vector56>:
  1054db:	6a 00                	push   $0x0
  1054dd:	6a 38                	push   $0x38
  1054df:	e9 86 f9 ff ff       	jmp    104e6a <alltraps>

001054e4 <vector57>:
  1054e4:	6a 00                	push   $0x0
  1054e6:	6a 39                	push   $0x39
  1054e8:	e9 7d f9 ff ff       	jmp    104e6a <alltraps>

001054ed <vector58>:
  1054ed:	6a 00                	push   $0x0
  1054ef:	6a 3a                	push   $0x3a
  1054f1:	e9 74 f9 ff ff       	jmp    104e6a <alltraps>

001054f6 <vector59>:
  1054f6:	6a 00                	push   $0x0
  1054f8:	6a 3b                	push   $0x3b
  1054fa:	e9 6b f9 ff ff       	jmp    104e6a <alltraps>

001054ff <vector60>:
  1054ff:	6a 00                	push   $0x0
  105501:	6a 3c                	push   $0x3c
  105503:	e9 62 f9 ff ff       	jmp    104e6a <alltraps>

00105508 <vector61>:
  105508:	6a 00                	push   $0x0
  10550a:	6a 3d                	push   $0x3d
  10550c:	e9 59 f9 ff ff       	jmp    104e6a <alltraps>

00105511 <vector62>:
  105511:	6a 00                	push   $0x0
  105513:	6a 3e                	push   $0x3e
  105515:	e9 50 f9 ff ff       	jmp    104e6a <alltraps>

0010551a <vector63>:
  10551a:	6a 00                	push   $0x0
  10551c:	6a 3f                	push   $0x3f
  10551e:	e9 47 f9 ff ff       	jmp    104e6a <alltraps>

00105523 <vector64>:
  105523:	6a 00                	push   $0x0
  105525:	6a 40                	push   $0x40
  105527:	e9 3e f9 ff ff       	jmp    104e6a <alltraps>

0010552c <vector65>:
  10552c:	6a 00                	push   $0x0
  10552e:	6a 41                	push   $0x41
  105530:	e9 35 f9 ff ff       	jmp    104e6a <alltraps>

00105535 <vector66>:
  105535:	6a 00                	push   $0x0
  105537:	6a 42                	push   $0x42
  105539:	e9 2c f9 ff ff       	jmp    104e6a <alltraps>

0010553e <vector67>:
  10553e:	6a 00                	push   $0x0
  105540:	6a 43                	push   $0x43
  105542:	e9 23 f9 ff ff       	jmp    104e6a <alltraps>

00105547 <vector68>:
  105547:	6a 00                	push   $0x0
  105549:	6a 44                	push   $0x44
  10554b:	e9 1a f9 ff ff       	jmp    104e6a <alltraps>

00105550 <vector69>:
  105550:	6a 00                	push   $0x0
  105552:	6a 45                	push   $0x45
  105554:	e9 11 f9 ff ff       	jmp    104e6a <alltraps>

00105559 <vector70>:
  105559:	6a 00                	push   $0x0
  10555b:	6a 46                	push   $0x46
  10555d:	e9 08 f9 ff ff       	jmp    104e6a <alltraps>

00105562 <vector71>:
  105562:	6a 00                	push   $0x0
  105564:	6a 47                	push   $0x47
  105566:	e9 ff f8 ff ff       	jmp    104e6a <alltraps>

0010556b <vector72>:
  10556b:	6a 00                	push   $0x0
  10556d:	6a 48                	push   $0x48
  10556f:	e9 f6 f8 ff ff       	jmp    104e6a <alltraps>

00105574 <vector73>:
  105574:	6a 00                	push   $0x0
  105576:	6a 49                	push   $0x49
  105578:	e9 ed f8 ff ff       	jmp    104e6a <alltraps>

0010557d <vector74>:
  10557d:	6a 00                	push   $0x0
  10557f:	6a 4a                	push   $0x4a
  105581:	e9 e4 f8 ff ff       	jmp    104e6a <alltraps>

00105586 <vector75>:
  105586:	6a 00                	push   $0x0
  105588:	6a 4b                	push   $0x4b
  10558a:	e9 db f8 ff ff       	jmp    104e6a <alltraps>

0010558f <vector76>:
  10558f:	6a 00                	push   $0x0
  105591:	6a 4c                	push   $0x4c
  105593:	e9 d2 f8 ff ff       	jmp    104e6a <alltraps>

00105598 <vector77>:
  105598:	6a 00                	push   $0x0
  10559a:	6a 4d                	push   $0x4d
  10559c:	e9 c9 f8 ff ff       	jmp    104e6a <alltraps>

001055a1 <vector78>:
  1055a1:	6a 00                	push   $0x0
  1055a3:	6a 4e                	push   $0x4e
  1055a5:	e9 c0 f8 ff ff       	jmp    104e6a <alltraps>

001055aa <vector79>:
  1055aa:	6a 00                	push   $0x0
  1055ac:	6a 4f                	push   $0x4f
  1055ae:	e9 b7 f8 ff ff       	jmp    104e6a <alltraps>

001055b3 <vector80>:
  1055b3:	6a 00                	push   $0x0
  1055b5:	6a 50                	push   $0x50
  1055b7:	e9 ae f8 ff ff       	jmp    104e6a <alltraps>

001055bc <vector81>:
  1055bc:	6a 00                	push   $0x0
  1055be:	6a 51                	push   $0x51
  1055c0:	e9 a5 f8 ff ff       	jmp    104e6a <alltraps>

001055c5 <vector82>:
  1055c5:	6a 00                	push   $0x0
  1055c7:	6a 52                	push   $0x52
  1055c9:	e9 9c f8 ff ff       	jmp    104e6a <alltraps>

001055ce <vector83>:
  1055ce:	6a 00                	push   $0x0
  1055d0:	6a 53                	push   $0x53
  1055d2:	e9 93 f8 ff ff       	jmp    104e6a <alltraps>

001055d7 <vector84>:
  1055d7:	6a 00                	push   $0x0
  1055d9:	6a 54                	push   $0x54
  1055db:	e9 8a f8 ff ff       	jmp    104e6a <alltraps>

001055e0 <vector85>:
  1055e0:	6a 00                	push   $0x0
  1055e2:	6a 55                	push   $0x55
  1055e4:	e9 81 f8 ff ff       	jmp    104e6a <alltraps>

001055e9 <vector86>:
  1055e9:	6a 00                	push   $0x0
  1055eb:	6a 56                	push   $0x56
  1055ed:	e9 78 f8 ff ff       	jmp    104e6a <alltraps>

001055f2 <vector87>:
  1055f2:	6a 00                	push   $0x0
  1055f4:	6a 57                	push   $0x57
  1055f6:	e9 6f f8 ff ff       	jmp    104e6a <alltraps>

001055fb <vector88>:
  1055fb:	6a 00                	push   $0x0
  1055fd:	6a 58                	push   $0x58
  1055ff:	e9 66 f8 ff ff       	jmp    104e6a <alltraps>

00105604 <vector89>:
  105604:	6a 00                	push   $0x0
  105606:	6a 59                	push   $0x59
  105608:	e9 5d f8 ff ff       	jmp    104e6a <alltraps>

0010560d <vector90>:
  10560d:	6a 00                	push   $0x0
  10560f:	6a 5a                	push   $0x5a
  105611:	e9 54 f8 ff ff       	jmp    104e6a <alltraps>

00105616 <vector91>:
  105616:	6a 00                	push   $0x0
  105618:	6a 5b                	push   $0x5b
  10561a:	e9 4b f8 ff ff       	jmp    104e6a <alltraps>

0010561f <vector92>:
  10561f:	6a 00                	push   $0x0
  105621:	6a 5c                	push   $0x5c
  105623:	e9 42 f8 ff ff       	jmp    104e6a <alltraps>

00105628 <vector93>:
  105628:	6a 00                	push   $0x0
  10562a:	6a 5d                	push   $0x5d
  10562c:	e9 39 f8 ff ff       	jmp    104e6a <alltraps>

00105631 <vector94>:
  105631:	6a 00                	push   $0x0
  105633:	6a 5e                	push   $0x5e
  105635:	e9 30 f8 ff ff       	jmp    104e6a <alltraps>

0010563a <vector95>:
  10563a:	6a 00                	push   $0x0
  10563c:	6a 5f                	push   $0x5f
  10563e:	e9 27 f8 ff ff       	jmp    104e6a <alltraps>

00105643 <vector96>:
  105643:	6a 00                	push   $0x0
  105645:	6a 60                	push   $0x60
  105647:	e9 1e f8 ff ff       	jmp    104e6a <alltraps>

0010564c <vector97>:
  10564c:	6a 00                	push   $0x0
  10564e:	6a 61                	push   $0x61
  105650:	e9 15 f8 ff ff       	jmp    104e6a <alltraps>

00105655 <vector98>:
  105655:	6a 00                	push   $0x0
  105657:	6a 62                	push   $0x62
  105659:	e9 0c f8 ff ff       	jmp    104e6a <alltraps>

0010565e <vector99>:
  10565e:	6a 00                	push   $0x0
  105660:	6a 63                	push   $0x63
  105662:	e9 03 f8 ff ff       	jmp    104e6a <alltraps>

00105667 <vector100>:
  105667:	6a 00                	push   $0x0
  105669:	6a 64                	push   $0x64
  10566b:	e9 fa f7 ff ff       	jmp    104e6a <alltraps>

00105670 <vector101>:
  105670:	6a 00                	push   $0x0
  105672:	6a 65                	push   $0x65
  105674:	e9 f1 f7 ff ff       	jmp    104e6a <alltraps>

00105679 <vector102>:
  105679:	6a 00                	push   $0x0
  10567b:	6a 66                	push   $0x66
  10567d:	e9 e8 f7 ff ff       	jmp    104e6a <alltraps>

00105682 <vector103>:
  105682:	6a 00                	push   $0x0
  105684:	6a 67                	push   $0x67
  105686:	e9 df f7 ff ff       	jmp    104e6a <alltraps>

0010568b <vector104>:
  10568b:	6a 00                	push   $0x0
  10568d:	6a 68                	push   $0x68
  10568f:	e9 d6 f7 ff ff       	jmp    104e6a <alltraps>

00105694 <vector105>:
  105694:	6a 00                	push   $0x0
  105696:	6a 69                	push   $0x69
  105698:	e9 cd f7 ff ff       	jmp    104e6a <alltraps>

0010569d <vector106>:
  10569d:	6a 00                	push   $0x0
  10569f:	6a 6a                	push   $0x6a
  1056a1:	e9 c4 f7 ff ff       	jmp    104e6a <alltraps>

001056a6 <vector107>:
  1056a6:	6a 00                	push   $0x0
  1056a8:	6a 6b                	push   $0x6b
  1056aa:	e9 bb f7 ff ff       	jmp    104e6a <alltraps>

001056af <vector108>:
  1056af:	6a 00                	push   $0x0
  1056b1:	6a 6c                	push   $0x6c
  1056b3:	e9 b2 f7 ff ff       	jmp    104e6a <alltraps>

001056b8 <vector109>:
  1056b8:	6a 00                	push   $0x0
  1056ba:	6a 6d                	push   $0x6d
  1056bc:	e9 a9 f7 ff ff       	jmp    104e6a <alltraps>

001056c1 <vector110>:
  1056c1:	6a 00                	push   $0x0
  1056c3:	6a 6e                	push   $0x6e
  1056c5:	e9 a0 f7 ff ff       	jmp    104e6a <alltraps>

001056ca <vector111>:
  1056ca:	6a 00                	push   $0x0
  1056cc:	6a 6f                	push   $0x6f
  1056ce:	e9 97 f7 ff ff       	jmp    104e6a <alltraps>

001056d3 <vector112>:
  1056d3:	6a 00                	push   $0x0
  1056d5:	6a 70                	push   $0x70
  1056d7:	e9 8e f7 ff ff       	jmp    104e6a <alltraps>

001056dc <vector113>:
  1056dc:	6a 00                	push   $0x0
  1056de:	6a 71                	push   $0x71
  1056e0:	e9 85 f7 ff ff       	jmp    104e6a <alltraps>

001056e5 <vector114>:
  1056e5:	6a 00                	push   $0x0
  1056e7:	6a 72                	push   $0x72
  1056e9:	e9 7c f7 ff ff       	jmp    104e6a <alltraps>

001056ee <vector115>:
  1056ee:	6a 00                	push   $0x0
  1056f0:	6a 73                	push   $0x73
  1056f2:	e9 73 f7 ff ff       	jmp    104e6a <alltraps>

001056f7 <vector116>:
  1056f7:	6a 00                	push   $0x0
  1056f9:	6a 74                	push   $0x74
  1056fb:	e9 6a f7 ff ff       	jmp    104e6a <alltraps>

00105700 <vector117>:
  105700:	6a 00                	push   $0x0
  105702:	6a 75                	push   $0x75
  105704:	e9 61 f7 ff ff       	jmp    104e6a <alltraps>

00105709 <vector118>:
  105709:	6a 00                	push   $0x0
  10570b:	6a 76                	push   $0x76
  10570d:	e9 58 f7 ff ff       	jmp    104e6a <alltraps>

00105712 <vector119>:
  105712:	6a 00                	push   $0x0
  105714:	6a 77                	push   $0x77
  105716:	e9 4f f7 ff ff       	jmp    104e6a <alltraps>

0010571b <vector120>:
  10571b:	6a 00                	push   $0x0
  10571d:	6a 78                	push   $0x78
  10571f:	e9 46 f7 ff ff       	jmp    104e6a <alltraps>

00105724 <vector121>:
  105724:	6a 00                	push   $0x0
  105726:	6a 79                	push   $0x79
  105728:	e9 3d f7 ff ff       	jmp    104e6a <alltraps>

0010572d <vector122>:
  10572d:	6a 00                	push   $0x0
  10572f:	6a 7a                	push   $0x7a
  105731:	e9 34 f7 ff ff       	jmp    104e6a <alltraps>

00105736 <vector123>:
  105736:	6a 00                	push   $0x0
  105738:	6a 7b                	push   $0x7b
  10573a:	e9 2b f7 ff ff       	jmp    104e6a <alltraps>

0010573f <vector124>:
  10573f:	6a 00                	push   $0x0
  105741:	6a 7c                	push   $0x7c
  105743:	e9 22 f7 ff ff       	jmp    104e6a <alltraps>

00105748 <vector125>:
  105748:	6a 00                	push   $0x0
  10574a:	6a 7d                	push   $0x7d
  10574c:	e9 19 f7 ff ff       	jmp    104e6a <alltraps>

00105751 <vector126>:
  105751:	6a 00                	push   $0x0
  105753:	6a 7e                	push   $0x7e
  105755:	e9 10 f7 ff ff       	jmp    104e6a <alltraps>

0010575a <vector127>:
  10575a:	6a 00                	push   $0x0
  10575c:	6a 7f                	push   $0x7f
  10575e:	e9 07 f7 ff ff       	jmp    104e6a <alltraps>

00105763 <vector128>:
  105763:	6a 00                	push   $0x0
  105765:	68 80 00 00 00       	push   $0x80
  10576a:	e9 fb f6 ff ff       	jmp    104e6a <alltraps>

0010576f <vector129>:
  10576f:	6a 00                	push   $0x0
  105771:	68 81 00 00 00       	push   $0x81
  105776:	e9 ef f6 ff ff       	jmp    104e6a <alltraps>

0010577b <vector130>:
  10577b:	6a 00                	push   $0x0
  10577d:	68 82 00 00 00       	push   $0x82
  105782:	e9 e3 f6 ff ff       	jmp    104e6a <alltraps>

00105787 <vector131>:
  105787:	6a 00                	push   $0x0
  105789:	68 83 00 00 00       	push   $0x83
  10578e:	e9 d7 f6 ff ff       	jmp    104e6a <alltraps>

00105793 <vector132>:
  105793:	6a 00                	push   $0x0
  105795:	68 84 00 00 00       	push   $0x84
  10579a:	e9 cb f6 ff ff       	jmp    104e6a <alltraps>

0010579f <vector133>:
  10579f:	6a 00                	push   $0x0
  1057a1:	68 85 00 00 00       	push   $0x85
  1057a6:	e9 bf f6 ff ff       	jmp    104e6a <alltraps>

001057ab <vector134>:
  1057ab:	6a 00                	push   $0x0
  1057ad:	68 86 00 00 00       	push   $0x86
  1057b2:	e9 b3 f6 ff ff       	jmp    104e6a <alltraps>

001057b7 <vector135>:
  1057b7:	6a 00                	push   $0x0
  1057b9:	68 87 00 00 00       	push   $0x87
  1057be:	e9 a7 f6 ff ff       	jmp    104e6a <alltraps>

001057c3 <vector136>:
  1057c3:	6a 00                	push   $0x0
  1057c5:	68 88 00 00 00       	push   $0x88
  1057ca:	e9 9b f6 ff ff       	jmp    104e6a <alltraps>

001057cf <vector137>:
  1057cf:	6a 00                	push   $0x0
  1057d1:	68 89 00 00 00       	push   $0x89
  1057d6:	e9 8f f6 ff ff       	jmp    104e6a <alltraps>

001057db <vector138>:
  1057db:	6a 00                	push   $0x0
  1057dd:	68 8a 00 00 00       	push   $0x8a
  1057e2:	e9 83 f6 ff ff       	jmp    104e6a <alltraps>

001057e7 <vector139>:
  1057e7:	6a 00                	push   $0x0
  1057e9:	68 8b 00 00 00       	push   $0x8b
  1057ee:	e9 77 f6 ff ff       	jmp    104e6a <alltraps>

001057f3 <vector140>:
  1057f3:	6a 00                	push   $0x0
  1057f5:	68 8c 00 00 00       	push   $0x8c
  1057fa:	e9 6b f6 ff ff       	jmp    104e6a <alltraps>

001057ff <vector141>:
  1057ff:	6a 00                	push   $0x0
  105801:	68 8d 00 00 00       	push   $0x8d
  105806:	e9 5f f6 ff ff       	jmp    104e6a <alltraps>

0010580b <vector142>:
  10580b:	6a 00                	push   $0x0
  10580d:	68 8e 00 00 00       	push   $0x8e
  105812:	e9 53 f6 ff ff       	jmp    104e6a <alltraps>

00105817 <vector143>:
  105817:	6a 00                	push   $0x0
  105819:	68 8f 00 00 00       	push   $0x8f
  10581e:	e9 47 f6 ff ff       	jmp    104e6a <alltraps>

00105823 <vector144>:
  105823:	6a 00                	push   $0x0
  105825:	68 90 00 00 00       	push   $0x90
  10582a:	e9 3b f6 ff ff       	jmp    104e6a <alltraps>

0010582f <vector145>:
  10582f:	6a 00                	push   $0x0
  105831:	68 91 00 00 00       	push   $0x91
  105836:	e9 2f f6 ff ff       	jmp    104e6a <alltraps>

0010583b <vector146>:
  10583b:	6a 00                	push   $0x0
  10583d:	68 92 00 00 00       	push   $0x92
  105842:	e9 23 f6 ff ff       	jmp    104e6a <alltraps>

00105847 <vector147>:
  105847:	6a 00                	push   $0x0
  105849:	68 93 00 00 00       	push   $0x93
  10584e:	e9 17 f6 ff ff       	jmp    104e6a <alltraps>

00105853 <vector148>:
  105853:	6a 00                	push   $0x0
  105855:	68 94 00 00 00       	push   $0x94
  10585a:	e9 0b f6 ff ff       	jmp    104e6a <alltraps>

0010585f <vector149>:
  10585f:	6a 00                	push   $0x0
  105861:	68 95 00 00 00       	push   $0x95
  105866:	e9 ff f5 ff ff       	jmp    104e6a <alltraps>

0010586b <vector150>:
  10586b:	6a 00                	push   $0x0
  10586d:	68 96 00 00 00       	push   $0x96
  105872:	e9 f3 f5 ff ff       	jmp    104e6a <alltraps>

00105877 <vector151>:
  105877:	6a 00                	push   $0x0
  105879:	68 97 00 00 00       	push   $0x97
  10587e:	e9 e7 f5 ff ff       	jmp    104e6a <alltraps>

00105883 <vector152>:
  105883:	6a 00                	push   $0x0
  105885:	68 98 00 00 00       	push   $0x98
  10588a:	e9 db f5 ff ff       	jmp    104e6a <alltraps>

0010588f <vector153>:
  10588f:	6a 00                	push   $0x0
  105891:	68 99 00 00 00       	push   $0x99
  105896:	e9 cf f5 ff ff       	jmp    104e6a <alltraps>

0010589b <vector154>:
  10589b:	6a 00                	push   $0x0
  10589d:	68 9a 00 00 00       	push   $0x9a
  1058a2:	e9 c3 f5 ff ff       	jmp    104e6a <alltraps>

001058a7 <vector155>:
  1058a7:	6a 00                	push   $0x0
  1058a9:	68 9b 00 00 00       	push   $0x9b
  1058ae:	e9 b7 f5 ff ff       	jmp    104e6a <alltraps>

001058b3 <vector156>:
  1058b3:	6a 00                	push   $0x0
  1058b5:	68 9c 00 00 00       	push   $0x9c
  1058ba:	e9 ab f5 ff ff       	jmp    104e6a <alltraps>

001058bf <vector157>:
  1058bf:	6a 00                	push   $0x0
  1058c1:	68 9d 00 00 00       	push   $0x9d
  1058c6:	e9 9f f5 ff ff       	jmp    104e6a <alltraps>

001058cb <vector158>:
  1058cb:	6a 00                	push   $0x0
  1058cd:	68 9e 00 00 00       	push   $0x9e
  1058d2:	e9 93 f5 ff ff       	jmp    104e6a <alltraps>

001058d7 <vector159>:
  1058d7:	6a 00                	push   $0x0
  1058d9:	68 9f 00 00 00       	push   $0x9f
  1058de:	e9 87 f5 ff ff       	jmp    104e6a <alltraps>

001058e3 <vector160>:
  1058e3:	6a 00                	push   $0x0
  1058e5:	68 a0 00 00 00       	push   $0xa0
  1058ea:	e9 7b f5 ff ff       	jmp    104e6a <alltraps>

001058ef <vector161>:
  1058ef:	6a 00                	push   $0x0
  1058f1:	68 a1 00 00 00       	push   $0xa1
  1058f6:	e9 6f f5 ff ff       	jmp    104e6a <alltraps>

001058fb <vector162>:
  1058fb:	6a 00                	push   $0x0
  1058fd:	68 a2 00 00 00       	push   $0xa2
  105902:	e9 63 f5 ff ff       	jmp    104e6a <alltraps>

00105907 <vector163>:
  105907:	6a 00                	push   $0x0
  105909:	68 a3 00 00 00       	push   $0xa3
  10590e:	e9 57 f5 ff ff       	jmp    104e6a <alltraps>

00105913 <vector164>:
  105913:	6a 00                	push   $0x0
  105915:	68 a4 00 00 00       	push   $0xa4
  10591a:	e9 4b f5 ff ff       	jmp    104e6a <alltraps>

0010591f <vector165>:
  10591f:	6a 00                	push   $0x0
  105921:	68 a5 00 00 00       	push   $0xa5
  105926:	e9 3f f5 ff ff       	jmp    104e6a <alltraps>

0010592b <vector166>:
  10592b:	6a 00                	push   $0x0
  10592d:	68 a6 00 00 00       	push   $0xa6
  105932:	e9 33 f5 ff ff       	jmp    104e6a <alltraps>

00105937 <vector167>:
  105937:	6a 00                	push   $0x0
  105939:	68 a7 00 00 00       	push   $0xa7
  10593e:	e9 27 f5 ff ff       	jmp    104e6a <alltraps>

00105943 <vector168>:
  105943:	6a 00                	push   $0x0
  105945:	68 a8 00 00 00       	push   $0xa8
  10594a:	e9 1b f5 ff ff       	jmp    104e6a <alltraps>

0010594f <vector169>:
  10594f:	6a 00                	push   $0x0
  105951:	68 a9 00 00 00       	push   $0xa9
  105956:	e9 0f f5 ff ff       	jmp    104e6a <alltraps>

0010595b <vector170>:
  10595b:	6a 00                	push   $0x0
  10595d:	68 aa 00 00 00       	push   $0xaa
  105962:	e9 03 f5 ff ff       	jmp    104e6a <alltraps>

00105967 <vector171>:
  105967:	6a 00                	push   $0x0
  105969:	68 ab 00 00 00       	push   $0xab
  10596e:	e9 f7 f4 ff ff       	jmp    104e6a <alltraps>

00105973 <vector172>:
  105973:	6a 00                	push   $0x0
  105975:	68 ac 00 00 00       	push   $0xac
  10597a:	e9 eb f4 ff ff       	jmp    104e6a <alltraps>

0010597f <vector173>:
  10597f:	6a 00                	push   $0x0
  105981:	68 ad 00 00 00       	push   $0xad
  105986:	e9 df f4 ff ff       	jmp    104e6a <alltraps>

0010598b <vector174>:
  10598b:	6a 00                	push   $0x0
  10598d:	68 ae 00 00 00       	push   $0xae
  105992:	e9 d3 f4 ff ff       	jmp    104e6a <alltraps>

00105997 <vector175>:
  105997:	6a 00                	push   $0x0
  105999:	68 af 00 00 00       	push   $0xaf
  10599e:	e9 c7 f4 ff ff       	jmp    104e6a <alltraps>

001059a3 <vector176>:
  1059a3:	6a 00                	push   $0x0
  1059a5:	68 b0 00 00 00       	push   $0xb0
  1059aa:	e9 bb f4 ff ff       	jmp    104e6a <alltraps>

001059af <vector177>:
  1059af:	6a 00                	push   $0x0
  1059b1:	68 b1 00 00 00       	push   $0xb1
  1059b6:	e9 af f4 ff ff       	jmp    104e6a <alltraps>

001059bb <vector178>:
  1059bb:	6a 00                	push   $0x0
  1059bd:	68 b2 00 00 00       	push   $0xb2
  1059c2:	e9 a3 f4 ff ff       	jmp    104e6a <alltraps>

001059c7 <vector179>:
  1059c7:	6a 00                	push   $0x0
  1059c9:	68 b3 00 00 00       	push   $0xb3
  1059ce:	e9 97 f4 ff ff       	jmp    104e6a <alltraps>

001059d3 <vector180>:
  1059d3:	6a 00                	push   $0x0
  1059d5:	68 b4 00 00 00       	push   $0xb4
  1059da:	e9 8b f4 ff ff       	jmp    104e6a <alltraps>

001059df <vector181>:
  1059df:	6a 00                	push   $0x0
  1059e1:	68 b5 00 00 00       	push   $0xb5
  1059e6:	e9 7f f4 ff ff       	jmp    104e6a <alltraps>

001059eb <vector182>:
  1059eb:	6a 00                	push   $0x0
  1059ed:	68 b6 00 00 00       	push   $0xb6
  1059f2:	e9 73 f4 ff ff       	jmp    104e6a <alltraps>

001059f7 <vector183>:
  1059f7:	6a 00                	push   $0x0
  1059f9:	68 b7 00 00 00       	push   $0xb7
  1059fe:	e9 67 f4 ff ff       	jmp    104e6a <alltraps>

00105a03 <vector184>:
  105a03:	6a 00                	push   $0x0
  105a05:	68 b8 00 00 00       	push   $0xb8
  105a0a:	e9 5b f4 ff ff       	jmp    104e6a <alltraps>

00105a0f <vector185>:
  105a0f:	6a 00                	push   $0x0
  105a11:	68 b9 00 00 00       	push   $0xb9
  105a16:	e9 4f f4 ff ff       	jmp    104e6a <alltraps>

00105a1b <vector186>:
  105a1b:	6a 00                	push   $0x0
  105a1d:	68 ba 00 00 00       	push   $0xba
  105a22:	e9 43 f4 ff ff       	jmp    104e6a <alltraps>

00105a27 <vector187>:
  105a27:	6a 00                	push   $0x0
  105a29:	68 bb 00 00 00       	push   $0xbb
  105a2e:	e9 37 f4 ff ff       	jmp    104e6a <alltraps>

00105a33 <vector188>:
  105a33:	6a 00                	push   $0x0
  105a35:	68 bc 00 00 00       	push   $0xbc
  105a3a:	e9 2b f4 ff ff       	jmp    104e6a <alltraps>

00105a3f <vector189>:
  105a3f:	6a 00                	push   $0x0
  105a41:	68 bd 00 00 00       	push   $0xbd
  105a46:	e9 1f f4 ff ff       	jmp    104e6a <alltraps>

00105a4b <vector190>:
  105a4b:	6a 00                	push   $0x0
  105a4d:	68 be 00 00 00       	push   $0xbe
  105a52:	e9 13 f4 ff ff       	jmp    104e6a <alltraps>

00105a57 <vector191>:
  105a57:	6a 00                	push   $0x0
  105a59:	68 bf 00 00 00       	push   $0xbf
  105a5e:	e9 07 f4 ff ff       	jmp    104e6a <alltraps>

00105a63 <vector192>:
  105a63:	6a 00                	push   $0x0
  105a65:	68 c0 00 00 00       	push   $0xc0
  105a6a:	e9 fb f3 ff ff       	jmp    104e6a <alltraps>

00105a6f <vector193>:
  105a6f:	6a 00                	push   $0x0
  105a71:	68 c1 00 00 00       	push   $0xc1
  105a76:	e9 ef f3 ff ff       	jmp    104e6a <alltraps>

00105a7b <vector194>:
  105a7b:	6a 00                	push   $0x0
  105a7d:	68 c2 00 00 00       	push   $0xc2
  105a82:	e9 e3 f3 ff ff       	jmp    104e6a <alltraps>

00105a87 <vector195>:
  105a87:	6a 00                	push   $0x0
  105a89:	68 c3 00 00 00       	push   $0xc3
  105a8e:	e9 d7 f3 ff ff       	jmp    104e6a <alltraps>

00105a93 <vector196>:
  105a93:	6a 00                	push   $0x0
  105a95:	68 c4 00 00 00       	push   $0xc4
  105a9a:	e9 cb f3 ff ff       	jmp    104e6a <alltraps>

00105a9f <vector197>:
  105a9f:	6a 00                	push   $0x0
  105aa1:	68 c5 00 00 00       	push   $0xc5
  105aa6:	e9 bf f3 ff ff       	jmp    104e6a <alltraps>

00105aab <vector198>:
  105aab:	6a 00                	push   $0x0
  105aad:	68 c6 00 00 00       	push   $0xc6
  105ab2:	e9 b3 f3 ff ff       	jmp    104e6a <alltraps>

00105ab7 <vector199>:
  105ab7:	6a 00                	push   $0x0
  105ab9:	68 c7 00 00 00       	push   $0xc7
  105abe:	e9 a7 f3 ff ff       	jmp    104e6a <alltraps>

00105ac3 <vector200>:
  105ac3:	6a 00                	push   $0x0
  105ac5:	68 c8 00 00 00       	push   $0xc8
  105aca:	e9 9b f3 ff ff       	jmp    104e6a <alltraps>

00105acf <vector201>:
  105acf:	6a 00                	push   $0x0
  105ad1:	68 c9 00 00 00       	push   $0xc9
  105ad6:	e9 8f f3 ff ff       	jmp    104e6a <alltraps>

00105adb <vector202>:
  105adb:	6a 00                	push   $0x0
  105add:	68 ca 00 00 00       	push   $0xca
  105ae2:	e9 83 f3 ff ff       	jmp    104e6a <alltraps>

00105ae7 <vector203>:
  105ae7:	6a 00                	push   $0x0
  105ae9:	68 cb 00 00 00       	push   $0xcb
  105aee:	e9 77 f3 ff ff       	jmp    104e6a <alltraps>

00105af3 <vector204>:
  105af3:	6a 00                	push   $0x0
  105af5:	68 cc 00 00 00       	push   $0xcc
  105afa:	e9 6b f3 ff ff       	jmp    104e6a <alltraps>

00105aff <vector205>:
  105aff:	6a 00                	push   $0x0
  105b01:	68 cd 00 00 00       	push   $0xcd
  105b06:	e9 5f f3 ff ff       	jmp    104e6a <alltraps>

00105b0b <vector206>:
  105b0b:	6a 00                	push   $0x0
  105b0d:	68 ce 00 00 00       	push   $0xce
  105b12:	e9 53 f3 ff ff       	jmp    104e6a <alltraps>

00105b17 <vector207>:
  105b17:	6a 00                	push   $0x0
  105b19:	68 cf 00 00 00       	push   $0xcf
  105b1e:	e9 47 f3 ff ff       	jmp    104e6a <alltraps>

00105b23 <vector208>:
  105b23:	6a 00                	push   $0x0
  105b25:	68 d0 00 00 00       	push   $0xd0
  105b2a:	e9 3b f3 ff ff       	jmp    104e6a <alltraps>

00105b2f <vector209>:
  105b2f:	6a 00                	push   $0x0
  105b31:	68 d1 00 00 00       	push   $0xd1
  105b36:	e9 2f f3 ff ff       	jmp    104e6a <alltraps>

00105b3b <vector210>:
  105b3b:	6a 00                	push   $0x0
  105b3d:	68 d2 00 00 00       	push   $0xd2
  105b42:	e9 23 f3 ff ff       	jmp    104e6a <alltraps>

00105b47 <vector211>:
  105b47:	6a 00                	push   $0x0
  105b49:	68 d3 00 00 00       	push   $0xd3
  105b4e:	e9 17 f3 ff ff       	jmp    104e6a <alltraps>

00105b53 <vector212>:
  105b53:	6a 00                	push   $0x0
  105b55:	68 d4 00 00 00       	push   $0xd4
  105b5a:	e9 0b f3 ff ff       	jmp    104e6a <alltraps>

00105b5f <vector213>:
  105b5f:	6a 00                	push   $0x0
  105b61:	68 d5 00 00 00       	push   $0xd5
  105b66:	e9 ff f2 ff ff       	jmp    104e6a <alltraps>

00105b6b <vector214>:
  105b6b:	6a 00                	push   $0x0
  105b6d:	68 d6 00 00 00       	push   $0xd6
  105b72:	e9 f3 f2 ff ff       	jmp    104e6a <alltraps>

00105b77 <vector215>:
  105b77:	6a 00                	push   $0x0
  105b79:	68 d7 00 00 00       	push   $0xd7
  105b7e:	e9 e7 f2 ff ff       	jmp    104e6a <alltraps>

00105b83 <vector216>:
  105b83:	6a 00                	push   $0x0
  105b85:	68 d8 00 00 00       	push   $0xd8
  105b8a:	e9 db f2 ff ff       	jmp    104e6a <alltraps>

00105b8f <vector217>:
  105b8f:	6a 00                	push   $0x0
  105b91:	68 d9 00 00 00       	push   $0xd9
  105b96:	e9 cf f2 ff ff       	jmp    104e6a <alltraps>

00105b9b <vector218>:
  105b9b:	6a 00                	push   $0x0
  105b9d:	68 da 00 00 00       	push   $0xda
  105ba2:	e9 c3 f2 ff ff       	jmp    104e6a <alltraps>

00105ba7 <vector219>:
  105ba7:	6a 00                	push   $0x0
  105ba9:	68 db 00 00 00       	push   $0xdb
  105bae:	e9 b7 f2 ff ff       	jmp    104e6a <alltraps>

00105bb3 <vector220>:
  105bb3:	6a 00                	push   $0x0
  105bb5:	68 dc 00 00 00       	push   $0xdc
  105bba:	e9 ab f2 ff ff       	jmp    104e6a <alltraps>

00105bbf <vector221>:
  105bbf:	6a 00                	push   $0x0
  105bc1:	68 dd 00 00 00       	push   $0xdd
  105bc6:	e9 9f f2 ff ff       	jmp    104e6a <alltraps>

00105bcb <vector222>:
  105bcb:	6a 00                	push   $0x0
  105bcd:	68 de 00 00 00       	push   $0xde
  105bd2:	e9 93 f2 ff ff       	jmp    104e6a <alltraps>

00105bd7 <vector223>:
  105bd7:	6a 00                	push   $0x0
  105bd9:	68 df 00 00 00       	push   $0xdf
  105bde:	e9 87 f2 ff ff       	jmp    104e6a <alltraps>

00105be3 <vector224>:
  105be3:	6a 00                	push   $0x0
  105be5:	68 e0 00 00 00       	push   $0xe0
  105bea:	e9 7b f2 ff ff       	jmp    104e6a <alltraps>

00105bef <vector225>:
  105bef:	6a 00                	push   $0x0
  105bf1:	68 e1 00 00 00       	push   $0xe1
  105bf6:	e9 6f f2 ff ff       	jmp    104e6a <alltraps>

00105bfb <vector226>:
  105bfb:	6a 00                	push   $0x0
  105bfd:	68 e2 00 00 00       	push   $0xe2
  105c02:	e9 63 f2 ff ff       	jmp    104e6a <alltraps>

00105c07 <vector227>:
  105c07:	6a 00                	push   $0x0
  105c09:	68 e3 00 00 00       	push   $0xe3
  105c0e:	e9 57 f2 ff ff       	jmp    104e6a <alltraps>

00105c13 <vector228>:
  105c13:	6a 00                	push   $0x0
  105c15:	68 e4 00 00 00       	push   $0xe4
  105c1a:	e9 4b f2 ff ff       	jmp    104e6a <alltraps>

00105c1f <vector229>:
  105c1f:	6a 00                	push   $0x0
  105c21:	68 e5 00 00 00       	push   $0xe5
  105c26:	e9 3f f2 ff ff       	jmp    104e6a <alltraps>

00105c2b <vector230>:
  105c2b:	6a 00                	push   $0x0
  105c2d:	68 e6 00 00 00       	push   $0xe6
  105c32:	e9 33 f2 ff ff       	jmp    104e6a <alltraps>

00105c37 <vector231>:
  105c37:	6a 00                	push   $0x0
  105c39:	68 e7 00 00 00       	push   $0xe7
  105c3e:	e9 27 f2 ff ff       	jmp    104e6a <alltraps>

00105c43 <vector232>:
  105c43:	6a 00                	push   $0x0
  105c45:	68 e8 00 00 00       	push   $0xe8
  105c4a:	e9 1b f2 ff ff       	jmp    104e6a <alltraps>

00105c4f <vector233>:
  105c4f:	6a 00                	push   $0x0
  105c51:	68 e9 00 00 00       	push   $0xe9
  105c56:	e9 0f f2 ff ff       	jmp    104e6a <alltraps>

00105c5b <vector234>:
  105c5b:	6a 00                	push   $0x0
  105c5d:	68 ea 00 00 00       	push   $0xea
  105c62:	e9 03 f2 ff ff       	jmp    104e6a <alltraps>

00105c67 <vector235>:
  105c67:	6a 00                	push   $0x0
  105c69:	68 eb 00 00 00       	push   $0xeb
  105c6e:	e9 f7 f1 ff ff       	jmp    104e6a <alltraps>

00105c73 <vector236>:
  105c73:	6a 00                	push   $0x0
  105c75:	68 ec 00 00 00       	push   $0xec
  105c7a:	e9 eb f1 ff ff       	jmp    104e6a <alltraps>

00105c7f <vector237>:
  105c7f:	6a 00                	push   $0x0
  105c81:	68 ed 00 00 00       	push   $0xed
  105c86:	e9 df f1 ff ff       	jmp    104e6a <alltraps>

00105c8b <vector238>:
  105c8b:	6a 00                	push   $0x0
  105c8d:	68 ee 00 00 00       	push   $0xee
  105c92:	e9 d3 f1 ff ff       	jmp    104e6a <alltraps>

00105c97 <vector239>:
  105c97:	6a 00                	push   $0x0
  105c99:	68 ef 00 00 00       	push   $0xef
  105c9e:	e9 c7 f1 ff ff       	jmp    104e6a <alltraps>

00105ca3 <vector240>:
  105ca3:	6a 00                	push   $0x0
  105ca5:	68 f0 00 00 00       	push   $0xf0
  105caa:	e9 bb f1 ff ff       	jmp    104e6a <alltraps>

00105caf <vector241>:
  105caf:	6a 00                	push   $0x0
  105cb1:	68 f1 00 00 00       	push   $0xf1
  105cb6:	e9 af f1 ff ff       	jmp    104e6a <alltraps>

00105cbb <vector242>:
  105cbb:	6a 00                	push   $0x0
  105cbd:	68 f2 00 00 00       	push   $0xf2
  105cc2:	e9 a3 f1 ff ff       	jmp    104e6a <alltraps>

00105cc7 <vector243>:
  105cc7:	6a 00                	push   $0x0
  105cc9:	68 f3 00 00 00       	push   $0xf3
  105cce:	e9 97 f1 ff ff       	jmp    104e6a <alltraps>

00105cd3 <vector244>:
  105cd3:	6a 00                	push   $0x0
  105cd5:	68 f4 00 00 00       	push   $0xf4
  105cda:	e9 8b f1 ff ff       	jmp    104e6a <alltraps>

00105cdf <vector245>:
  105cdf:	6a 00                	push   $0x0
  105ce1:	68 f5 00 00 00       	push   $0xf5
  105ce6:	e9 7f f1 ff ff       	jmp    104e6a <alltraps>

00105ceb <vector246>:
  105ceb:	6a 00                	push   $0x0
  105ced:	68 f6 00 00 00       	push   $0xf6
  105cf2:	e9 73 f1 ff ff       	jmp    104e6a <alltraps>

00105cf7 <vector247>:
  105cf7:	6a 00                	push   $0x0
  105cf9:	68 f7 00 00 00       	push   $0xf7
  105cfe:	e9 67 f1 ff ff       	jmp    104e6a <alltraps>

00105d03 <vector248>:
  105d03:	6a 00                	push   $0x0
  105d05:	68 f8 00 00 00       	push   $0xf8
  105d0a:	e9 5b f1 ff ff       	jmp    104e6a <alltraps>

00105d0f <vector249>:
  105d0f:	6a 00                	push   $0x0
  105d11:	68 f9 00 00 00       	push   $0xf9
  105d16:	e9 4f f1 ff ff       	jmp    104e6a <alltraps>

00105d1b <vector250>:
  105d1b:	6a 00                	push   $0x0
  105d1d:	68 fa 00 00 00       	push   $0xfa
  105d22:	e9 43 f1 ff ff       	jmp    104e6a <alltraps>

00105d27 <vector251>:
  105d27:	6a 00                	push   $0x0
  105d29:	68 fb 00 00 00       	push   $0xfb
  105d2e:	e9 37 f1 ff ff       	jmp    104e6a <alltraps>

00105d33 <vector252>:
  105d33:	6a 00                	push   $0x0
  105d35:	68 fc 00 00 00       	push   $0xfc
  105d3a:	e9 2b f1 ff ff       	jmp    104e6a <alltraps>

00105d3f <vector253>:
  105d3f:	6a 00                	push   $0x0
  105d41:	68 fd 00 00 00       	push   $0xfd
  105d46:	e9 1f f1 ff ff       	jmp    104e6a <alltraps>

00105d4b <vector254>:
  105d4b:	6a 00                	push   $0x0
  105d4d:	68 fe 00 00 00       	push   $0xfe
  105d52:	e9 13 f1 ff ff       	jmp    104e6a <alltraps>

00105d57 <vector255>:
  105d57:	6a 00                	push   $0x0
  105d59:	68 ff 00 00 00       	push   $0xff
  105d5e:	e9 07 f1 ff ff       	jmp    104e6a <alltraps>

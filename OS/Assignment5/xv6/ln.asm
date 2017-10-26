
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  if(argc != 3){
   7:	83 39 03             	cmpl   $0x3,(%ecx)
{
   a:	ff 71 fc             	pushl  -0x4(%ecx)
   d:	55                   	push   %ebp
   e:	89 e5                	mov    %esp,%ebp
  10:	53                   	push   %ebx
  11:	51                   	push   %ecx
  12:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  15:	74 14                	je     2b <main+0x2b>
    printf(2, "Usage: ln old new\n");
  17:	83 ec 08             	sub    $0x8,%esp
  1a:	68 d8 06 00 00       	push   $0x6d8
  1f:	6a 02                	push   $0x2
  21:	e8 9a 03 00 00       	call   3c0 <printf>
    exit();
  26:	e8 56 02 00 00       	call   281 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2b:	50                   	push   %eax
  2c:	50                   	push   %eax
  2d:	ff 73 08             	pushl  0x8(%ebx)
  30:	ff 73 04             	pushl  0x4(%ebx)
  33:	e8 a9 02 00 00       	call   2e1 <link>
  38:	83 c4 10             	add    $0x10,%esp
  3b:	85 c0                	test   %eax,%eax
  3d:	78 05                	js     44 <main+0x44>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3f:	e8 3d 02 00 00       	call   281 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  44:	ff 73 08             	pushl  0x8(%ebx)
  47:	ff 73 04             	pushl  0x4(%ebx)
  4a:	68 eb 06 00 00       	push   $0x6eb
  4f:	6a 02                	push   $0x2
  51:	e8 6a 03 00 00       	call   3c0 <printf>
  56:	83 c4 10             	add    $0x10,%esp
  59:	eb e4                	jmp    3f <main+0x3f>
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	53                   	push   %ebx
  61:	8b 44 24 08          	mov    0x8(%esp),%eax
  65:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  69:	89 c2                	mov    %eax,%edx
  6b:	90                   	nop
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	c3                   	ret    
  83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	56                   	push   %esi
  91:	53                   	push   %ebx
  92:	8b 54 24 0c          	mov    0xc(%esp),%edx
  96:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1f                	jne    c3 <strcmp+0x33>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  b9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  bd:	84 c0                	test   %al,%al
  bf:	74 0f                	je     d0 <strcmp+0x40>
  c1:	89 f1                	mov    %esi,%ecx
  c3:	38 d8                	cmp    %bl,%al
  c5:	74 e9                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c7:	29 d8                	sub    %ebx,%eax
}
  c9:	5b                   	pop    %ebx
  ca:	5e                   	pop    %esi
  cb:	c3                   	ret    
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5e                   	pop    %esi
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e4:	80 39 00             	cmpb   $0x0,(%ecx)
  e7:	74 14                	je     fd <strlen+0x1d>
  e9:	31 d2                	xor    %edx,%edx
  eb:	90                   	nop
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
  fb:	f3 c3                	repz ret 
  fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  ff:	c3                   	ret    

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	57                   	push   %edi
 101:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 105:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 109:	8b 44 24 0c          	mov    0xc(%esp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	c3                   	ret    
 116:	8d 76 00             	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	53                   	push   %ebx
 121:	8b 44 24 08          	mov    0x8(%esp),%eax
 125:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 129:	0f b6 10             	movzbl (%eax),%edx
 12c:	84 d2                	test   %dl,%dl
 12e:	74 1e                	je     14e <strchr+0x2e>
    if(*s == c)
 130:	38 d3                	cmp    %dl,%bl
 132:	89 d9                	mov    %ebx,%ecx
 134:	75 0e                	jne    144 <strchr+0x24>
 136:	eb 18                	jmp    150 <strchr+0x30>
 138:	90                   	nop
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0c                	je     150 <strchr+0x30>
  for(; *s; s++)
 144:	83 c0 01             	add    $0x1,%eax
 147:	0f b6 10             	movzbl (%eax),%edx
 14a:	84 d2                	test   %dl,%dl
 14c:	75 f2                	jne    140 <strchr+0x20>
      return (char*) s;
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	c3                   	ret    
 152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 162:	31 ff                	xor    %edi,%edi
{
 164:	56                   	push   %esi
 165:	53                   	push   %ebx
 166:	83 ec 1c             	sub    $0x1c,%esp
 169:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
 16d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
 171:	eb 2c                	jmp    19f <gets+0x3f>
 173:	90                   	nop
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 178:	83 ec 04             	sub    $0x4,%esp
 17b:	6a 01                	push   $0x1
 17d:	55                   	push   %ebp
 17e:	6a 00                	push   $0x0
 180:	e8 14 01 00 00       	call   299 <read>
    if(cc < 1)
 185:	83 c4 10             	add    $0x10,%esp
 188:	85 c0                	test   %eax,%eax
 18a:	7e 1c                	jle    1a8 <gets+0x48>
      break;
    buf[i++] = c;
 18c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 191:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 193:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 195:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 199:	74 25                	je     1c0 <gets+0x60>
 19b:	3c 0d                	cmp    $0xd,%al
 19d:	74 21                	je     1c0 <gets+0x60>
  for(i=0; i+1 < max; ){
 19f:	8d 5f 01             	lea    0x1(%edi),%ebx
 1a2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 1a6:	7c d0                	jl     178 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 1a8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 1ac:	83 c4 1c             	add    $0x1c,%esp
 1af:	89 f0                	mov    %esi,%eax
 1b1:	5b                   	pop    %ebx
 1b2:	5e                   	pop    %esi
 1b3:	5f                   	pop    %edi
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	8d 76 00             	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
 1c0:	89 df                	mov    %ebx,%edi
}
 1c2:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
 1c4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
 1c8:	83 c4 1c             	add    $0x1c,%esp
 1cb:	5b                   	pop    %ebx
 1cc:	5e                   	pop    %esi
 1cd:	5f                   	pop    %edi
 1ce:	5d                   	pop    %ebp
 1cf:	c3                   	ret    

000001d0 <stat>:

int
stat(char *n, struct stat_new *st)
{
 1d0:	56                   	push   %esi
 1d1:	53                   	push   %ebx
 1d2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d5:	6a 00                	push   $0x0
 1d7:	ff 74 24 1c          	pushl  0x1c(%esp)
 1db:	e8 e1 00 00 00       	call   2c1 <open>
  if(fd < 0)
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	85 c0                	test   %eax,%eax
 1e5:	78 29                	js     210 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1e7:	83 ec 08             	sub    $0x8,%esp
 1ea:	89 c3                	mov    %eax,%ebx
 1ec:	ff 74 24 1c          	pushl  0x1c(%esp)
 1f0:	50                   	push   %eax
 1f1:	e8 e3 00 00 00       	call   2d9 <fstat>
  close(fd);
 1f6:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1f9:	89 c6                	mov    %eax,%esi
  close(fd);
 1fb:	e8 a9 00 00 00       	call   2a9 <close>
  return r;
 200:	83 c4 10             	add    $0x10,%esp
}
 203:	83 c4 04             	add    $0x4,%esp
 206:	89 f0                	mov    %esi,%eax
 208:	5b                   	pop    %ebx
 209:	5e                   	pop    %esi
 20a:	c3                   	ret    
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb ec                	jmp    203 <stat+0x33>
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	53                   	push   %ebx
 221:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 225:	0f be 11             	movsbl (%ecx),%edx
 228:	8d 42 d0             	lea    -0x30(%edx),%eax
 22b:	3c 09                	cmp    $0x9,%al
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
 232:	77 19                	ja     24d <atoi+0x2d>
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 238:	8d 04 80             	lea    (%eax,%eax,4),%eax
 23b:	83 c1 01             	add    $0x1,%ecx
 23e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 242:	0f be 11             	movsbl (%ecx),%edx
 245:	8d 5a d0             	lea    -0x30(%edx),%ebx
 248:	80 fb 09             	cmp    $0x9,%bl
 24b:	76 eb                	jbe    238 <atoi+0x18>
  return n;
}
 24d:	5b                   	pop    %ebx
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 250:	56                   	push   %esi
 251:	53                   	push   %ebx
 252:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 256:	8b 44 24 0c          	mov    0xc(%esp),%eax
 25a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 da                	cmp    %ebx,%edx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	c3                   	ret    

00000279 <fork>:
 279:	b8 01 00 00 00       	mov    $0x1,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <exit>:
 281:	b8 02 00 00 00       	mov    $0x2,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <wait>:
 289:	b8 03 00 00 00       	mov    $0x3,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <pipe>:
 291:	b8 04 00 00 00       	mov    $0x4,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <read>:
 299:	b8 06 00 00 00       	mov    $0x6,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <write>:
 2a1:	b8 05 00 00 00       	mov    $0x5,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <close>:
 2a9:	b8 07 00 00 00       	mov    $0x7,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <kill>:
 2b1:	b8 08 00 00 00       	mov    $0x8,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <exec>:
 2b9:	b8 09 00 00 00       	mov    $0x9,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <open>:
 2c1:	b8 0a 00 00 00       	mov    $0xa,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <mknod>:
 2c9:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <unlink>:
 2d1:	b8 0c 00 00 00       	mov    $0xc,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <fstat>:
 2d9:	b8 0d 00 00 00       	mov    $0xd,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <link>:
 2e1:	b8 0e 00 00 00       	mov    $0xe,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mkdir>:
 2e9:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <chdir>:
 2f1:	b8 10 00 00 00       	mov    $0x10,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <dup>:
 2f9:	b8 11 00 00 00       	mov    $0x11,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <getpid>:
 301:	b8 12 00 00 00       	mov    $0x12,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <sbrk>:
 309:	b8 13 00 00 00       	mov    $0x13,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <sleep>:
 311:	b8 14 00 00 00       	mov    $0x14,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    
 319:	66 90                	xchg   %ax,%ax
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 320:	55                   	push   %ebp
 321:	57                   	push   %edi
 322:	89 c7                	mov    %eax,%edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 329:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 32d:	85 db                	test   %ebx,%ebx
 32f:	74 7f                	je     3b0 <printint+0x90>
 331:	89 d0                	mov    %edx,%eax
 333:	c1 e8 1f             	shr    $0x1f,%eax
 336:	84 c0                	test   %al,%al
 338:	74 76                	je     3b0 <printint+0x90>
    neg = 1;
    x = -xx;
 33a:	89 d0                	mov    %edx,%eax
    neg = 1;
 33c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 343:	00 
    x = -xx;
 344:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 346:	31 ed                	xor    %ebp,%ebp
 348:	8d 74 24 1f          	lea    0x1f(%esp),%esi
 34c:	eb 04                	jmp    352 <printint+0x32>
 34e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 350:	89 dd                	mov    %ebx,%ebp
 352:	31 d2                	xor    %edx,%edx
 354:	8d 5d 01             	lea    0x1(%ebp),%ebx
 357:	f7 f1                	div    %ecx
 359:	0f b6 92 08 07 00 00 	movzbl 0x708(%edx),%edx
  }while((x /= base) != 0);
 360:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 362:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 365:	75 e9                	jne    350 <printint+0x30>
  if(neg)
 367:	8b 44 24 0c          	mov    0xc(%esp),%eax
 36b:	85 c0                	test   %eax,%eax
 36d:	74 08                	je     377 <printint+0x57>
    buf[i++] = '-';
 36f:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
 374:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
 377:	83 eb 01             	sub    $0x1,%ebx
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 380:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
 385:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 388:	83 eb 01             	sub    $0x1,%ebx
 38b:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
 38f:	6a 01                	push   $0x1
 391:	56                   	push   %esi
 392:	57                   	push   %edi
 393:	e8 09 ff ff ff       	call   2a1 <write>
  while(--i >= 0)
 398:	83 c4 10             	add    $0x10,%esp
 39b:	83 fb ff             	cmp    $0xffffffff,%ebx
 39e:	75 e0                	jne    380 <printint+0x60>
    putc(fd, buf[i]);
}
 3a0:	83 c4 3c             	add    $0x3c,%esp
 3a3:	5b                   	pop    %ebx
 3a4:	5e                   	pop    %esi
 3a5:	5f                   	pop    %edi
 3a6:	5d                   	pop    %ebp
 3a7:	c3                   	ret    
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
 3b0:	89 d0                	mov    %edx,%eax
  neg = 0;
 3b2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 3b9:	00 
 3ba:	eb 8a                	jmp    346 <printint+0x26>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	57                   	push   %edi
 3c2:	56                   	push   %esi
 3c3:	53                   	push   %ebx
 3c4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c7:	8b 74 24 44          	mov    0x44(%esp),%esi
 3cb:	8d 44 24 48          	lea    0x48(%esp),%eax
{
 3cf:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
 3d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3d7:	0f b6 1e             	movzbl (%esi),%ebx
 3da:	83 c6 01             	add    $0x1,%esi
 3dd:	84 db                	test   %bl,%bl
 3df:	0f 84 ad 00 00 00    	je     492 <printf+0xd2>
 3e5:	31 ed                	xor    %ebp,%ebp
 3e7:	eb 32                	jmp    41b <printf+0x5b>
 3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	0f 84 a7 00 00 00    	je     4a0 <printf+0xe0>
 3f9:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
 3fd:	83 ec 04             	sub    $0x4,%esp
 400:	6a 01                	push   $0x1
 402:	8d 44 24 22          	lea    0x22(%esp),%eax
 406:	50                   	push   %eax
 407:	57                   	push   %edi
 408:	e8 94 fe ff ff       	call   2a1 <write>
 40d:	83 c4 10             	add    $0x10,%esp
 410:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 413:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 417:	84 db                	test   %bl,%bl
 419:	74 77                	je     492 <printf+0xd2>
    if(state == 0){
 41b:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
 41d:	0f be cb             	movsbl %bl,%ecx
 420:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 423:	74 cb                	je     3f0 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 425:	83 fd 25             	cmp    $0x25,%ebp
 428:	75 e6                	jne    410 <printf+0x50>
      if(c == 'd'){
 42a:	83 f8 64             	cmp    $0x64,%eax
 42d:	0f 84 0d 01 00 00    	je     540 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 433:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 439:	83 f9 70             	cmp    $0x70,%ecx
 43c:	74 72                	je     4b0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 43e:	83 f8 73             	cmp    $0x73,%eax
 441:	0f 84 99 00 00 00    	je     4e0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 447:	83 f8 63             	cmp    $0x63,%eax
 44a:	0f 84 ff 00 00 00    	je     54f <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 450:	83 f8 25             	cmp    $0x25,%eax
 453:	0f 84 cf 00 00 00    	je     528 <printf+0x168>
 459:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
 45e:	83 ec 04             	sub    $0x4,%esp
 461:	6a 01                	push   $0x1
 463:	8d 44 24 27          	lea    0x27(%esp),%eax
 467:	50                   	push   %eax
 468:	57                   	push   %edi
 469:	e8 33 fe ff ff       	call   2a1 <write>
 46e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 472:	83 c4 0c             	add    $0xc,%esp
 475:	6a 01                	push   $0x1
 477:	8d 44 24 26          	lea    0x26(%esp),%eax
 47b:	50                   	push   %eax
 47c:	57                   	push   %edi
 47d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 480:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
 482:	e8 1a fe ff ff       	call   2a1 <write>
  for(i = 0; fmt[i]; i++){
 487:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 48b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 48e:	84 db                	test   %bl,%bl
 490:	75 89                	jne    41b <printf+0x5b>
    }
  }
}
 492:	83 c4 2c             	add    $0x2c,%esp
 495:	5b                   	pop    %ebx
 496:	5e                   	pop    %esi
 497:	5f                   	pop    %edi
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4a0:	bd 25 00 00 00       	mov    $0x25,%ebp
 4a5:	e9 66 ff ff ff       	jmp    410 <printf+0x50>
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4b0:	83 ec 0c             	sub    $0xc,%esp
 4b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4b8:	6a 00                	push   $0x0
 4ba:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 4be:	89 f8                	mov    %edi,%eax
 4c0:	8b 13                	mov    (%ebx),%edx
 4c2:	e8 59 fe ff ff       	call   320 <printint>
        ap++;
 4c7:	89 d8                	mov    %ebx,%eax
      state = 0;
 4c9:	31 ed                	xor    %ebp,%ebp
        ap++;
 4cb:	83 c0 04             	add    $0x4,%eax
 4ce:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	e9 36 ff ff ff       	jmp    410 <printf+0x50>
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 4e0:	8b 44 24 0c          	mov    0xc(%esp),%eax
 4e4:	8b 28                	mov    (%eax),%ebp
        ap++;
 4e6:	83 c0 04             	add    $0x4,%eax
 4e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
 4ed:	85 ed                	test   %ebp,%ebp
 4ef:	74 7d                	je     56e <printf+0x1ae>
        while(*s != 0){
 4f1:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 4f5:	84 c0                	test   %al,%al
 4f7:	74 25                	je     51e <printf+0x15e>
 4f9:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
 504:	83 ec 04             	sub    $0x4,%esp
          s++;
 507:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
 50a:	6a 01                	push   $0x1
 50c:	53                   	push   %ebx
 50d:	57                   	push   %edi
 50e:	e8 8e fd ff ff       	call   2a1 <write>
        while(*s != 0){
 513:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 517:	83 c4 10             	add    $0x10,%esp
 51a:	84 c0                	test   %al,%al
 51c:	75 e2                	jne    500 <printf+0x140>
      state = 0;
 51e:	31 ed                	xor    %ebp,%ebp
 520:	e9 eb fe ff ff       	jmp    410 <printf+0x50>
 525:	8d 76 00             	lea    0x0(%esi),%esi
 528:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
 52c:	83 ec 04             	sub    $0x4,%esp
 52f:	6a 01                	push   $0x1
 531:	8d 44 24 25          	lea    0x25(%esp),%eax
 535:	e9 41 ff ff ff       	jmp    47b <printf+0xbb>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	b9 0a 00 00 00       	mov    $0xa,%ecx
 548:	6a 01                	push   $0x1
 54a:	e9 6b ff ff ff       	jmp    4ba <printf+0xfa>
        putc(fd, *ap);
 54f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
 553:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 556:	8b 03                	mov    (%ebx),%eax
 558:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
 55c:	6a 01                	push   $0x1
 55e:	8d 44 24 24          	lea    0x24(%esp),%eax
 562:	50                   	push   %eax
 563:	57                   	push   %edi
 564:	e8 38 fd ff ff       	call   2a1 <write>
 569:	e9 59 ff ff ff       	jmp    4c7 <printf+0x107>
        while(*s != 0){
 56e:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 573:	bd ff 06 00 00       	mov    $0x6ff,%ebp
 578:	e9 7c ff ff ff       	jmp    4f9 <printf+0x139>
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 580:	57                   	push   %edi
 581:	56                   	push   %esi
 582:	53                   	push   %ebx
 583:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 587:	a1 4c 0a 00 00       	mov    0xa4c,%eax
  bp = (Header*) ap - 1;
 58c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58f:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	39 c8                	cmp    %ecx,%eax
 593:	73 13                	jae    5a8 <free+0x28>
 595:	8d 76 00             	lea    0x0(%esi),%esi
 598:	39 d1                	cmp    %edx,%ecx
 59a:	72 14                	jb     5b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59c:	39 d0                	cmp    %edx,%eax
 59e:	73 10                	jae    5b0 <free+0x30>
{
 5a0:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a4:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a6:	72 f0                	jb     598 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a8:	39 d0                	cmp    %edx,%eax
 5aa:	72 f4                	jb     5a0 <free+0x20>
 5ac:	39 d1                	cmp    %edx,%ecx
 5ae:	73 f0                	jae    5a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5b6:	39 fa                	cmp    %edi,%edx
 5b8:	74 18                	je     5d2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5bd:	8b 50 04             	mov    0x4(%eax),%edx
 5c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c3:	39 f1                	cmp    %esi,%ecx
 5c5:	74 22                	je     5e9 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5c9:	a3 4c 0a 00 00       	mov    %eax,0xa4c
}
 5ce:	5b                   	pop    %ebx
 5cf:	5e                   	pop    %esi
 5d0:	5f                   	pop    %edi
 5d1:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5d2:	03 72 04             	add    0x4(%edx),%esi
 5d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d8:	8b 10                	mov    (%eax),%edx
 5da:	8b 12                	mov    (%edx),%edx
 5dc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5df:	8b 50 04             	mov    0x4(%eax),%edx
 5e2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e5:	39 f1                	cmp    %esi,%ecx
 5e7:	75 de                	jne    5c7 <free+0x47>
    p->s.size += bp->s.size;
 5e9:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 5ec:	a3 4c 0a 00 00       	mov    %eax,0xa4c
    p->s.size += bp->s.size;
 5f1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5f4:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5f7:	89 10                	mov    %edx,(%eax)
}
 5f9:	5b                   	pop    %ebx
 5fa:	5e                   	pop    %esi
 5fb:	5f                   	pop    %edi
 5fc:	c3                   	ret    
 5fd:	8d 76 00             	lea    0x0(%esi),%esi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	57                   	push   %edi
 601:	56                   	push   %esi
 602:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 603:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 607:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 60d:	8d 78 07             	lea    0x7(%eax),%edi
 610:	c1 ef 03             	shr    $0x3,%edi
 613:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 616:	85 d2                	test   %edx,%edx
 618:	0f 84 90 00 00 00    	je     6ae <malloc+0xae>
 61e:	8b 02                	mov    (%edx),%eax
 620:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 623:	39 cf                	cmp    %ecx,%edi
 625:	76 61                	jbe    688 <malloc+0x88>
 627:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 62d:	bb 00 10 00 00       	mov    $0x1000,%ebx
 632:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 635:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 63c:	eb 0b                	jmp    649 <malloc+0x49>
 63e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 640:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 642:	8b 48 04             	mov    0x4(%eax),%ecx
 645:	39 cf                	cmp    %ecx,%edi
 647:	76 3f                	jbe    688 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 649:	39 05 4c 0a 00 00    	cmp    %eax,0xa4c
 64f:	89 c2                	mov    %eax,%edx
 651:	75 ed                	jne    640 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 653:	83 ec 0c             	sub    $0xc,%esp
 656:	56                   	push   %esi
 657:	e8 ad fc ff ff       	call   309 <sbrk>
  if(p == (char*) -1)
 65c:	83 c4 10             	add    $0x10,%esp
 65f:	83 f8 ff             	cmp    $0xffffffff,%eax
 662:	74 1c                	je     680 <malloc+0x80>
  hp->s.size = nu;
 664:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 667:	83 ec 0c             	sub    $0xc,%esp
 66a:	83 c0 08             	add    $0x8,%eax
 66d:	50                   	push   %eax
 66e:	e8 0d ff ff ff       	call   580 <free>
  return freep;
 673:	8b 15 4c 0a 00 00    	mov    0xa4c,%edx
      if((p = morecore(nunits)) == 0)
 679:	83 c4 10             	add    $0x10,%esp
 67c:	85 d2                	test   %edx,%edx
 67e:	75 c0                	jne    640 <malloc+0x40>
        return 0;
 680:	31 c0                	xor    %eax,%eax
 682:	eb 1c                	jmp    6a0 <malloc+0xa0>
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 688:	39 cf                	cmp    %ecx,%edi
 68a:	74 1c                	je     6a8 <malloc+0xa8>
        p->s.size -= nunits;
 68c:	29 f9                	sub    %edi,%ecx
 68e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 691:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 694:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 697:	89 15 4c 0a 00 00    	mov    %edx,0xa4c
      return (void*) (p + 1);
 69d:	83 c0 08             	add    $0x8,%eax
  }
}
 6a0:	5b                   	pop    %ebx
 6a1:	5e                   	pop    %esi
 6a2:	5f                   	pop    %edi
 6a3:	c3                   	ret    
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 6a8:	8b 08                	mov    (%eax),%ecx
 6aa:	89 0a                	mov    %ecx,(%edx)
 6ac:	eb e9                	jmp    697 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
 6ae:	c7 05 4c 0a 00 00 50 	movl   $0xa50,0xa4c
 6b5:	0a 00 00 
 6b8:	c7 05 50 0a 00 00 50 	movl   $0xa50,0xa50
 6bf:	0a 00 00 
    base.s.size = 0;
 6c2:	b8 50 0a 00 00       	mov    $0xa50,%eax
 6c7:	c7 05 54 0a 00 00 00 	movl   $0x0,0xa54
 6ce:	00 00 00 
 6d1:	e9 51 ff ff ff       	jmp    627 <malloc+0x27>

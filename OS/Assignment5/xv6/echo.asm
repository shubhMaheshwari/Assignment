
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 41                	jle    5f <main+0x5f>
  1e:	bb 01 00 00 00       	mov    $0x1,%ebx
  23:	eb 1b                	jmp    40 <main+0x40>
  25:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  28:	68 e8 06 00 00       	push   $0x6e8
  2d:	ff 74 9f fc          	pushl  -0x4(%edi,%ebx,4)
  31:	68 ea 06 00 00       	push   $0x6ea
  36:	6a 01                	push   $0x1
  38:	e8 93 03 00 00       	call   3d0 <printf>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	83 c3 01             	add    $0x1,%ebx
  43:	39 de                	cmp    %ebx,%esi
  45:	75 e1                	jne    28 <main+0x28>
  47:	68 ef 06 00 00       	push   $0x6ef
  4c:	ff 74 b7 fc          	pushl  -0x4(%edi,%esi,4)
  50:	68 ea 06 00 00       	push   $0x6ea
  55:	6a 01                	push   $0x1
  57:	e8 74 03 00 00       	call   3d0 <printf>
  5c:	83 c4 10             	add    $0x10,%esp
  exit();
  5f:	e8 2d 02 00 00       	call   291 <exit>
  64:	66 90                	xchg   %ax,%ax
  66:	66 90                	xchg   %ax,%ax
  68:	66 90                	xchg   %ax,%ax
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  70:	53                   	push   %ebx
  71:	8b 44 24 08          	mov    0x8(%esp),%eax
  75:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  79:	89 c2                	mov    %eax,%edx
  7b:	90                   	nop
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  91:	5b                   	pop    %ebx
  92:	c3                   	ret    
  93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	56                   	push   %esi
  a1:	53                   	push   %ebx
  a2:	8b 54 24 0c          	mov    0xc(%esp),%edx
  a6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	0f b6 19             	movzbl (%ecx),%ebx
  b0:	84 c0                	test   %al,%al
  b2:	75 1f                	jne    d3 <strcmp+0x33>
  b4:	eb 2a                	jmp    e0 <strcmp+0x40>
  b6:	8d 76 00             	lea    0x0(%esi),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  c6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
  c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  cd:	84 c0                	test   %al,%al
  cf:	74 0f                	je     e0 <strcmp+0x40>
  d1:	89 f1                	mov    %esi,%ecx
  d3:	38 d8                	cmp    %bl,%al
  d5:	74 e9                	je     c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  d7:	29 d8                	sub    %ebx,%eax
}
  d9:	5b                   	pop    %ebx
  da:	5e                   	pop    %esi
  db:	c3                   	ret    
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
  e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e2:	29 d8                	sub    %ebx,%eax
}
  e4:	5b                   	pop    %ebx
  e5:	5e                   	pop    %esi
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strlen>:

uint
strlen(char *s)
{
  f0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f4:	80 39 00             	cmpb   $0x0,(%ecx)
  f7:	74 14                	je     10d <strlen+0x1d>
  f9:	31 d2                	xor    %edx,%edx
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
 10b:	f3 c3                	repz ret 
 10d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 10f:	c3                   	ret    

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	57                   	push   %edi
 111:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 115:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 119:	8b 44 24 0c          	mov    0xc(%esp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	c3                   	ret    
 126:	8d 76 00             	lea    0x0(%esi),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	53                   	push   %ebx
 131:	8b 44 24 08          	mov    0x8(%esp),%eax
 135:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 139:	0f b6 10             	movzbl (%eax),%edx
 13c:	84 d2                	test   %dl,%dl
 13e:	74 1e                	je     15e <strchr+0x2e>
    if(*s == c)
 140:	38 d3                	cmp    %dl,%bl
 142:	89 d9                	mov    %ebx,%ecx
 144:	75 0e                	jne    154 <strchr+0x24>
 146:	eb 18                	jmp    160 <strchr+0x30>
 148:	90                   	nop
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*) s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	c3                   	ret    
 162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 172:	31 ff                	xor    %edi,%edi
{
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
 176:	83 ec 1c             	sub    $0x1c,%esp
 179:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
 17d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
 181:	eb 2c                	jmp    1af <gets+0x3f>
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 188:	83 ec 04             	sub    $0x4,%esp
 18b:	6a 01                	push   $0x1
 18d:	55                   	push   %ebp
 18e:	6a 00                	push   $0x0
 190:	e8 14 01 00 00       	call   2a9 <read>
    if(cc < 1)
 195:	83 c4 10             	add    $0x10,%esp
 198:	85 c0                	test   %eax,%eax
 19a:	7e 1c                	jle    1b8 <gets+0x48>
      break;
    buf[i++] = c;
 19c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 1a1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 1a3:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 1a5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 1a9:	74 25                	je     1d0 <gets+0x60>
 1ab:	3c 0d                	cmp    $0xd,%al
 1ad:	74 21                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1af:	8d 5f 01             	lea    0x1(%edi),%ebx
 1b2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 1b6:	7c d0                	jl     188 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 1b8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 1bc:	83 c4 1c             	add    $0x1c,%esp
 1bf:	89 f0                	mov    %esi,%eax
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
 1d0:	89 df                	mov    %ebx,%edi
}
 1d2:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
 1d4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
 1d8:	83 c4 1c             	add    $0x1c,%esp
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5f                   	pop    %edi
 1de:	5d                   	pop    %ebp
 1df:	c3                   	ret    

000001e0 <stat>:

int
stat(char *n, struct stat_new *st)
{
 1e0:	56                   	push   %esi
 1e1:	53                   	push   %ebx
 1e2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	6a 00                	push   $0x0
 1e7:	ff 74 24 1c          	pushl  0x1c(%esp)
 1eb:	e8 e1 00 00 00       	call   2d1 <open>
  if(fd < 0)
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	85 c0                	test   %eax,%eax
 1f5:	78 29                	js     220 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1f7:	83 ec 08             	sub    $0x8,%esp
 1fa:	89 c3                	mov    %eax,%ebx
 1fc:	ff 74 24 1c          	pushl  0x1c(%esp)
 200:	50                   	push   %eax
 201:	e8 e3 00 00 00       	call   2e9 <fstat>
  close(fd);
 206:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 209:	89 c6                	mov    %eax,%esi
  close(fd);
 20b:	e8 a9 00 00 00       	call   2b9 <close>
  return r;
 210:	83 c4 10             	add    $0x10,%esp
}
 213:	83 c4 04             	add    $0x4,%esp
 216:	89 f0                	mov    %esi,%eax
 218:	5b                   	pop    %ebx
 219:	5e                   	pop    %esi
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb ec                	jmp    213 <stat+0x33>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	53                   	push   %ebx
 231:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 235:	0f be 11             	movsbl (%ecx),%edx
 238:	8d 42 d0             	lea    -0x30(%edx),%eax
 23b:	3c 09                	cmp    $0x9,%al
 23d:	b8 00 00 00 00       	mov    $0x0,%eax
 242:	77 19                	ja     25d <atoi+0x2d>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 248:	8d 04 80             	lea    (%eax,%eax,4),%eax
 24b:	83 c1 01             	add    $0x1,%ecx
 24e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 252:	0f be 11             	movsbl (%ecx),%edx
 255:	8d 5a d0             	lea    -0x30(%edx),%ebx
 258:	80 fb 09             	cmp    $0x9,%bl
 25b:	76 eb                	jbe    248 <atoi+0x18>
  return n;
}
 25d:	5b                   	pop    %ebx
 25e:	c3                   	ret    
 25f:	90                   	nop

00000260 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 260:	56                   	push   %esi
 261:	53                   	push   %ebx
 262:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 266:	8b 44 24 0c          	mov    0xc(%esp),%eax
 26a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 db                	test   %ebx,%ebx
 270:	7e 14                	jle    286 <memmove+0x26>
 272:	31 d2                	xor    %edx,%edx
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 282:	39 da                	cmp    %ebx,%edx
 284:	75 f2                	jne    278 <memmove+0x18>
  return vdst;
}
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	c3                   	ret    

00000289 <fork>:
 289:	b8 01 00 00 00       	mov    $0x1,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <exit>:
 291:	b8 02 00 00 00       	mov    $0x2,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <wait>:
 299:	b8 03 00 00 00       	mov    $0x3,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <pipe>:
 2a1:	b8 04 00 00 00       	mov    $0x4,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <read>:
 2a9:	b8 06 00 00 00       	mov    $0x6,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <write>:
 2b1:	b8 05 00 00 00       	mov    $0x5,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <close>:
 2b9:	b8 07 00 00 00       	mov    $0x7,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <kill>:
 2c1:	b8 08 00 00 00       	mov    $0x8,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <exec>:
 2c9:	b8 09 00 00 00       	mov    $0x9,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <open>:
 2d1:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <mknod>:
 2d9:	b8 0b 00 00 00       	mov    $0xb,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <unlink>:
 2e1:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <fstat>:
 2e9:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <link>:
 2f1:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <mkdir>:
 2f9:	b8 0f 00 00 00       	mov    $0xf,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <chdir>:
 301:	b8 10 00 00 00       	mov    $0x10,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <dup>:
 309:	b8 11 00 00 00       	mov    $0x11,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <getpid>:
 311:	b8 12 00 00 00       	mov    $0x12,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <sbrk>:
 319:	b8 13 00 00 00       	mov    $0x13,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <sleep>:
 321:	b8 14 00 00 00       	mov    $0x14,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    
 329:	66 90                	xchg   %ax,%ax
 32b:	66 90                	xchg   %ax,%ax
 32d:	66 90                	xchg   %ax,%ax
 32f:	90                   	nop

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	57                   	push   %edi
 332:	89 c7                	mov    %eax,%edi
 334:	56                   	push   %esi
 335:	53                   	push   %ebx
 336:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 339:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 33d:	85 db                	test   %ebx,%ebx
 33f:	74 7f                	je     3c0 <printint+0x90>
 341:	89 d0                	mov    %edx,%eax
 343:	c1 e8 1f             	shr    $0x1f,%eax
 346:	84 c0                	test   %al,%al
 348:	74 76                	je     3c0 <printint+0x90>
    neg = 1;
    x = -xx;
 34a:	89 d0                	mov    %edx,%eax
    neg = 1;
 34c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 353:	00 
    x = -xx;
 354:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 356:	31 ed                	xor    %ebp,%ebp
 358:	8d 74 24 1f          	lea    0x1f(%esp),%esi
 35c:	eb 04                	jmp    362 <printint+0x32>
 35e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 360:	89 dd                	mov    %ebx,%ebp
 362:	31 d2                	xor    %edx,%edx
 364:	8d 5d 01             	lea    0x1(%ebp),%ebx
 367:	f7 f1                	div    %ecx
 369:	0f b6 92 f8 06 00 00 	movzbl 0x6f8(%edx),%edx
  }while((x /= base) != 0);
 370:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 372:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 375:	75 e9                	jne    360 <printint+0x30>
  if(neg)
 377:	8b 44 24 0c          	mov    0xc(%esp),%eax
 37b:	85 c0                	test   %eax,%eax
 37d:	74 08                	je     387 <printint+0x57>
    buf[i++] = '-';
 37f:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
 384:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
 387:	83 eb 01             	sub    $0x1,%ebx
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 390:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
 395:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 398:	83 eb 01             	sub    $0x1,%ebx
 39b:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
 39f:	6a 01                	push   $0x1
 3a1:	56                   	push   %esi
 3a2:	57                   	push   %edi
 3a3:	e8 09 ff ff ff       	call   2b1 <write>
  while(--i >= 0)
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	83 fb ff             	cmp    $0xffffffff,%ebx
 3ae:	75 e0                	jne    390 <printint+0x60>
    putc(fd, buf[i]);
}
 3b0:	83 c4 3c             	add    $0x3c,%esp
 3b3:	5b                   	pop    %ebx
 3b4:	5e                   	pop    %esi
 3b5:	5f                   	pop    %edi
 3b6:	5d                   	pop    %ebp
 3b7:	c3                   	ret    
 3b8:	90                   	nop
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
 3c0:	89 d0                	mov    %edx,%eax
  neg = 0;
 3c2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 3c9:	00 
 3ca:	eb 8a                	jmp    356 <printint+0x26>
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	57                   	push   %edi
 3d2:	56                   	push   %esi
 3d3:	53                   	push   %ebx
 3d4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d7:	8b 74 24 44          	mov    0x44(%esp),%esi
 3db:	8d 44 24 48          	lea    0x48(%esp),%eax
{
 3df:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
 3e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3e7:	0f b6 1e             	movzbl (%esi),%ebx
 3ea:	83 c6 01             	add    $0x1,%esi
 3ed:	84 db                	test   %bl,%bl
 3ef:	0f 84 ad 00 00 00    	je     4a2 <printf+0xd2>
 3f5:	31 ed                	xor    %ebp,%ebp
 3f7:	eb 32                	jmp    42b <printf+0x5b>
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 400:	83 f8 25             	cmp    $0x25,%eax
 403:	0f 84 a7 00 00 00    	je     4b0 <printf+0xe0>
 409:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
 40d:	83 ec 04             	sub    $0x4,%esp
 410:	6a 01                	push   $0x1
 412:	8d 44 24 22          	lea    0x22(%esp),%eax
 416:	50                   	push   %eax
 417:	57                   	push   %edi
 418:	e8 94 fe ff ff       	call   2b1 <write>
 41d:	83 c4 10             	add    $0x10,%esp
 420:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 423:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 427:	84 db                	test   %bl,%bl
 429:	74 77                	je     4a2 <printf+0xd2>
    if(state == 0){
 42b:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
 42d:	0f be cb             	movsbl %bl,%ecx
 430:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 433:	74 cb                	je     400 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 435:	83 fd 25             	cmp    $0x25,%ebp
 438:	75 e6                	jne    420 <printf+0x50>
      if(c == 'd'){
 43a:	83 f8 64             	cmp    $0x64,%eax
 43d:	0f 84 0d 01 00 00    	je     550 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 443:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 449:	83 f9 70             	cmp    $0x70,%ecx
 44c:	74 72                	je     4c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44e:	83 f8 73             	cmp    $0x73,%eax
 451:	0f 84 99 00 00 00    	je     4f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 457:	83 f8 63             	cmp    $0x63,%eax
 45a:	0f 84 ff 00 00 00    	je     55f <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 460:	83 f8 25             	cmp    $0x25,%eax
 463:	0f 84 cf 00 00 00    	je     538 <printf+0x168>
 469:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
 46e:	83 ec 04             	sub    $0x4,%esp
 471:	6a 01                	push   $0x1
 473:	8d 44 24 27          	lea    0x27(%esp),%eax
 477:	50                   	push   %eax
 478:	57                   	push   %edi
 479:	e8 33 fe ff ff       	call   2b1 <write>
 47e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 482:	83 c4 0c             	add    $0xc,%esp
 485:	6a 01                	push   $0x1
 487:	8d 44 24 26          	lea    0x26(%esp),%eax
 48b:	50                   	push   %eax
 48c:	57                   	push   %edi
 48d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 490:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
 492:	e8 1a fe ff ff       	call   2b1 <write>
  for(i = 0; fmt[i]; i++){
 497:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 49b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 49e:	84 db                	test   %bl,%bl
 4a0:	75 89                	jne    42b <printf+0x5b>
    }
  }
}
 4a2:	83 c4 2c             	add    $0x2c,%esp
 4a5:	5b                   	pop    %ebx
 4a6:	5e                   	pop    %esi
 4a7:	5f                   	pop    %edi
 4a8:	5d                   	pop    %ebp
 4a9:	c3                   	ret    
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4b0:	bd 25 00 00 00       	mov    $0x25,%ebp
 4b5:	e9 66 ff ff ff       	jmp    420 <printf+0x50>
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4c8:	6a 00                	push   $0x0
 4ca:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 4ce:	89 f8                	mov    %edi,%eax
 4d0:	8b 13                	mov    (%ebx),%edx
 4d2:	e8 59 fe ff ff       	call   330 <printint>
        ap++;
 4d7:	89 d8                	mov    %ebx,%eax
      state = 0;
 4d9:	31 ed                	xor    %ebp,%ebp
        ap++;
 4db:	83 c0 04             	add    $0x4,%eax
 4de:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 4e2:	83 c4 10             	add    $0x10,%esp
 4e5:	e9 36 ff ff ff       	jmp    420 <printf+0x50>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 4f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
 4f4:	8b 28                	mov    (%eax),%ebp
        ap++;
 4f6:	83 c0 04             	add    $0x4,%eax
 4f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
 4fd:	85 ed                	test   %ebp,%ebp
 4ff:	74 7d                	je     57e <printf+0x1ae>
        while(*s != 0){
 501:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 505:	84 c0                	test   %al,%al
 507:	74 25                	je     52e <printf+0x15e>
 509:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 50d:	8d 76 00             	lea    0x0(%esi),%esi
 510:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
 514:	83 ec 04             	sub    $0x4,%esp
          s++;
 517:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
 51a:	6a 01                	push   $0x1
 51c:	53                   	push   %ebx
 51d:	57                   	push   %edi
 51e:	e8 8e fd ff ff       	call   2b1 <write>
        while(*s != 0){
 523:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 527:	83 c4 10             	add    $0x10,%esp
 52a:	84 c0                	test   %al,%al
 52c:	75 e2                	jne    510 <printf+0x140>
      state = 0;
 52e:	31 ed                	xor    %ebp,%ebp
 530:	e9 eb fe ff ff       	jmp    420 <printf+0x50>
 535:	8d 76 00             	lea    0x0(%esi),%esi
 538:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
 53c:	83 ec 04             	sub    $0x4,%esp
 53f:	6a 01                	push   $0x1
 541:	8d 44 24 25          	lea    0x25(%esp),%eax
 545:	e9 41 ff ff ff       	jmp    48b <printf+0xbb>
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 0a 00 00 00       	mov    $0xa,%ecx
 558:	6a 01                	push   $0x1
 55a:	e9 6b ff ff ff       	jmp    4ca <printf+0xfa>
        putc(fd, *ap);
 55f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
 563:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 566:	8b 03                	mov    (%ebx),%eax
 568:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
 56c:	6a 01                	push   $0x1
 56e:	8d 44 24 24          	lea    0x24(%esp),%eax
 572:	50                   	push   %eax
 573:	57                   	push   %edi
 574:	e8 38 fd ff ff       	call   2b1 <write>
 579:	e9 59 ff ff ff       	jmp    4d7 <printf+0x107>
        while(*s != 0){
 57e:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 583:	bd f1 06 00 00       	mov    $0x6f1,%ebp
 588:	e9 7c ff ff ff       	jmp    509 <printf+0x139>
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 590:	57                   	push   %edi
 591:	56                   	push   %esi
 592:	53                   	push   %ebx
 593:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 597:	a1 44 0a 00 00       	mov    0xa44,%eax
  bp = (Header*) ap - 1;
 59c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59f:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a1:	39 c8                	cmp    %ecx,%eax
 5a3:	73 13                	jae    5b8 <free+0x28>
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
 5a8:	39 d1                	cmp    %edx,%ecx
 5aa:	72 14                	jb     5c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	39 d0                	cmp    %edx,%eax
 5ae:	73 10                	jae    5c0 <free+0x30>
{
 5b0:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b6:	72 f0                	jb     5a8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b8:	39 d0                	cmp    %edx,%eax
 5ba:	72 f4                	jb     5b0 <free+0x20>
 5bc:	39 d1                	cmp    %edx,%ecx
 5be:	73 f0                	jae    5b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5c6:	39 fa                	cmp    %edi,%edx
 5c8:	74 18                	je     5e2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5cd:	8b 50 04             	mov    0x4(%eax),%edx
 5d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5d3:	39 f1                	cmp    %esi,%ecx
 5d5:	74 22                	je     5f9 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5d9:	a3 44 0a 00 00       	mov    %eax,0xa44
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5f                   	pop    %edi
 5e1:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5e2:	03 72 04             	add    0x4(%edx),%esi
 5e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e8:	8b 10                	mov    (%eax),%edx
 5ea:	8b 12                	mov    (%edx),%edx
 5ec:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5ef:	8b 50 04             	mov    0x4(%eax),%edx
 5f2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5f5:	39 f1                	cmp    %esi,%ecx
 5f7:	75 de                	jne    5d7 <free+0x47>
    p->s.size += bp->s.size;
 5f9:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 5fc:	a3 44 0a 00 00       	mov    %eax,0xa44
    p->s.size += bp->s.size;
 601:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 604:	8b 53 f8             	mov    -0x8(%ebx),%edx
 607:	89 10                	mov    %edx,(%eax)
}
 609:	5b                   	pop    %ebx
 60a:	5e                   	pop    %esi
 60b:	5f                   	pop    %edi
 60c:	c3                   	ret    
 60d:	8d 76 00             	lea    0x0(%esi),%esi

00000610 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 610:	57                   	push   %edi
 611:	56                   	push   %esi
 612:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 613:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 617:	8b 15 44 0a 00 00    	mov    0xa44,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 61d:	8d 78 07             	lea    0x7(%eax),%edi
 620:	c1 ef 03             	shr    $0x3,%edi
 623:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 626:	85 d2                	test   %edx,%edx
 628:	0f 84 90 00 00 00    	je     6be <malloc+0xae>
 62e:	8b 02                	mov    (%edx),%eax
 630:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 633:	39 cf                	cmp    %ecx,%edi
 635:	76 61                	jbe    698 <malloc+0x88>
 637:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 63d:	bb 00 10 00 00       	mov    $0x1000,%ebx
 642:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 645:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 64c:	eb 0b                	jmp    659 <malloc+0x49>
 64e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 650:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 652:	8b 48 04             	mov    0x4(%eax),%ecx
 655:	39 cf                	cmp    %ecx,%edi
 657:	76 3f                	jbe    698 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 659:	39 05 44 0a 00 00    	cmp    %eax,0xa44
 65f:	89 c2                	mov    %eax,%edx
 661:	75 ed                	jne    650 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 663:	83 ec 0c             	sub    $0xc,%esp
 666:	56                   	push   %esi
 667:	e8 ad fc ff ff       	call   319 <sbrk>
  if(p == (char*) -1)
 66c:	83 c4 10             	add    $0x10,%esp
 66f:	83 f8 ff             	cmp    $0xffffffff,%eax
 672:	74 1c                	je     690 <malloc+0x80>
  hp->s.size = nu;
 674:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 677:	83 ec 0c             	sub    $0xc,%esp
 67a:	83 c0 08             	add    $0x8,%eax
 67d:	50                   	push   %eax
 67e:	e8 0d ff ff ff       	call   590 <free>
  return freep;
 683:	8b 15 44 0a 00 00    	mov    0xa44,%edx
      if((p = morecore(nunits)) == 0)
 689:	83 c4 10             	add    $0x10,%esp
 68c:	85 d2                	test   %edx,%edx
 68e:	75 c0                	jne    650 <malloc+0x40>
        return 0;
 690:	31 c0                	xor    %eax,%eax
 692:	eb 1c                	jmp    6b0 <malloc+0xa0>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 698:	39 cf                	cmp    %ecx,%edi
 69a:	74 1c                	je     6b8 <malloc+0xa8>
        p->s.size -= nunits;
 69c:	29 f9                	sub    %edi,%ecx
 69e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 6a7:	89 15 44 0a 00 00    	mov    %edx,0xa44
      return (void*) (p + 1);
 6ad:	83 c0 08             	add    $0x8,%eax
  }
}
 6b0:	5b                   	pop    %ebx
 6b1:	5e                   	pop    %esi
 6b2:	5f                   	pop    %edi
 6b3:	c3                   	ret    
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 6b8:	8b 08                	mov    (%eax),%ecx
 6ba:	89 0a                	mov    %ecx,(%edx)
 6bc:	eb e9                	jmp    6a7 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
 6be:	c7 05 44 0a 00 00 48 	movl   $0xa48,0xa44
 6c5:	0a 00 00 
 6c8:	c7 05 48 0a 00 00 48 	movl   $0xa48,0xa48
 6cf:	0a 00 00 
    base.s.size = 0;
 6d2:	b8 48 0a 00 00       	mov    $0xa48,%eax
 6d7:	c7 05 4c 0a 00 00 00 	movl   $0x0,0xa4c
 6de:	00 00 00 
 6e1:	e9 51 ff ff ff       	jmp    637 <malloc+0x27>


_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 95 03 00 00       	call   3d1 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 5b 03 00 00       	call   3b9 <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 26 03 00 00       	call   391 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 0b 08 00 00       	push   $0x80b
  73:	6a 01                	push   $0x1
  75:	e8 56 04 00 00       	call   4d0 <printf>
      exit();
  7a:	e8 12 03 00 00       	call   391 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 fd 07 00 00       	push   $0x7fd
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 ff 02 00 00       	call   391 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	57                   	push   %edi
  a2:	56                   	push   %esi
  a3:	53                   	push   %ebx
  inword = 0;
  a4:	31 f6                	xor    %esi,%esi
  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx
{
  a8:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  ab:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  b2:	00 
  b3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  ba:	00 
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 20 0c 00 00       	push   $0xc20
  cd:	ff 74 24 3c          	pushl  0x3c(%esp)
  d1:	e8 d3 02 00 00       	call   3a9 <read>
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	83 f8 00             	cmp    $0x0,%eax
  dc:	89 c7                	mov    %eax,%edi
  de:	7e 51                	jle    131 <wc+0x91>
  e0:	31 ed                	xor    %ebp,%ebp
  e2:	eb 0d                	jmp    f1 <wc+0x51>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c5 01             	add    $0x1,%ebp
  ed:	39 ef                	cmp    %ebp,%edi
  ef:	74 3a                	je     12b <wc+0x8b>
      if(buf[i] == '\n')
  f1:	0f be 85 20 0c 00 00 	movsbl 0xc20(%ebp),%eax
        l++;
  f8:	31 c9                	xor    %ecx,%ecx
  fa:	3c 0a                	cmp    $0xa,%al
  fc:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
  ff:	83 ec 08             	sub    $0x8,%esp
 102:	50                   	push   %eax
 103:	68 e8 07 00 00       	push   $0x7e8
        l++;
 108:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10a:	e8 21 01 00 00       	call   230 <strchr>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	85 c0                	test   %eax,%eax
 114:	75 d2                	jne    e8 <wc+0x48>
      else if(!inword){
 116:	85 f6                	test   %esi,%esi
 118:	75 d0                	jne    ea <wc+0x4a>
    for(i=0; i<n; i++){
 11a:	83 c5 01             	add    $0x1,%ebp
        w++;
 11d:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
        inword = 1;
 122:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 127:	39 ef                	cmp    %ebp,%edi
 129:	75 c6                	jne    f1 <wc+0x51>
 12b:	01 7c 24 0c          	add    %edi,0xc(%esp)
 12f:	eb 8f                	jmp    c0 <wc+0x20>
  if(n < 0){
 131:	75 24                	jne    157 <wc+0xb7>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 133:	83 ec 08             	sub    $0x8,%esp
 136:	ff 74 24 3c          	pushl  0x3c(%esp)
 13a:	ff 74 24 18          	pushl  0x18(%esp)
 13e:	ff 74 24 18          	pushl  0x18(%esp)
 142:	53                   	push   %ebx
 143:	68 fe 07 00 00       	push   $0x7fe
 148:	6a 01                	push   $0x1
 14a:	e8 81 03 00 00       	call   4d0 <printf>
}
 14f:	83 c4 3c             	add    $0x3c,%esp
 152:	5b                   	pop    %ebx
 153:	5e                   	pop    %esi
 154:	5f                   	pop    %edi
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
    printf(1, "wc: read error\n");
 157:	83 ec 08             	sub    $0x8,%esp
 15a:	68 ee 07 00 00       	push   $0x7ee
 15f:	6a 01                	push   $0x1
 161:	e8 6a 03 00 00       	call   4d0 <printf>
    exit();
 166:	e8 26 02 00 00       	call   391 <exit>
 16b:	66 90                	xchg   %ax,%ax
 16d:	66 90                	xchg   %ax,%ax
 16f:	90                   	nop

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 170:	53                   	push   %ebx
 171:	8b 44 24 08          	mov    0x8(%esp),%eax
 175:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 179:	89 c2                	mov    %eax,%edx
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	83 c1 01             	add    $0x1,%ecx
 183:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 187:	83 c2 01             	add    $0x1,%edx
 18a:	84 db                	test   %bl,%bl
 18c:	88 5a ff             	mov    %bl,-0x1(%edx)
 18f:	75 ef                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 191:	5b                   	pop    %ebx
 192:	c3                   	ret    
 193:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	56                   	push   %esi
 1a1:	53                   	push   %ebx
 1a2:	8b 54 24 0c          	mov    0xc(%esp),%edx
 1a6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 1aa:	0f b6 02             	movzbl (%edx),%eax
 1ad:	0f b6 19             	movzbl (%ecx),%ebx
 1b0:	84 c0                	test   %al,%al
 1b2:	75 1f                	jne    1d3 <strcmp+0x33>
 1b4:	eb 2a                	jmp    1e0 <strcmp+0x40>
 1b6:	8d 76 00             	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1c6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 1c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1cd:	84 c0                	test   %al,%al
 1cf:	74 0f                	je     1e0 <strcmp+0x40>
 1d1:	89 f1                	mov    %esi,%ecx
 1d3:	38 d8                	cmp    %bl,%al
 1d5:	74 e9                	je     1c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1d7:	29 d8                	sub    %ebx,%eax
}
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	c3                   	ret    
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
 1e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e2:	29 d8                	sub    %ebx,%eax
}
 1e4:	5b                   	pop    %ebx
 1e5:	5e                   	pop    %esi
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strlen>:

uint
strlen(char *s)
{
 1f0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1f4:	80 39 00             	cmpb   $0x0,(%ecx)
 1f7:	74 14                	je     20d <strlen+0x1d>
 1f9:	31 d2                	xor    %edx,%edx
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	83 c2 01             	add    $0x1,%edx
 203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 207:	89 d0                	mov    %edx,%eax
 209:	75 f5                	jne    200 <strlen+0x10>
 20b:	f3 c3                	repz ret 
 20d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 20f:	c3                   	ret    

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	57                   	push   %edi
 211:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 215:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 219:	8b 44 24 0c          	mov    0xc(%esp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld    
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	89 d0                	mov    %edx,%eax
 224:	5f                   	pop    %edi
 225:	c3                   	ret    
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	53                   	push   %ebx
 231:	8b 44 24 08          	mov    0x8(%esp),%eax
 235:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 239:	0f b6 10             	movzbl (%eax),%edx
 23c:	84 d2                	test   %dl,%dl
 23e:	74 1e                	je     25e <strchr+0x2e>
    if(*s == c)
 240:	38 d3                	cmp    %dl,%bl
 242:	89 d9                	mov    %ebx,%ecx
 244:	75 0e                	jne    254 <strchr+0x24>
 246:	eb 18                	jmp    260 <strchr+0x30>
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 250:	38 ca                	cmp    %cl,%dl
 252:	74 0c                	je     260 <strchr+0x30>
  for(; *s; s++)
 254:	83 c0 01             	add    $0x1,%eax
 257:	0f b6 10             	movzbl (%eax),%edx
 25a:	84 d2                	test   %dl,%dl
 25c:	75 f2                	jne    250 <strchr+0x20>
      return (char*) s;
  return 0;
 25e:	31 c0                	xor    %eax,%eax
}
 260:	5b                   	pop    %ebx
 261:	c3                   	ret    
 262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 272:	31 ff                	xor    %edi,%edi
{
 274:	56                   	push   %esi
 275:	53                   	push   %ebx
 276:	83 ec 1c             	sub    $0x1c,%esp
 279:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
 27d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
 281:	eb 2c                	jmp    2af <gets+0x3f>
 283:	90                   	nop
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 288:	83 ec 04             	sub    $0x4,%esp
 28b:	6a 01                	push   $0x1
 28d:	55                   	push   %ebp
 28e:	6a 00                	push   $0x0
 290:	e8 14 01 00 00       	call   3a9 <read>
    if(cc < 1)
 295:	83 c4 10             	add    $0x10,%esp
 298:	85 c0                	test   %eax,%eax
 29a:	7e 1c                	jle    2b8 <gets+0x48>
      break;
    buf[i++] = c;
 29c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 2a1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 2a3:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 2a5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 2a9:	74 25                	je     2d0 <gets+0x60>
 2ab:	3c 0d                	cmp    $0xd,%al
 2ad:	74 21                	je     2d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2af:	8d 5f 01             	lea    0x1(%edi),%ebx
 2b2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 2b6:	7c d0                	jl     288 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 2b8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 2bc:	83 c4 1c             	add    $0x1c,%esp
 2bf:	89 f0                	mov    %esi,%eax
 2c1:	5b                   	pop    %ebx
 2c2:	5e                   	pop    %esi
 2c3:	5f                   	pop    %edi
 2c4:	5d                   	pop    %ebp
 2c5:	c3                   	ret    
 2c6:	8d 76 00             	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
 2d0:	89 df                	mov    %ebx,%edi
}
 2d2:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
 2d4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
 2d8:	83 c4 1c             	add    $0x1c,%esp
 2db:	5b                   	pop    %ebx
 2dc:	5e                   	pop    %esi
 2dd:	5f                   	pop    %edi
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret    

000002e0 <stat>:

int
stat(char *n, struct stat_new *st)
{
 2e0:	56                   	push   %esi
 2e1:	53                   	push   %ebx
 2e2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e5:	6a 00                	push   $0x0
 2e7:	ff 74 24 1c          	pushl  0x1c(%esp)
 2eb:	e8 e1 00 00 00       	call   3d1 <open>
  if(fd < 0)
 2f0:	83 c4 10             	add    $0x10,%esp
 2f3:	85 c0                	test   %eax,%eax
 2f5:	78 29                	js     320 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2f7:	83 ec 08             	sub    $0x8,%esp
 2fa:	89 c3                	mov    %eax,%ebx
 2fc:	ff 74 24 1c          	pushl  0x1c(%esp)
 300:	50                   	push   %eax
 301:	e8 e3 00 00 00       	call   3e9 <fstat>
  close(fd);
 306:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 309:	89 c6                	mov    %eax,%esi
  close(fd);
 30b:	e8 a9 00 00 00       	call   3b9 <close>
  return r;
 310:	83 c4 10             	add    $0x10,%esp
}
 313:	83 c4 04             	add    $0x4,%esp
 316:	89 f0                	mov    %esi,%eax
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	c3                   	ret    
 31b:	90                   	nop
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 320:	be ff ff ff ff       	mov    $0xffffffff,%esi
 325:	eb ec                	jmp    313 <stat+0x33>
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <atoi>:

int
atoi(const char *s)
{
 330:	53                   	push   %ebx
 331:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 335:	0f be 11             	movsbl (%ecx),%edx
 338:	8d 42 d0             	lea    -0x30(%edx),%eax
 33b:	3c 09                	cmp    $0x9,%al
 33d:	b8 00 00 00 00       	mov    $0x0,%eax
 342:	77 19                	ja     35d <atoi+0x2d>
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 348:	8d 04 80             	lea    (%eax,%eax,4),%eax
 34b:	83 c1 01             	add    $0x1,%ecx
 34e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 352:	0f be 11             	movsbl (%ecx),%edx
 355:	8d 5a d0             	lea    -0x30(%edx),%ebx
 358:	80 fb 09             	cmp    $0x9,%bl
 35b:	76 eb                	jbe    348 <atoi+0x18>
  return n;
}
 35d:	5b                   	pop    %ebx
 35e:	c3                   	ret    
 35f:	90                   	nop

00000360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 360:	56                   	push   %esi
 361:	53                   	push   %ebx
 362:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 366:	8b 44 24 0c          	mov    0xc(%esp),%eax
 36a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 382:	39 da                	cmp    %ebx,%edx
 384:	75 f2                	jne    378 <memmove+0x18>
  return vdst;
}
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	c3                   	ret    

00000389 <fork>:
 389:	b8 01 00 00 00       	mov    $0x1,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <exit>:
 391:	b8 02 00 00 00       	mov    $0x2,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <wait>:
 399:	b8 03 00 00 00       	mov    $0x3,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <pipe>:
 3a1:	b8 04 00 00 00       	mov    $0x4,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <read>:
 3a9:	b8 06 00 00 00       	mov    $0x6,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <write>:
 3b1:	b8 05 00 00 00       	mov    $0x5,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <close>:
 3b9:	b8 07 00 00 00       	mov    $0x7,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <kill>:
 3c1:	b8 08 00 00 00       	mov    $0x8,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <exec>:
 3c9:	b8 09 00 00 00       	mov    $0x9,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <open>:
 3d1:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <mknod>:
 3d9:	b8 0b 00 00 00       	mov    $0xb,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <unlink>:
 3e1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <fstat>:
 3e9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <link>:
 3f1:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <mkdir>:
 3f9:	b8 0f 00 00 00       	mov    $0xf,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <chdir>:
 401:	b8 10 00 00 00       	mov    $0x10,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <dup>:
 409:	b8 11 00 00 00       	mov    $0x11,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <getpid>:
 411:	b8 12 00 00 00       	mov    $0x12,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <sbrk>:
 419:	b8 13 00 00 00       	mov    $0x13,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <sleep>:
 421:	b8 14 00 00 00       	mov    $0x14,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    
 429:	66 90                	xchg   %ax,%ax
 42b:	66 90                	xchg   %ax,%ax
 42d:	66 90                	xchg   %ax,%ax
 42f:	90                   	nop

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	57                   	push   %edi
 432:	89 c7                	mov    %eax,%edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 439:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 43d:	85 db                	test   %ebx,%ebx
 43f:	74 7f                	je     4c0 <printint+0x90>
 441:	89 d0                	mov    %edx,%eax
 443:	c1 e8 1f             	shr    $0x1f,%eax
 446:	84 c0                	test   %al,%al
 448:	74 76                	je     4c0 <printint+0x90>
    neg = 1;
    x = -xx;
 44a:	89 d0                	mov    %edx,%eax
    neg = 1;
 44c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 453:	00 
    x = -xx;
 454:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 456:	31 ed                	xor    %ebp,%ebp
 458:	8d 74 24 1f          	lea    0x1f(%esp),%esi
 45c:	eb 04                	jmp    462 <printint+0x32>
 45e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 460:	89 dd                	mov    %ebx,%ebp
 462:	31 d2                	xor    %edx,%edx
 464:	8d 5d 01             	lea    0x1(%ebp),%ebx
 467:	f7 f1                	div    %ecx
 469:	0f b6 92 28 08 00 00 	movzbl 0x828(%edx),%edx
  }while((x /= base) != 0);
 470:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 472:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 475:	75 e9                	jne    460 <printint+0x30>
  if(neg)
 477:	8b 44 24 0c          	mov    0xc(%esp),%eax
 47b:	85 c0                	test   %eax,%eax
 47d:	74 08                	je     487 <printint+0x57>
    buf[i++] = '-';
 47f:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
 484:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
 487:	83 eb 01             	sub    $0x1,%ebx
 48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 490:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
 495:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 498:	83 eb 01             	sub    $0x1,%ebx
 49b:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
 49f:	6a 01                	push   $0x1
 4a1:	56                   	push   %esi
 4a2:	57                   	push   %edi
 4a3:	e8 09 ff ff ff       	call   3b1 <write>
  while(--i >= 0)
 4a8:	83 c4 10             	add    $0x10,%esp
 4ab:	83 fb ff             	cmp    $0xffffffff,%ebx
 4ae:	75 e0                	jne    490 <printint+0x60>
    putc(fd, buf[i]);
}
 4b0:	83 c4 3c             	add    $0x3c,%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
 4c0:	89 d0                	mov    %edx,%eax
  neg = 0;
 4c2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4c9:	00 
 4ca:	eb 8a                	jmp    456 <printint+0x26>
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	57                   	push   %edi
 4d2:	56                   	push   %esi
 4d3:	53                   	push   %ebx
 4d4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d7:	8b 74 24 44          	mov    0x44(%esp),%esi
 4db:	8d 44 24 48          	lea    0x48(%esp),%eax
{
 4df:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
 4e3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4e7:	0f b6 1e             	movzbl (%esi),%ebx
 4ea:	83 c6 01             	add    $0x1,%esi
 4ed:	84 db                	test   %bl,%bl
 4ef:	0f 84 ad 00 00 00    	je     5a2 <printf+0xd2>
 4f5:	31 ed                	xor    %ebp,%ebp
 4f7:	eb 32                	jmp    52b <printf+0x5b>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 500:	83 f8 25             	cmp    $0x25,%eax
 503:	0f 84 a7 00 00 00    	je     5b0 <printf+0xe0>
 509:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
 50d:	83 ec 04             	sub    $0x4,%esp
 510:	6a 01                	push   $0x1
 512:	8d 44 24 22          	lea    0x22(%esp),%eax
 516:	50                   	push   %eax
 517:	57                   	push   %edi
 518:	e8 94 fe ff ff       	call   3b1 <write>
 51d:	83 c4 10             	add    $0x10,%esp
 520:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 523:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 527:	84 db                	test   %bl,%bl
 529:	74 77                	je     5a2 <printf+0xd2>
    if(state == 0){
 52b:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
 52d:	0f be cb             	movsbl %bl,%ecx
 530:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 533:	74 cb                	je     500 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 535:	83 fd 25             	cmp    $0x25,%ebp
 538:	75 e6                	jne    520 <printf+0x50>
      if(c == 'd'){
 53a:	83 f8 64             	cmp    $0x64,%eax
 53d:	0f 84 0d 01 00 00    	je     650 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 543:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 549:	83 f9 70             	cmp    $0x70,%ecx
 54c:	74 72                	je     5c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 54e:	83 f8 73             	cmp    $0x73,%eax
 551:	0f 84 99 00 00 00    	je     5f0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 557:	83 f8 63             	cmp    $0x63,%eax
 55a:	0f 84 ff 00 00 00    	je     65f <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 560:	83 f8 25             	cmp    $0x25,%eax
 563:	0f 84 cf 00 00 00    	je     638 <printf+0x168>
 569:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
 56e:	83 ec 04             	sub    $0x4,%esp
 571:	6a 01                	push   $0x1
 573:	8d 44 24 27          	lea    0x27(%esp),%eax
 577:	50                   	push   %eax
 578:	57                   	push   %edi
 579:	e8 33 fe ff ff       	call   3b1 <write>
 57e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 582:	83 c4 0c             	add    $0xc,%esp
 585:	6a 01                	push   $0x1
 587:	8d 44 24 26          	lea    0x26(%esp),%eax
 58b:	50                   	push   %eax
 58c:	57                   	push   %edi
 58d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 590:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
 592:	e8 1a fe ff ff       	call   3b1 <write>
  for(i = 0; fmt[i]; i++){
 597:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 59b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 59e:	84 db                	test   %bl,%bl
 5a0:	75 89                	jne    52b <printf+0x5b>
    }
  }
}
 5a2:	83 c4 2c             	add    $0x2c,%esp
 5a5:	5b                   	pop    %ebx
 5a6:	5e                   	pop    %esi
 5a7:	5f                   	pop    %edi
 5a8:	5d                   	pop    %ebp
 5a9:	c3                   	ret    
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 5b0:	bd 25 00 00 00       	mov    $0x25,%ebp
 5b5:	e9 66 ff ff ff       	jmp    520 <printf+0x50>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5c8:	6a 00                	push   $0x0
 5ca:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 5ce:	89 f8                	mov    %edi,%eax
 5d0:	8b 13                	mov    (%ebx),%edx
 5d2:	e8 59 fe ff ff       	call   430 <printint>
        ap++;
 5d7:	89 d8                	mov    %ebx,%eax
      state = 0;
 5d9:	31 ed                	xor    %ebp,%ebp
        ap++;
 5db:	83 c0 04             	add    $0x4,%eax
 5de:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 5e2:	83 c4 10             	add    $0x10,%esp
 5e5:	e9 36 ff ff ff       	jmp    520 <printf+0x50>
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
 5f4:	8b 28                	mov    (%eax),%ebp
        ap++;
 5f6:	83 c0 04             	add    $0x4,%eax
 5f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
 5fd:	85 ed                	test   %ebp,%ebp
 5ff:	74 7d                	je     67e <printf+0x1ae>
        while(*s != 0){
 601:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 605:	84 c0                	test   %al,%al
 607:	74 25                	je     62e <printf+0x15e>
 609:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 60d:	8d 76 00             	lea    0x0(%esi),%esi
 610:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
 614:	83 ec 04             	sub    $0x4,%esp
          s++;
 617:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
 61a:	6a 01                	push   $0x1
 61c:	53                   	push   %ebx
 61d:	57                   	push   %edi
 61e:	e8 8e fd ff ff       	call   3b1 <write>
        while(*s != 0){
 623:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 627:	83 c4 10             	add    $0x10,%esp
 62a:	84 c0                	test   %al,%al
 62c:	75 e2                	jne    610 <printf+0x140>
      state = 0;
 62e:	31 ed                	xor    %ebp,%ebp
 630:	e9 eb fe ff ff       	jmp    520 <printf+0x50>
 635:	8d 76 00             	lea    0x0(%esi),%esi
 638:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
 63c:	83 ec 04             	sub    $0x4,%esp
 63f:	6a 01                	push   $0x1
 641:	8d 44 24 25          	lea    0x25(%esp),%eax
 645:	e9 41 ff ff ff       	jmp    58b <printf+0xbb>
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 0a 00 00 00       	mov    $0xa,%ecx
 658:	6a 01                	push   $0x1
 65a:	e9 6b ff ff ff       	jmp    5ca <printf+0xfa>
        putc(fd, *ap);
 65f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 666:	8b 03                	mov    (%ebx),%eax
 668:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
 66c:	6a 01                	push   $0x1
 66e:	8d 44 24 24          	lea    0x24(%esp),%eax
 672:	50                   	push   %eax
 673:	57                   	push   %edi
 674:	e8 38 fd ff ff       	call   3b1 <write>
 679:	e9 59 ff ff ff       	jmp    5d7 <printf+0x107>
        while(*s != 0){
 67e:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 683:	bd 20 08 00 00       	mov    $0x820,%ebp
 688:	e9 7c ff ff ff       	jmp    609 <printf+0x139>
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	57                   	push   %edi
 691:	56                   	push   %esi
 692:	53                   	push   %ebx
 693:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 697:	a1 00 0c 00 00       	mov    0xc00,%eax
  bp = (Header*) ap - 1;
 69c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69f:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	39 c8                	cmp    %ecx,%eax
 6a3:	73 13                	jae    6b8 <free+0x28>
 6a5:	8d 76 00             	lea    0x0(%esi),%esi
 6a8:	39 d1                	cmp    %edx,%ecx
 6aa:	72 14                	jb     6c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	39 d0                	cmp    %edx,%eax
 6ae:	73 10                	jae    6c0 <free+0x30>
{
 6b0:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b4:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b6:	72 f0                	jb     6a8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	39 d0                	cmp    %edx,%eax
 6ba:	72 f4                	jb     6b0 <free+0x20>
 6bc:	39 d1                	cmp    %edx,%ecx
 6be:	73 f0                	jae    6b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6c6:	39 fa                	cmp    %edi,%edx
 6c8:	74 18                	je     6e2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	74 22                	je     6f9 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6d9:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 6de:	5b                   	pop    %ebx
 6df:	5e                   	pop    %esi
 6e0:	5f                   	pop    %edi
 6e1:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 6e2:	03 72 04             	add    0x4(%edx),%esi
 6e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e8:	8b 10                	mov    (%eax),%edx
 6ea:	8b 12                	mov    (%edx),%edx
 6ec:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ef:	8b 50 04             	mov    0x4(%eax),%edx
 6f2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f5:	39 f1                	cmp    %esi,%ecx
 6f7:	75 de                	jne    6d7 <free+0x47>
    p->s.size += bp->s.size;
 6f9:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fc:	a3 00 0c 00 00       	mov    %eax,0xc00
    p->s.size += bp->s.size;
 701:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 704:	8b 53 f8             	mov    -0x8(%ebx),%edx
 707:	89 10                	mov    %edx,(%eax)
}
 709:	5b                   	pop    %ebx
 70a:	5e                   	pop    %esi
 70b:	5f                   	pop    %edi
 70c:	c3                   	ret    
 70d:	8d 76 00             	lea    0x0(%esi),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	57                   	push   %edi
 711:	56                   	push   %esi
 712:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 713:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 717:	8b 15 00 0c 00 00    	mov    0xc00,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71d:	8d 78 07             	lea    0x7(%eax),%edi
 720:	c1 ef 03             	shr    $0x3,%edi
 723:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 726:	85 d2                	test   %edx,%edx
 728:	0f 84 90 00 00 00    	je     7be <malloc+0xae>
 72e:	8b 02                	mov    (%edx),%eax
 730:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 733:	39 cf                	cmp    %ecx,%edi
 735:	76 61                	jbe    798 <malloc+0x88>
 737:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 73d:	bb 00 10 00 00       	mov    $0x1000,%ebx
 742:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 745:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 74c:	eb 0b                	jmp    759 <malloc+0x49>
 74e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 750:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 752:	8b 48 04             	mov    0x4(%eax),%ecx
 755:	39 cf                	cmp    %ecx,%edi
 757:	76 3f                	jbe    798 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 759:	39 05 00 0c 00 00    	cmp    %eax,0xc00
 75f:	89 c2                	mov    %eax,%edx
 761:	75 ed                	jne    750 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 763:	83 ec 0c             	sub    $0xc,%esp
 766:	56                   	push   %esi
 767:	e8 ad fc ff ff       	call   419 <sbrk>
  if(p == (char*) -1)
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	83 f8 ff             	cmp    $0xffffffff,%eax
 772:	74 1c                	je     790 <malloc+0x80>
  hp->s.size = nu;
 774:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 777:	83 ec 0c             	sub    $0xc,%esp
 77a:	83 c0 08             	add    $0x8,%eax
 77d:	50                   	push   %eax
 77e:	e8 0d ff ff ff       	call   690 <free>
  return freep;
 783:	8b 15 00 0c 00 00    	mov    0xc00,%edx
      if((p = morecore(nunits)) == 0)
 789:	83 c4 10             	add    $0x10,%esp
 78c:	85 d2                	test   %edx,%edx
 78e:	75 c0                	jne    750 <malloc+0x40>
        return 0;
 790:	31 c0                	xor    %eax,%eax
 792:	eb 1c                	jmp    7b0 <malloc+0xa0>
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 798:	39 cf                	cmp    %ecx,%edi
 79a:	74 1c                	je     7b8 <malloc+0xa8>
        p->s.size -= nunits;
 79c:	29 f9                	sub    %edi,%ecx
 79e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7a7:	89 15 00 0c 00 00    	mov    %edx,0xc00
      return (void*) (p + 1);
 7ad:	83 c0 08             	add    $0x8,%eax
  }
}
 7b0:	5b                   	pop    %ebx
 7b1:	5e                   	pop    %esi
 7b2:	5f                   	pop    %edi
 7b3:	c3                   	ret    
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7b8:	8b 08                	mov    (%eax),%ecx
 7ba:	89 0a                	mov    %ecx,(%edx)
 7bc:	eb e9                	jmp    7a7 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
 7be:	c7 05 00 0c 00 00 04 	movl   $0xc04,0xc00
 7c5:	0c 00 00 
 7c8:	c7 05 04 0c 00 00 04 	movl   $0xc04,0xc04
 7cf:	0c 00 00 
    base.s.size = 0;
 7d2:	b8 04 0c 00 00       	mov    $0xc04,%eax
 7d7:	c7 05 08 0c 00 00 00 	movl   $0x0,0xc08
 7de:	00 00 00 
 7e1:	e9 51 ff ff ff       	jmp    737 <malloc+0x27>

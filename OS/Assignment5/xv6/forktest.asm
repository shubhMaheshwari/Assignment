
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  forktest();
  11:	e8 3a 00 00 00       	call   50 <forktest>
  exit();
  16:	e8 56 03 00 00       	call   371 <exit>
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	90                   	nop

00000020 <printf>:
{
  20:	53                   	push   %ebx
  21:	83 ec 14             	sub    $0x14,%esp
  24:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  write(fd, s, strlen(s));
  28:	53                   	push   %ebx
  29:	e8 a2 01 00 00       	call   1d0 <strlen>
  2e:	83 c4 0c             	add    $0xc,%esp
  31:	50                   	push   %eax
  32:	53                   	push   %ebx
  33:	ff 74 24 1c          	pushl  0x1c(%esp)
  37:	e8 55 03 00 00       	call   391 <write>
}
  3c:	83 c4 18             	add    $0x18,%esp
  3f:	5b                   	pop    %ebx
  40:	c3                   	ret    
  41:	eb 0d                	jmp    50 <forktest>
  43:	90                   	nop
  44:	90                   	nop
  45:	90                   	nop
  46:	90                   	nop
  47:	90                   	nop
  48:	90                   	nop
  49:	90                   	nop
  4a:	90                   	nop
  4b:	90                   	nop
  4c:	90                   	nop
  4d:	90                   	nop
  4e:	90                   	nop
  4f:	90                   	nop

00000050 <forktest>:
{
  50:	53                   	push   %ebx
  for(n=0; n<1000; n++){
  51:	31 db                	xor    %ebx,%ebx
{
  53:	83 ec 14             	sub    $0x14,%esp
  write(fd, s, strlen(s));
  56:	68 0c 04 00 00       	push   $0x40c
  5b:	e8 70 01 00 00       	call   1d0 <strlen>
  60:	83 c4 0c             	add    $0xc,%esp
  63:	50                   	push   %eax
  64:	68 0c 04 00 00       	push   $0x40c
  69:	6a 01                	push   $0x1
  6b:	e8 21 03 00 00       	call   391 <write>
  70:	83 c4 10             	add    $0x10,%esp
  73:	eb 14                	jmp    89 <forktest+0x39>
  75:	8d 76 00             	lea    0x0(%esi),%esi
    if(pid == 0)
  78:	0f 84 84 00 00 00    	je     102 <forktest+0xb2>
  for(n=0; n<1000; n++){
  7e:	83 c3 01             	add    $0x1,%ebx
  81:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  87:	74 57                	je     e0 <forktest+0x90>
    pid = fork();
  89:	e8 db 02 00 00       	call   369 <fork>
    if(pid < 0)
  8e:	85 c0                	test   %eax,%eax
  90:	79 e6                	jns    78 <forktest+0x28>
  for(; n > 0; n--){
  92:	85 db                	test   %ebx,%ebx
  94:	74 18                	je     ae <forktest+0x5e>
  96:	8d 76 00             	lea    0x0(%esi),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(wait() < 0){
  a0:	e8 d4 02 00 00       	call   379 <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 5e                	js     107 <forktest+0xb7>
  for(; n > 0; n--){
  a9:	83 eb 01             	sub    $0x1,%ebx
  ac:	75 f2                	jne    a0 <forktest+0x50>
  if(wait() != -1){
  ae:	e8 c6 02 00 00       	call   379 <wait>
  b3:	83 f8 ff             	cmp    $0xffffffff,%eax
  b6:	75 71                	jne    129 <forktest+0xd9>
  write(fd, s, strlen(s));
  b8:	83 ec 0c             	sub    $0xc,%esp
  bb:	68 3e 04 00 00       	push   $0x43e
  c0:	e8 0b 01 00 00       	call   1d0 <strlen>
  c5:	83 c4 0c             	add    $0xc,%esp
  c8:	50                   	push   %eax
  c9:	68 3e 04 00 00       	push   $0x43e
  ce:	6a 01                	push   $0x1
  d0:	e8 bc 02 00 00       	call   391 <write>
}
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 c4 08             	add    $0x8,%esp
  db:	5b                   	pop    %ebx
  dc:	c3                   	ret    
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, s, strlen(s));
  e0:	83 ec 0c             	sub    $0xc,%esp
  e3:	68 4c 04 00 00       	push   $0x44c
  e8:	e8 e3 00 00 00       	call   1d0 <strlen>
  ed:	83 c4 0c             	add    $0xc,%esp
  f0:	50                   	push   %eax
  f1:	68 4c 04 00 00       	push   $0x44c
  f6:	6a 01                	push   $0x1
  f8:	e8 94 02 00 00       	call   391 <write>
    exit();
  fd:	e8 6f 02 00 00       	call   371 <exit>
      exit();
 102:	e8 6a 02 00 00       	call   371 <exit>
  write(fd, s, strlen(s));
 107:	83 ec 0c             	sub    $0xc,%esp
 10a:	68 17 04 00 00       	push   $0x417
 10f:	e8 bc 00 00 00       	call   1d0 <strlen>
 114:	83 c4 0c             	add    $0xc,%esp
 117:	50                   	push   %eax
 118:	68 17 04 00 00       	push   $0x417
 11d:	6a 01                	push   $0x1
 11f:	e8 6d 02 00 00       	call   391 <write>
      exit();
 124:	e8 48 02 00 00       	call   371 <exit>
  write(fd, s, strlen(s));
 129:	83 ec 0c             	sub    $0xc,%esp
 12c:	68 2b 04 00 00       	push   $0x42b
 131:	e8 9a 00 00 00       	call   1d0 <strlen>
 136:	83 c4 0c             	add    $0xc,%esp
 139:	50                   	push   %eax
 13a:	68 2b 04 00 00       	push   $0x42b
 13f:	6a 01                	push   $0x1
 141:	e8 4b 02 00 00       	call   391 <write>
    exit();
 146:	e8 26 02 00 00       	call   371 <exit>
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 150:	53                   	push   %ebx
 151:	8b 44 24 08          	mov    0x8(%esp),%eax
 155:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 159:	89 c2                	mov    %eax,%edx
 15b:	90                   	nop
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	83 c1 01             	add    $0x1,%ecx
 163:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 167:	83 c2 01             	add    $0x1,%edx
 16a:	84 db                	test   %bl,%bl
 16c:	88 5a ff             	mov    %bl,-0x1(%edx)
 16f:	75 ef                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 171:	5b                   	pop    %ebx
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	56                   	push   %esi
 181:	53                   	push   %ebx
 182:	8b 54 24 0c          	mov    0xc(%esp),%edx
 186:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 18a:	0f b6 02             	movzbl (%edx),%eax
 18d:	0f b6 19             	movzbl (%ecx),%ebx
 190:	84 c0                	test   %al,%al
 192:	75 1f                	jne    1b3 <strcmp+0x33>
 194:	eb 2a                	jmp    1c0 <strcmp+0x40>
 196:	8d 76 00             	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1a0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1a3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1a6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 1a9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1ad:	84 c0                	test   %al,%al
 1af:	74 0f                	je     1c0 <strcmp+0x40>
 1b1:	89 f1                	mov    %esi,%ecx
 1b3:	38 d8                	cmp    %bl,%al
 1b5:	74 e9                	je     1a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1b7:	29 d8                	sub    %ebx,%eax
}
 1b9:	5b                   	pop    %ebx
 1ba:	5e                   	pop    %esi
 1bb:	c3                   	ret    
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
 1c0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1c2:	29 d8                	sub    %ebx,%eax
}
 1c4:	5b                   	pop    %ebx
 1c5:	5e                   	pop    %esi
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strlen>:

uint
strlen(char *s)
{
 1d0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1d4:	80 39 00             	cmpb   $0x0,(%ecx)
 1d7:	74 14                	je     1ed <strlen+0x1d>
 1d9:	31 d2                	xor    %edx,%edx
 1db:	90                   	nop
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e0:	83 c2 01             	add    $0x1,%edx
 1e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1e7:	89 d0                	mov    %edx,%eax
 1e9:	75 f5                	jne    1e0 <strlen+0x10>
 1eb:	f3 c3                	repz ret 
 1ed:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1ef:	c3                   	ret    

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	57                   	push   %edi
 1f1:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 1f9:	8b 44 24 0c          	mov    0xc(%esp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	c3                   	ret    
 206:	8d 76 00             	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	53                   	push   %ebx
 211:	8b 44 24 08          	mov    0x8(%esp),%eax
 215:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 219:	0f b6 10             	movzbl (%eax),%edx
 21c:	84 d2                	test   %dl,%dl
 21e:	74 1e                	je     23e <strchr+0x2e>
    if(*s == c)
 220:	38 d3                	cmp    %dl,%bl
 222:	89 d9                	mov    %ebx,%ecx
 224:	75 0e                	jne    234 <strchr+0x24>
 226:	eb 18                	jmp    240 <strchr+0x30>
 228:	90                   	nop
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*) s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	c3                   	ret    
 242:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 252:	31 ff                	xor    %edi,%edi
{
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
 256:	83 ec 1c             	sub    $0x1c,%esp
 259:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
 25d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
 261:	eb 2c                	jmp    28f <gets+0x3f>
 263:	90                   	nop
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 268:	83 ec 04             	sub    $0x4,%esp
 26b:	6a 01                	push   $0x1
 26d:	55                   	push   %ebp
 26e:	6a 00                	push   $0x0
 270:	e8 14 01 00 00       	call   389 <read>
    if(cc < 1)
 275:	83 c4 10             	add    $0x10,%esp
 278:	85 c0                	test   %eax,%eax
 27a:	7e 1c                	jle    298 <gets+0x48>
      break;
    buf[i++] = c;
 27c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 281:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 283:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 285:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 289:	74 25                	je     2b0 <gets+0x60>
 28b:	3c 0d                	cmp    $0xd,%al
 28d:	74 21                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 28f:	8d 5f 01             	lea    0x1(%edi),%ebx
 292:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 296:	7c d0                	jl     268 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 298:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 29c:	83 c4 1c             	add    $0x1c,%esp
 29f:	89 f0                	mov    %esi,%eax
 2a1:	5b                   	pop    %ebx
 2a2:	5e                   	pop    %esi
 2a3:	5f                   	pop    %edi
 2a4:	5d                   	pop    %ebp
 2a5:	c3                   	ret    
 2a6:	8d 76 00             	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
 2b0:	89 df                	mov    %ebx,%edi
}
 2b2:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
 2b4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
 2b8:	83 c4 1c             	add    $0x1c,%esp
 2bb:	5b                   	pop    %ebx
 2bc:	5e                   	pop    %esi
 2bd:	5f                   	pop    %edi
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret    

000002c0 <stat>:

int
stat(char *n, struct stat_new *st)
{
 2c0:	56                   	push   %esi
 2c1:	53                   	push   %ebx
 2c2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c5:	6a 00                	push   $0x0
 2c7:	ff 74 24 1c          	pushl  0x1c(%esp)
 2cb:	e8 e1 00 00 00       	call   3b1 <open>
  if(fd < 0)
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	85 c0                	test   %eax,%eax
 2d5:	78 29                	js     300 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2d7:	83 ec 08             	sub    $0x8,%esp
 2da:	89 c3                	mov    %eax,%ebx
 2dc:	ff 74 24 1c          	pushl  0x1c(%esp)
 2e0:	50                   	push   %eax
 2e1:	e8 e3 00 00 00       	call   3c9 <fstat>
  close(fd);
 2e6:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2e9:	89 c6                	mov    %eax,%esi
  close(fd);
 2eb:	e8 a9 00 00 00       	call   399 <close>
  return r;
 2f0:	83 c4 10             	add    $0x10,%esp
}
 2f3:	83 c4 04             	add    $0x4,%esp
 2f6:	89 f0                	mov    %esi,%eax
 2f8:	5b                   	pop    %ebx
 2f9:	5e                   	pop    %esi
 2fa:	c3                   	ret    
 2fb:	90                   	nop
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
 305:	eb ec                	jmp    2f3 <stat+0x33>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <atoi>:

int
atoi(const char *s)
{
 310:	53                   	push   %ebx
 311:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 315:	0f be 11             	movsbl (%ecx),%edx
 318:	8d 42 d0             	lea    -0x30(%edx),%eax
 31b:	3c 09                	cmp    $0x9,%al
 31d:	b8 00 00 00 00       	mov    $0x0,%eax
 322:	77 19                	ja     33d <atoi+0x2d>
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 328:	8d 04 80             	lea    (%eax,%eax,4),%eax
 32b:	83 c1 01             	add    $0x1,%ecx
 32e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 332:	0f be 11             	movsbl (%ecx),%edx
 335:	8d 5a d0             	lea    -0x30(%edx),%ebx
 338:	80 fb 09             	cmp    $0x9,%bl
 33b:	76 eb                	jbe    328 <atoi+0x18>
  return n;
}
 33d:	5b                   	pop    %ebx
 33e:	c3                   	ret    
 33f:	90                   	nop

00000340 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	56                   	push   %esi
 341:	53                   	push   %ebx
 342:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 346:	8b 44 24 0c          	mov    0xc(%esp),%eax
 34a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 db                	test   %ebx,%ebx
 350:	7e 14                	jle    366 <memmove+0x26>
 352:	31 d2                	xor    %edx,%edx
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 358:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 35c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 35f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 362:	39 da                	cmp    %ebx,%edx
 364:	75 f2                	jne    358 <memmove+0x18>
  return vdst;
}
 366:	5b                   	pop    %ebx
 367:	5e                   	pop    %esi
 368:	c3                   	ret    

00000369 <fork>:
 369:	b8 01 00 00 00       	mov    $0x1,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <exit>:
 371:	b8 02 00 00 00       	mov    $0x2,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <wait>:
 379:	b8 03 00 00 00       	mov    $0x3,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <pipe>:
 381:	b8 04 00 00 00       	mov    $0x4,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <read>:
 389:	b8 06 00 00 00       	mov    $0x6,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <write>:
 391:	b8 05 00 00 00       	mov    $0x5,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <close>:
 399:	b8 07 00 00 00       	mov    $0x7,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <kill>:
 3a1:	b8 08 00 00 00       	mov    $0x8,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <exec>:
 3a9:	b8 09 00 00 00       	mov    $0x9,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <open>:
 3b1:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <mknod>:
 3b9:	b8 0b 00 00 00       	mov    $0xb,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <unlink>:
 3c1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <fstat>:
 3c9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <link>:
 3d1:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <mkdir>:
 3d9:	b8 0f 00 00 00       	mov    $0xf,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <chdir>:
 3e1:	b8 10 00 00 00       	mov    $0x10,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <dup>:
 3e9:	b8 11 00 00 00       	mov    $0x11,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <getpid>:
 3f1:	b8 12 00 00 00       	mov    $0x12,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <sbrk>:
 3f9:	b8 13 00 00 00       	mov    $0x13,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <sleep>:
 401:	b8 14 00 00 00       	mov    $0x14,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

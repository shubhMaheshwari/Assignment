
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 15 03 00 00       	call   351 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 dd 02 00 00       	call   339 <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 a8 02 00 00       	call   311 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 79 07 00 00       	push   $0x779
  71:	6a 01                	push   $0x1
  73:	e8 d8 03 00 00       	call   450 <printf>
      exit();
  78:	e8 94 02 00 00       	call   311 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 85 02 00 00       	call   311 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	53                   	push   %ebx
  91:	83 ec 08             	sub    $0x8,%esp
  94:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  while((n = read(fd, buf, sizeof(buf))) > 0)
  98:	eb 19                	jmp    b3 <cat+0x23>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    write(1, buf, n);
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	50                   	push   %eax
  a4:	68 60 0b 00 00       	push   $0xb60
  a9:	6a 01                	push   $0x1
  ab:	e8 81 02 00 00       	call   331 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf, sizeof(buf))) > 0)
  b3:	83 ec 04             	sub    $0x4,%esp
  b6:	68 00 02 00 00       	push   $0x200
  bb:	68 60 0b 00 00       	push   $0xb60
  c0:	53                   	push   %ebx
  c1:	e8 63 02 00 00       	call   329 <read>
  c6:	83 c4 10             	add    $0x10,%esp
  c9:	83 f8 00             	cmp    $0x0,%eax
  cc:	7f d2                	jg     a0 <cat+0x10>
  if(n < 0){
  ce:	75 05                	jne    d5 <cat+0x45>
}
  d0:	83 c4 08             	add    $0x8,%esp
  d3:	5b                   	pop    %ebx
  d4:	c3                   	ret    
    printf(1, "cat: read error\n");
  d5:	83 ec 08             	sub    $0x8,%esp
  d8:	68 68 07 00 00       	push   $0x768
  dd:	6a 01                	push   $0x1
  df:	e8 6c 03 00 00       	call   450 <printf>
    exit();
  e4:	e8 28 02 00 00       	call   311 <exit>
  e9:	66 90                	xchg   %ax,%ax
  eb:	66 90                	xchg   %ax,%ax
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f0:	53                   	push   %ebx
  f1:	8b 44 24 08          	mov    0x8(%esp),%eax
  f5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f9:	89 c2                	mov    %eax,%edx
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	c3                   	ret    
 113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	56                   	push   %esi
 121:	53                   	push   %ebx
 122:	8b 54 24 0c          	mov    0xc(%esp),%edx
 126:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1f                	jne    153 <strcmp+0x33>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 146:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
 149:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 14d:	84 c0                	test   %al,%al
 14f:	74 0f                	je     160 <strcmp+0x40>
 151:	89 f1                	mov    %esi,%ecx
 153:	38 d8                	cmp    %bl,%al
 155:	74 e9                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 157:	29 d8                	sub    %ebx,%eax
}
 159:	5b                   	pop    %ebx
 15a:	5e                   	pop    %esi
 15b:	c3                   	ret    
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 174:	80 39 00             	cmpb   $0x0,(%ecx)
 177:	74 14                	je     18d <strlen+0x1d>
 179:	31 d2                	xor    %edx,%edx
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
 18b:	f3 c3                	repz ret 
 18d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 18f:	c3                   	ret    

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	57                   	push   %edi
 191:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 195:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 199:	8b 44 24 0c          	mov    0xc(%esp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld    
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a2:	89 d0                	mov    %edx,%eax
 1a4:	5f                   	pop    %edi
 1a5:	c3                   	ret    
 1a6:	8d 76 00             	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	53                   	push   %ebx
 1b1:	8b 44 24 08          	mov    0x8(%esp),%eax
 1b5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 1b9:	0f b6 10             	movzbl (%eax),%edx
 1bc:	84 d2                	test   %dl,%dl
 1be:	74 1e                	je     1de <strchr+0x2e>
    if(*s == c)
 1c0:	38 d3                	cmp    %dl,%bl
 1c2:	89 d9                	mov    %ebx,%ecx
 1c4:	75 0e                	jne    1d4 <strchr+0x24>
 1c6:	eb 18                	jmp    1e0 <strchr+0x30>
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1d0:	38 ca                	cmp    %cl,%dl
 1d2:	74 0c                	je     1e0 <strchr+0x30>
  for(; *s; s++)
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	0f b6 10             	movzbl (%eax),%edx
 1da:	84 d2                	test   %dl,%dl
 1dc:	75 f2                	jne    1d0 <strchr+0x20>
      return (char*) s;
  return 0;
 1de:	31 c0                	xor    %eax,%eax
}
 1e0:	5b                   	pop    %ebx
 1e1:	c3                   	ret    
 1e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f2:	31 ff                	xor    %edi,%edi
{
 1f4:	56                   	push   %esi
 1f5:	53                   	push   %ebx
 1f6:	83 ec 1c             	sub    $0x1c,%esp
 1f9:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
 1fd:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
 201:	eb 2c                	jmp    22f <gets+0x3f>
 203:	90                   	nop
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	6a 01                	push   $0x1
 20d:	55                   	push   %ebp
 20e:	6a 00                	push   $0x0
 210:	e8 14 01 00 00       	call   329 <read>
    if(cc < 1)
 215:	83 c4 10             	add    $0x10,%esp
 218:	85 c0                	test   %eax,%eax
 21a:	7e 1c                	jle    238 <gets+0x48>
      break;
    buf[i++] = c;
 21c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 221:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 223:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
 225:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 229:	74 25                	je     250 <gets+0x60>
 22b:	3c 0d                	cmp    $0xd,%al
 22d:	74 21                	je     250 <gets+0x60>
  for(i=0; i+1 < max; ){
 22f:	8d 5f 01             	lea    0x1(%edi),%ebx
 232:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 236:	7c d0                	jl     208 <gets+0x18>
      break;
  }
  buf[i] = '\0';
 238:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 23c:	83 c4 1c             	add    $0x1c,%esp
 23f:	89 f0                	mov    %esi,%eax
 241:	5b                   	pop    %ebx
 242:	5e                   	pop    %esi
 243:	5f                   	pop    %edi
 244:	5d                   	pop    %ebp
 245:	c3                   	ret    
 246:	8d 76 00             	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
 250:	89 df                	mov    %ebx,%edi
}
 252:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
 254:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
 258:	83 c4 1c             	add    $0x1c,%esp
 25b:	5b                   	pop    %ebx
 25c:	5e                   	pop    %esi
 25d:	5f                   	pop    %edi
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <stat>:

int
stat(char *n, struct stat_new *st)
{
 260:	56                   	push   %esi
 261:	53                   	push   %ebx
 262:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 265:	6a 00                	push   $0x0
 267:	ff 74 24 1c          	pushl  0x1c(%esp)
 26b:	e8 e1 00 00 00       	call   351 <open>
  if(fd < 0)
 270:	83 c4 10             	add    $0x10,%esp
 273:	85 c0                	test   %eax,%eax
 275:	78 29                	js     2a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 277:	83 ec 08             	sub    $0x8,%esp
 27a:	89 c3                	mov    %eax,%ebx
 27c:	ff 74 24 1c          	pushl  0x1c(%esp)
 280:	50                   	push   %eax
 281:	e8 e3 00 00 00       	call   369 <fstat>
  close(fd);
 286:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 289:	89 c6                	mov    %eax,%esi
  close(fd);
 28b:	e8 a9 00 00 00       	call   339 <close>
  return r;
 290:	83 c4 10             	add    $0x10,%esp
}
 293:	83 c4 04             	add    $0x4,%esp
 296:	89 f0                	mov    %esi,%eax
 298:	5b                   	pop    %ebx
 299:	5e                   	pop    %esi
 29a:	c3                   	ret    
 29b:	90                   	nop
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2a5:	eb ec                	jmp    293 <stat+0x33>
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	53                   	push   %ebx
 2b1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b5:	0f be 11             	movsbl (%ecx),%edx
 2b8:	8d 42 d0             	lea    -0x30(%edx),%eax
 2bb:	3c 09                	cmp    $0x9,%al
 2bd:	b8 00 00 00 00       	mov    $0x0,%eax
 2c2:	77 19                	ja     2dd <atoi+0x2d>
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2c8:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2cb:	83 c1 01             	add    $0x1,%ecx
 2ce:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2d2:	0f be 11             	movsbl (%ecx),%edx
 2d5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2d8:	80 fb 09             	cmp    $0x9,%bl
 2db:	76 eb                	jbe    2c8 <atoi+0x18>
  return n;
}
 2dd:	5b                   	pop    %ebx
 2de:	c3                   	ret    
 2df:	90                   	nop

000002e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e0:	56                   	push   %esi
 2e1:	53                   	push   %ebx
 2e2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 2e6:	8b 44 24 0c          	mov    0xc(%esp),%eax
 2ea:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ee:	85 db                	test   %ebx,%ebx
 2f0:	7e 14                	jle    306 <memmove+0x26>
 2f2:	31 d2                	xor    %edx,%edx
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2ff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 302:	39 da                	cmp    %ebx,%edx
 304:	75 f2                	jne    2f8 <memmove+0x18>
  return vdst;
}
 306:	5b                   	pop    %ebx
 307:	5e                   	pop    %esi
 308:	c3                   	ret    

00000309 <fork>:
 309:	b8 01 00 00 00       	mov    $0x1,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <exit>:
 311:	b8 02 00 00 00       	mov    $0x2,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <wait>:
 319:	b8 03 00 00 00       	mov    $0x3,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <pipe>:
 321:	b8 04 00 00 00       	mov    $0x4,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <read>:
 329:	b8 06 00 00 00       	mov    $0x6,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <write>:
 331:	b8 05 00 00 00       	mov    $0x5,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <close>:
 339:	b8 07 00 00 00       	mov    $0x7,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <kill>:
 341:	b8 08 00 00 00       	mov    $0x8,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <exec>:
 349:	b8 09 00 00 00       	mov    $0x9,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <open>:
 351:	b8 0a 00 00 00       	mov    $0xa,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <mknod>:
 359:	b8 0b 00 00 00       	mov    $0xb,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <unlink>:
 361:	b8 0c 00 00 00       	mov    $0xc,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <fstat>:
 369:	b8 0d 00 00 00       	mov    $0xd,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <link>:
 371:	b8 0e 00 00 00       	mov    $0xe,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <mkdir>:
 379:	b8 0f 00 00 00       	mov    $0xf,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <chdir>:
 381:	b8 10 00 00 00       	mov    $0x10,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <dup>:
 389:	b8 11 00 00 00       	mov    $0x11,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <getpid>:
 391:	b8 12 00 00 00       	mov    $0x12,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <sbrk>:
 399:	b8 13 00 00 00       	mov    $0x13,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <sleep>:
 3a1:	b8 14 00 00 00       	mov    $0x14,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    
 3a9:	66 90                	xchg   %ax,%ax
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	57                   	push   %edi
 3b2:	89 c7                	mov    %eax,%edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b9:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 3bd:	85 db                	test   %ebx,%ebx
 3bf:	74 7f                	je     440 <printint+0x90>
 3c1:	89 d0                	mov    %edx,%eax
 3c3:	c1 e8 1f             	shr    $0x1f,%eax
 3c6:	84 c0                	test   %al,%al
 3c8:	74 76                	je     440 <printint+0x90>
    neg = 1;
    x = -xx;
 3ca:	89 d0                	mov    %edx,%eax
    neg = 1;
 3cc:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 3d3:	00 
    x = -xx;
 3d4:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 3d6:	31 ed                	xor    %ebp,%ebp
 3d8:	8d 74 24 1f          	lea    0x1f(%esp),%esi
 3dc:	eb 04                	jmp    3e2 <printint+0x32>
 3de:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 3e0:	89 dd                	mov    %ebx,%ebp
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	8d 5d 01             	lea    0x1(%ebp),%ebx
 3e7:	f7 f1                	div    %ecx
 3e9:	0f b6 92 98 07 00 00 	movzbl 0x798(%edx),%edx
  }while((x /= base) != 0);
 3f0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3f2:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 3f5:	75 e9                	jne    3e0 <printint+0x30>
  if(neg)
 3f7:	8b 44 24 0c          	mov    0xc(%esp),%eax
 3fb:	85 c0                	test   %eax,%eax
 3fd:	74 08                	je     407 <printint+0x57>
    buf[i++] = '-';
 3ff:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
 404:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
 407:	83 eb 01             	sub    $0x1,%ebx
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 410:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
 415:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 418:	83 eb 01             	sub    $0x1,%ebx
 41b:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
 41f:	6a 01                	push   $0x1
 421:	56                   	push   %esi
 422:	57                   	push   %edi
 423:	e8 09 ff ff ff       	call   331 <write>
  while(--i >= 0)
 428:	83 c4 10             	add    $0x10,%esp
 42b:	83 fb ff             	cmp    $0xffffffff,%ebx
 42e:	75 e0                	jne    410 <printint+0x60>
    putc(fd, buf[i]);
}
 430:	83 c4 3c             	add    $0x3c,%esp
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5f                   	pop    %edi
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
 440:	89 d0                	mov    %edx,%eax
  neg = 0;
 442:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 449:	00 
 44a:	eb 8a                	jmp    3d6 <printint+0x26>
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	57                   	push   %edi
 452:	56                   	push   %esi
 453:	53                   	push   %ebx
 454:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 457:	8b 74 24 44          	mov    0x44(%esp),%esi
 45b:	8d 44 24 48          	lea    0x48(%esp),%eax
{
 45f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
 463:	89 44 24 0c          	mov    %eax,0xc(%esp)
 467:	0f b6 1e             	movzbl (%esi),%ebx
 46a:	83 c6 01             	add    $0x1,%esi
 46d:	84 db                	test   %bl,%bl
 46f:	0f 84 ad 00 00 00    	je     522 <printf+0xd2>
 475:	31 ed                	xor    %ebp,%ebp
 477:	eb 32                	jmp    4ab <printf+0x5b>
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 480:	83 f8 25             	cmp    $0x25,%eax
 483:	0f 84 a7 00 00 00    	je     530 <printf+0xe0>
 489:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
 48d:	83 ec 04             	sub    $0x4,%esp
 490:	6a 01                	push   $0x1
 492:	8d 44 24 22          	lea    0x22(%esp),%eax
 496:	50                   	push   %eax
 497:	57                   	push   %edi
 498:	e8 94 fe ff ff       	call   331 <write>
 49d:	83 c4 10             	add    $0x10,%esp
 4a0:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4a3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4a7:	84 db                	test   %bl,%bl
 4a9:	74 77                	je     522 <printf+0xd2>
    if(state == 0){
 4ab:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
 4ad:	0f be cb             	movsbl %bl,%ecx
 4b0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4b3:	74 cb                	je     480 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b5:	83 fd 25             	cmp    $0x25,%ebp
 4b8:	75 e6                	jne    4a0 <printf+0x50>
      if(c == 'd'){
 4ba:	83 f8 64             	cmp    $0x64,%eax
 4bd:	0f 84 0d 01 00 00    	je     5d0 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4c3:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4c9:	83 f9 70             	cmp    $0x70,%ecx
 4cc:	74 72                	je     540 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ce:	83 f8 73             	cmp    $0x73,%eax
 4d1:	0f 84 99 00 00 00    	je     570 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4d7:	83 f8 63             	cmp    $0x63,%eax
 4da:	0f 84 ff 00 00 00    	je     5df <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4e0:	83 f8 25             	cmp    $0x25,%eax
 4e3:	0f 84 cf 00 00 00    	je     5b8 <printf+0x168>
 4e9:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
 4ee:	83 ec 04             	sub    $0x4,%esp
 4f1:	6a 01                	push   $0x1
 4f3:	8d 44 24 27          	lea    0x27(%esp),%eax
 4f7:	50                   	push   %eax
 4f8:	57                   	push   %edi
 4f9:	e8 33 fe ff ff       	call   331 <write>
 4fe:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 502:	83 c4 0c             	add    $0xc,%esp
 505:	6a 01                	push   $0x1
 507:	8d 44 24 26          	lea    0x26(%esp),%eax
 50b:	50                   	push   %eax
 50c:	57                   	push   %edi
 50d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 510:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
 512:	e8 1a fe ff ff       	call   331 <write>
  for(i = 0; fmt[i]; i++){
 517:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 51b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 51e:	84 db                	test   %bl,%bl
 520:	75 89                	jne    4ab <printf+0x5b>
    }
  }
}
 522:	83 c4 2c             	add    $0x2c,%esp
 525:	5b                   	pop    %ebx
 526:	5e                   	pop    %esi
 527:	5f                   	pop    %edi
 528:	5d                   	pop    %ebp
 529:	c3                   	ret    
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 530:	bd 25 00 00 00       	mov    $0x25,%ebp
 535:	e9 66 ff ff ff       	jmp    4a0 <printf+0x50>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	b9 10 00 00 00       	mov    $0x10,%ecx
 548:	6a 00                	push   $0x0
 54a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 54e:	89 f8                	mov    %edi,%eax
 550:	8b 13                	mov    (%ebx),%edx
 552:	e8 59 fe ff ff       	call   3b0 <printint>
        ap++;
 557:	89 d8                	mov    %ebx,%eax
      state = 0;
 559:	31 ed                	xor    %ebp,%ebp
        ap++;
 55b:	83 c0 04             	add    $0x4,%eax
 55e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 562:	83 c4 10             	add    $0x10,%esp
 565:	e9 36 ff ff ff       	jmp    4a0 <printf+0x50>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 570:	8b 44 24 0c          	mov    0xc(%esp),%eax
 574:	8b 28                	mov    (%eax),%ebp
        ap++;
 576:	83 c0 04             	add    $0x4,%eax
 579:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
 57d:	85 ed                	test   %ebp,%ebp
 57f:	74 7d                	je     5fe <printf+0x1ae>
        while(*s != 0){
 581:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 585:	84 c0                	test   %al,%al
 587:	74 25                	je     5ae <printf+0x15e>
 589:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 58d:	8d 76 00             	lea    0x0(%esi),%esi
 590:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
 594:	83 ec 04             	sub    $0x4,%esp
          s++;
 597:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
 59a:	6a 01                	push   $0x1
 59c:	53                   	push   %ebx
 59d:	57                   	push   %edi
 59e:	e8 8e fd ff ff       	call   331 <write>
        while(*s != 0){
 5a3:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 5a7:	83 c4 10             	add    $0x10,%esp
 5aa:	84 c0                	test   %al,%al
 5ac:	75 e2                	jne    590 <printf+0x140>
      state = 0;
 5ae:	31 ed                	xor    %ebp,%ebp
 5b0:	e9 eb fe ff ff       	jmp    4a0 <printf+0x50>
 5b5:	8d 76 00             	lea    0x0(%esi),%esi
 5b8:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
 5bc:	83 ec 04             	sub    $0x4,%esp
 5bf:	6a 01                	push   $0x1
 5c1:	8d 44 24 25          	lea    0x25(%esp),%eax
 5c5:	e9 41 ff ff ff       	jmp    50b <printf+0xbb>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	e9 6b ff ff ff       	jmp    54a <printf+0xfa>
        putc(fd, *ap);
 5df:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 03                	mov    (%ebx),%eax
 5e8:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
 5ec:	6a 01                	push   $0x1
 5ee:	8d 44 24 24          	lea    0x24(%esp),%eax
 5f2:	50                   	push   %eax
 5f3:	57                   	push   %edi
 5f4:	e8 38 fd ff ff       	call   331 <write>
 5f9:	e9 59 ff ff ff       	jmp    557 <printf+0x107>
        while(*s != 0){
 5fe:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 603:	bd 8e 07 00 00       	mov    $0x78e,%ebp
 608:	e9 7c ff ff ff       	jmp    589 <printf+0x139>
 60d:	66 90                	xchg   %ax,%ax
 60f:	90                   	nop

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	57                   	push   %edi
 611:	56                   	push   %esi
 612:	53                   	push   %ebx
 613:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 617:	a1 40 0b 00 00       	mov    0xb40,%eax
  bp = (Header*) ap - 1;
 61c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61f:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	39 c8                	cmp    %ecx,%eax
 623:	73 13                	jae    638 <free+0x28>
 625:	8d 76 00             	lea    0x0(%esi),%esi
 628:	39 d1                	cmp    %edx,%ecx
 62a:	72 14                	jb     640 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	39 d0                	cmp    %edx,%eax
 62e:	73 10                	jae    640 <free+0x30>
{
 630:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 632:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 634:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 636:	72 f0                	jb     628 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	39 d0                	cmp    %edx,%eax
 63a:	72 f4                	jb     630 <free+0x20>
 63c:	39 d1                	cmp    %edx,%ecx
 63e:	73 f0                	jae    630 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 640:	8b 73 fc             	mov    -0x4(%ebx),%esi
 643:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 646:	39 fa                	cmp    %edi,%edx
 648:	74 18                	je     662 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 64a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	74 22                	je     679 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 657:	89 08                	mov    %ecx,(%eax)
  freep = p;
 659:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 65e:	5b                   	pop    %ebx
 65f:	5e                   	pop    %esi
 660:	5f                   	pop    %edi
 661:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 662:	03 72 04             	add    0x4(%edx),%esi
 665:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 10                	mov    (%eax),%edx
 66a:	8b 12                	mov    (%edx),%edx
 66c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 66f:	8b 50 04             	mov    0x4(%eax),%edx
 672:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 675:	39 f1                	cmp    %esi,%ecx
 677:	75 de                	jne    657 <free+0x47>
    p->s.size += bp->s.size;
 679:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 67c:	a3 40 0b 00 00       	mov    %eax,0xb40
    p->s.size += bp->s.size;
 681:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 684:	8b 53 f8             	mov    -0x8(%ebx),%edx
 687:	89 10                	mov    %edx,(%eax)
}
 689:	5b                   	pop    %ebx
 68a:	5e                   	pop    %esi
 68b:	5f                   	pop    %edi
 68c:	c3                   	ret    
 68d:	8d 76 00             	lea    0x0(%esi),%esi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	57                   	push   %edi
 691:	56                   	push   %esi
 692:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 693:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 697:	8b 15 40 0b 00 00    	mov    0xb40,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 69d:	8d 78 07             	lea    0x7(%eax),%edi
 6a0:	c1 ef 03             	shr    $0x3,%edi
 6a3:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6a6:	85 d2                	test   %edx,%edx
 6a8:	0f 84 90 00 00 00    	je     73e <malloc+0xae>
 6ae:	8b 02                	mov    (%edx),%eax
 6b0:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b3:	39 cf                	cmp    %ecx,%edi
 6b5:	76 61                	jbe    718 <malloc+0x88>
 6b7:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6bd:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c2:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6c5:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6cc:	eb 0b                	jmp    6d9 <malloc+0x49>
 6ce:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d2:	8b 48 04             	mov    0x4(%eax),%ecx
 6d5:	39 cf                	cmp    %ecx,%edi
 6d7:	76 3f                	jbe    718 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 6d9:	39 05 40 0b 00 00    	cmp    %eax,0xb40
 6df:	89 c2                	mov    %eax,%edx
 6e1:	75 ed                	jne    6d0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 6e3:	83 ec 0c             	sub    $0xc,%esp
 6e6:	56                   	push   %esi
 6e7:	e8 ad fc ff ff       	call   399 <sbrk>
  if(p == (char*) -1)
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 6f2:	74 1c                	je     710 <malloc+0x80>
  hp->s.size = nu;
 6f4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6f7:	83 ec 0c             	sub    $0xc,%esp
 6fa:	83 c0 08             	add    $0x8,%eax
 6fd:	50                   	push   %eax
 6fe:	e8 0d ff ff ff       	call   610 <free>
  return freep;
 703:	8b 15 40 0b 00 00    	mov    0xb40,%edx
      if((p = morecore(nunits)) == 0)
 709:	83 c4 10             	add    $0x10,%esp
 70c:	85 d2                	test   %edx,%edx
 70e:	75 c0                	jne    6d0 <malloc+0x40>
        return 0;
 710:	31 c0                	xor    %eax,%eax
 712:	eb 1c                	jmp    730 <malloc+0xa0>
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 718:	39 cf                	cmp    %ecx,%edi
 71a:	74 1c                	je     738 <malloc+0xa8>
        p->s.size -= nunits;
 71c:	29 f9                	sub    %edi,%ecx
 71e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 721:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 724:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 727:	89 15 40 0b 00 00    	mov    %edx,0xb40
      return (void*) (p + 1);
 72d:	83 c0 08             	add    $0x8,%eax
  }
}
 730:	5b                   	pop    %ebx
 731:	5e                   	pop    %esi
 732:	5f                   	pop    %edi
 733:	c3                   	ret    
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 738:	8b 08                	mov    (%eax),%ecx
 73a:	89 0a                	mov    %ecx,(%edx)
 73c:	eb e9                	jmp    727 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
 73e:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 745:	0b 00 00 
 748:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 74f:	0b 00 00 
    base.s.size = 0;
 752:	b8 44 0b 00 00       	mov    $0xb44,%eax
 757:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 75e:	00 00 00 
 761:	e9 51 ff ff ff       	jmp    6b7 <malloc+0x27>

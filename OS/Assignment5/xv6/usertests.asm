
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "fork test OK\n");
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 07 3b 00 00       	push   $0x3b07
      16:	6a 01                	push   $0x1
      18:	e8 23 2b 00 00       	call   2b40 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 1b 3b 00 00       	push   $0x3b1b
      26:	e8 16 2a 00 00       	call   2a41 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 68 40 00 00       	push   $0x4068
      3a:	6a 01                	push   $0x1
      3c:	e8 ff 2a 00 00       	call   2b40 <printf>
    exit();
      41:	e8 bb 29 00 00       	call   2a01 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 1b 3b 00 00       	push   $0x3b1b
      52:	e8 ea 29 00 00       	call   2a41 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 ca 29 00 00       	call   2a29 <close>

  opentest();
      5f:	e8 7c 00 00 00       	call   e0 <opentest>
  writetest();
      64:	e8 07 01 00 00       	call   170 <writetest>
  writetest1();
      69:	e8 e2 02 00 00       	call   350 <writetest1>
  createtest();
      6e:	e8 9d 04 00 00       	call   510 <createtest>

  mem();
      73:	e8 c8 09 00 00       	call   a40 <mem>
  pipe1();
      78:	e8 73 06 00 00       	call   6f0 <pipe1>
  preempt();
      7d:	e8 fe 07 00 00       	call   880 <preempt>
  exitwait();
      82:	e8 39 09 00 00       	call   9c0 <exitwait>

  rmdot();
      87:	e8 04 22 00 00       	call   2290 <rmdot>
  fourteen();
      8c:	e8 cf 20 00 00       	call   2160 <fourteen>
  bigfile();
      91:	e8 0a 1f 00 00       	call   1fa0 <bigfile>
  subdir();
      96:	e8 25 18 00 00       	call   18c0 <subdir>
  concreate();
      9b:	e8 10 14 00 00       	call   14b0 <concreate>
  linktest();
      a0:	e8 fb 11 00 00       	call   12a0 <linktest>
  unlinkread();
      a5:	e8 66 10 00 00       	call   1110 <unlinkread>
  createdelete();
      aa:	e8 11 0e 00 00       	call   ec0 <createdelete>
  twofiles();
      af:	e8 ec 0b 00 00       	call   ca0 <twofiles>
  sharedfd();
      b4:	e8 37 0a 00 00       	call   af0 <sharedfd>
  dirfile();
      b9:	e8 42 23 00 00       	call   2400 <dirfile>
  iref();
      be:	e8 3d 25 00 00       	call   2600 <iref>
  forktest();
      c3:	e8 58 26 00 00       	call   2720 <forktest>
  bigdir(); // slow
      c8:	e8 b3 16 00 00       	call   1780 <bigdir>

  exectest();
      cd:	e8 ce 05 00 00       	call   6a0 <exectest>

  exit();
      d2:	e8 2a 29 00 00       	call   2a01 <exit>
      d7:	66 90                	xchg   %ax,%ax
      d9:	66 90                	xchg   %ax,%ax
      db:	66 90                	xchg   %ax,%ax
      dd:	66 90                	xchg   %ax,%ax
      df:	90                   	nop

000000e0 <opentest>:
{
      e0:	83 ec 14             	sub    $0x14,%esp
  printf(stdout, "open test\n");
      e3:	68 58 2e 00 00       	push   $0x2e58
      e8:	ff 35 a8 59 00 00    	pushl  0x59a8
      ee:	e8 4d 2a 00 00       	call   2b40 <printf>
  fd = open("echo", 0);
      f3:	58                   	pop    %eax
      f4:	5a                   	pop    %edx
      f5:	6a 00                	push   $0x0
      f7:	68 63 2e 00 00       	push   $0x2e63
      fc:	e8 40 29 00 00       	call   2a41 <open>
  if(fd < 0){
     101:	83 c4 10             	add    $0x10,%esp
     104:	85 c0                	test   %eax,%eax
     106:	78 35                	js     13d <opentest+0x5d>
  close(fd);
     108:	83 ec 0c             	sub    $0xc,%esp
     10b:	50                   	push   %eax
     10c:	e8 18 29 00 00       	call   2a29 <close>
  fd = open("doesnotexist", 0);
     111:	5a                   	pop    %edx
     112:	59                   	pop    %ecx
     113:	6a 00                	push   $0x0
     115:	68 7b 2e 00 00       	push   $0x2e7b
     11a:	e8 22 29 00 00       	call   2a41 <open>
  if(fd >= 0){
     11f:	83 c4 10             	add    $0x10,%esp
     122:	85 c0                	test   %eax,%eax
     124:	79 2e                	jns    154 <opentest+0x74>
  printf(stdout, "open test ok\n");
     126:	83 ec 08             	sub    $0x8,%esp
     129:	68 a6 2e 00 00       	push   $0x2ea6
     12e:	ff 35 a8 59 00 00    	pushl  0x59a8
     134:	e8 07 2a 00 00       	call   2b40 <printf>
}
     139:	83 c4 1c             	add    $0x1c,%esp
     13c:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     13d:	50                   	push   %eax
     13e:	50                   	push   %eax
     13f:	68 68 2e 00 00       	push   $0x2e68
     144:	ff 35 a8 59 00 00    	pushl  0x59a8
     14a:	e8 f1 29 00 00       	call   2b40 <printf>
    exit();
     14f:	e8 ad 28 00 00       	call   2a01 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     154:	50                   	push   %eax
     155:	50                   	push   %eax
     156:	68 88 2e 00 00       	push   $0x2e88
     15b:	ff 35 a8 59 00 00    	pushl  0x59a8
     161:	e8 da 29 00 00       	call   2b40 <printf>
    exit();
     166:	e8 96 28 00 00       	call   2a01 <exit>
     16b:	90                   	nop
     16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <writetest>:
{
     170:	56                   	push   %esi
     171:	53                   	push   %ebx
     172:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "small file test\n");
     175:	68 b4 2e 00 00       	push   $0x2eb4
     17a:	ff 35 a8 59 00 00    	pushl  0x59a8
     180:	e8 bb 29 00 00       	call   2b40 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     185:	59                   	pop    %ecx
     186:	5b                   	pop    %ebx
     187:	68 02 02 00 00       	push   $0x202
     18c:	68 c5 2e 00 00       	push   $0x2ec5
     191:	e8 ab 28 00 00       	call   2a41 <open>
  if(fd >= 0){
     196:	83 c4 10             	add    $0x10,%esp
     199:	85 c0                	test   %eax,%eax
     19b:	0f 88 8a 01 00 00    	js     32b <writetest+0x1bb>
    printf(stdout, "creat small succeeded; ok\n");
     1a1:	83 ec 08             	sub    $0x8,%esp
     1a4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++) {
     1a6:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     1a8:	68 cb 2e 00 00       	push   $0x2ecb
     1ad:	ff 35 a8 59 00 00    	pushl  0x59a8
     1b3:	e8 88 29 00 00       	call   2b40 <printf>
     1b8:	83 c4 10             	add    $0x10,%esp
     1bb:	90                   	nop
     1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
     1c0:	83 ec 04             	sub    $0x4,%esp
     1c3:	6a 0a                	push   $0xa
     1c5:	68 02 2f 00 00       	push   $0x2f02
     1ca:	56                   	push   %esi
     1cb:	e8 51 28 00 00       	call   2a21 <write>
     1d0:	83 c4 10             	add    $0x10,%esp
     1d3:	83 f8 0a             	cmp    $0xa,%eax
     1d6:	0f 85 d5 00 00 00    	jne    2b1 <writetest+0x141>
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
     1dc:	83 ec 04             	sub    $0x4,%esp
     1df:	6a 0a                	push   $0xa
     1e1:	68 0d 2f 00 00       	push   $0x2f0d
     1e6:	56                   	push   %esi
     1e7:	e8 35 28 00 00       	call   2a21 <write>
     1ec:	83 c4 10             	add    $0x10,%esp
     1ef:	83 f8 0a             	cmp    $0xa,%eax
     1f2:	0f 85 d2 00 00 00    	jne    2ca <writetest+0x15a>
  for(i = 0; i < 100; i++) {
     1f8:	83 c3 01             	add    $0x1,%ebx
     1fb:	83 fb 64             	cmp    $0x64,%ebx
     1fe:	75 c0                	jne    1c0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     200:	83 ec 08             	sub    $0x8,%esp
     203:	68 18 2f 00 00       	push   $0x2f18
     208:	ff 35 a8 59 00 00    	pushl  0x59a8
     20e:	e8 2d 29 00 00       	call   2b40 <printf>
  close(fd);
     213:	89 34 24             	mov    %esi,(%esp)
     216:	e8 0e 28 00 00       	call   2a29 <close>
  fd = open("small", O_RDONLY);
     21b:	58                   	pop    %eax
     21c:	5a                   	pop    %edx
     21d:	6a 00                	push   $0x0
     21f:	68 c5 2e 00 00       	push   $0x2ec5
     224:	e8 18 28 00 00       	call   2a41 <open>
  if(fd >= 0){
     229:	83 c4 10             	add    $0x10,%esp
     22c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     22e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     230:	0f 88 ad 00 00 00    	js     2e3 <writetest+0x173>
    printf(stdout, "open small succeeded ok\n");
     236:	83 ec 08             	sub    $0x8,%esp
     239:	68 23 2f 00 00       	push   $0x2f23
     23e:	ff 35 a8 59 00 00    	pushl  0x59a8
     244:	e8 f7 28 00 00       	call   2b40 <printf>
  i = read(fd, buf, 2000);
     249:	83 c4 0c             	add    $0xc,%esp
     24c:	68 d0 07 00 00       	push   $0x7d0
     251:	68 e0 59 00 00       	push   $0x59e0
     256:	53                   	push   %ebx
     257:	e8 bd 27 00 00       	call   2a19 <read>
  if(i == 2000) {
     25c:	83 c4 10             	add    $0x10,%esp
     25f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     264:	0f 85 91 00 00 00    	jne    2fb <writetest+0x18b>
    printf(stdout, "read succeeded ok\n");
     26a:	83 ec 08             	sub    $0x8,%esp
     26d:	68 57 2f 00 00       	push   $0x2f57
     272:	ff 35 a8 59 00 00    	pushl  0x59a8
     278:	e8 c3 28 00 00       	call   2b40 <printf>
  close(fd);
     27d:	89 1c 24             	mov    %ebx,(%esp)
     280:	e8 a4 27 00 00       	call   2a29 <close>
  if(unlink("small") < 0) {
     285:	c7 04 24 c5 2e 00 00 	movl   $0x2ec5,(%esp)
     28c:	e8 c0 27 00 00       	call   2a51 <unlink>
     291:	83 c4 10             	add    $0x10,%esp
     294:	85 c0                	test   %eax,%eax
     296:	78 7b                	js     313 <writetest+0x1a3>
  printf(stdout, "small file test ok\n");
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 7f 2f 00 00       	push   $0x2f7f
     2a0:	ff 35 a8 59 00 00    	pushl  0x59a8
     2a6:	e8 95 28 00 00       	call   2b40 <printf>
}
     2ab:	83 c4 14             	add    $0x14,%esp
     2ae:	5b                   	pop    %ebx
     2af:	5e                   	pop    %esi
     2b0:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     2b1:	83 ec 04             	sub    $0x4,%esp
     2b4:	53                   	push   %ebx
     2b5:	68 3c 3b 00 00       	push   $0x3b3c
     2ba:	ff 35 a8 59 00 00    	pushl  0x59a8
     2c0:	e8 7b 28 00 00       	call   2b40 <printf>
      exit();
     2c5:	e8 37 27 00 00       	call   2a01 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     2ca:	83 ec 04             	sub    $0x4,%esp
     2cd:	53                   	push   %ebx
     2ce:	68 60 3b 00 00       	push   $0x3b60
     2d3:	ff 35 a8 59 00 00    	pushl  0x59a8
     2d9:	e8 62 28 00 00       	call   2b40 <printf>
      exit();
     2de:	e8 1e 27 00 00       	call   2a01 <exit>
    printf(stdout, "error: open small failed!\n");
     2e3:	83 ec 08             	sub    $0x8,%esp
     2e6:	68 3c 2f 00 00       	push   $0x2f3c
     2eb:	ff 35 a8 59 00 00    	pushl  0x59a8
     2f1:	e8 4a 28 00 00       	call   2b40 <printf>
    exit();
     2f6:	e8 06 27 00 00       	call   2a01 <exit>
    printf(stdout, "read failed\n");
     2fb:	83 ec 08             	sub    $0x8,%esp
     2fe:	68 7d 32 00 00       	push   $0x327d
     303:	ff 35 a8 59 00 00    	pushl  0x59a8
     309:	e8 32 28 00 00       	call   2b40 <printf>
    exit();
     30e:	e8 ee 26 00 00       	call   2a01 <exit>
    printf(stdout, "unlink small failed\n");
     313:	83 ec 08             	sub    $0x8,%esp
     316:	68 6a 2f 00 00       	push   $0x2f6a
     31b:	ff 35 a8 59 00 00    	pushl  0x59a8
     321:	e8 1a 28 00 00       	call   2b40 <printf>
    exit();
     326:	e8 d6 26 00 00       	call   2a01 <exit>
    printf(stdout, "error: creat small failed!\n");
     32b:	83 ec 08             	sub    $0x8,%esp
     32e:	68 e6 2e 00 00       	push   $0x2ee6
     333:	ff 35 a8 59 00 00    	pushl  0x59a8
     339:	e8 02 28 00 00       	call   2b40 <printf>
    exit();
     33e:	e8 be 26 00 00       	call   2a01 <exit>
     343:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <writetest1>:
{
     350:	56                   	push   %esi
     351:	53                   	push   %ebx
     352:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "big files test\n");
     355:	68 93 2f 00 00       	push   $0x2f93
     35a:	ff 35 a8 59 00 00    	pushl  0x59a8
     360:	e8 db 27 00 00       	call   2b40 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     365:	59                   	pop    %ecx
     366:	5b                   	pop    %ebx
     367:	68 02 02 00 00       	push   $0x202
     36c:	68 0d 30 00 00       	push   $0x300d
     371:	e8 cb 26 00 00       	call   2a41 <open>
  if(fd < 0){
     376:	83 c4 10             	add    $0x10,%esp
     379:	85 c0                	test   %eax,%eax
     37b:	0f 88 5b 01 00 00    	js     4dc <writetest1+0x18c>
     381:	89 c6                	mov    %eax,%esi
     383:	31 db                	xor    %ebx,%ebx
     385:	8d 76 00             	lea    0x0(%esi),%esi
    if(write(fd, buf, 512) != 512) {
     388:	83 ec 04             	sub    $0x4,%esp
    ((int*) buf)[0] = i;
     38b:	89 1d e0 59 00 00    	mov    %ebx,0x59e0
    if(write(fd, buf, 512) != 512) {
     391:	68 00 02 00 00       	push   $0x200
     396:	68 e0 59 00 00       	push   $0x59e0
     39b:	56                   	push   %esi
     39c:	e8 80 26 00 00       	call   2a21 <write>
     3a1:	83 c4 10             	add    $0x10,%esp
     3a4:	3d 00 02 00 00       	cmp    $0x200,%eax
     3a9:	0f 85 af 00 00 00    	jne    45e <writetest1+0x10e>
  for(i = 0; i < MAXFILE; i++) {
     3af:	83 c3 01             	add    $0x1,%ebx
     3b2:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     3b8:	75 ce                	jne    388 <writetest1+0x38>
  close(fd);
     3ba:	83 ec 0c             	sub    $0xc,%esp
     3bd:	56                   	push   %esi
     3be:	e8 66 26 00 00       	call   2a29 <close>
  fd = open("big", O_RDONLY);
     3c3:	58                   	pop    %eax
     3c4:	5a                   	pop    %edx
     3c5:	6a 00                	push   $0x0
     3c7:	68 0d 30 00 00       	push   $0x300d
     3cc:	e8 70 26 00 00       	call   2a41 <open>
  if(fd < 0){
     3d1:	83 c4 10             	add    $0x10,%esp
     3d4:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     3d6:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     3d8:	0f 88 e6 00 00 00    	js     4c4 <writetest1+0x174>
     3de:	31 db                	xor    %ebx,%ebx
     3e0:	eb 1d                	jmp    3ff <writetest1+0xaf>
     3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512) {
     3e8:	3d 00 02 00 00       	cmp    $0x200,%eax
     3ed:	0f 85 9b 00 00 00    	jne    48e <writetest1+0x13e>
    if(((int*)buf)[0] != n) {
     3f3:	a1 e0 59 00 00       	mov    0x59e0,%eax
     3f8:	39 c3                	cmp    %eax,%ebx
     3fa:	75 7b                	jne    477 <writetest1+0x127>
    n++;
     3fc:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
     3ff:	83 ec 04             	sub    $0x4,%esp
     402:	68 00 02 00 00       	push   $0x200
     407:	68 e0 59 00 00       	push   $0x59e0
     40c:	56                   	push   %esi
     40d:	e8 07 26 00 00       	call   2a19 <read>
    if(i == 0) {
     412:	83 c4 10             	add    $0x10,%esp
     415:	85 c0                	test   %eax,%eax
     417:	75 cf                	jne    3e8 <writetest1+0x98>
      if(n == MAXFILE - 1) {
     419:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     41f:	0f 84 82 00 00 00    	je     4a7 <writetest1+0x157>
  close(fd);
     425:	83 ec 0c             	sub    $0xc,%esp
     428:	56                   	push   %esi
     429:	e8 fb 25 00 00       	call   2a29 <close>
  if(unlink("big") < 0) {
     42e:	c7 04 24 0d 30 00 00 	movl   $0x300d,(%esp)
     435:	e8 17 26 00 00       	call   2a51 <unlink>
     43a:	83 c4 10             	add    $0x10,%esp
     43d:	85 c0                	test   %eax,%eax
     43f:	0f 88 af 00 00 00    	js     4f4 <writetest1+0x1a4>
  printf(stdout, "big files ok\n");
     445:	83 ec 08             	sub    $0x8,%esp
     448:	68 34 30 00 00       	push   $0x3034
     44d:	ff 35 a8 59 00 00    	pushl  0x59a8
     453:	e8 e8 26 00 00       	call   2b40 <printf>
}
     458:	83 c4 14             	add    $0x14,%esp
     45b:	5b                   	pop    %ebx
     45c:	5e                   	pop    %esi
     45d:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     45e:	83 ec 04             	sub    $0x4,%esp
     461:	53                   	push   %ebx
     462:	68 bd 2f 00 00       	push   $0x2fbd
     467:	ff 35 a8 59 00 00    	pushl  0x59a8
     46d:	e8 ce 26 00 00       	call   2b40 <printf>
      exit();
     472:	e8 8a 25 00 00       	call   2a01 <exit>
      printf(stdout, "read content of block %d is %d\n",
     477:	50                   	push   %eax
     478:	53                   	push   %ebx
     479:	68 84 3b 00 00       	push   $0x3b84
     47e:	ff 35 a8 59 00 00    	pushl  0x59a8
     484:	e8 b7 26 00 00       	call   2b40 <printf>
      exit();
     489:	e8 73 25 00 00       	call   2a01 <exit>
      printf(stdout, "read failed %d\n", i);
     48e:	83 ec 04             	sub    $0x4,%esp
     491:	50                   	push   %eax
     492:	68 11 30 00 00       	push   $0x3011
     497:	ff 35 a8 59 00 00    	pushl  0x59a8
     49d:	e8 9e 26 00 00       	call   2b40 <printf>
      exit();
     4a2:	e8 5a 25 00 00       	call   2a01 <exit>
        printf(stdout, "read only %d blocks from big", n);
     4a7:	83 ec 04             	sub    $0x4,%esp
     4aa:	68 8b 00 00 00       	push   $0x8b
     4af:	68 f4 2f 00 00       	push   $0x2ff4
     4b4:	ff 35 a8 59 00 00    	pushl  0x59a8
     4ba:	e8 81 26 00 00       	call   2b40 <printf>
        exit();
     4bf:	e8 3d 25 00 00       	call   2a01 <exit>
    printf(stdout, "error: open big failed!\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	68 db 2f 00 00       	push   $0x2fdb
     4cc:	ff 35 a8 59 00 00    	pushl  0x59a8
     4d2:	e8 69 26 00 00       	call   2b40 <printf>
    exit();
     4d7:	e8 25 25 00 00       	call   2a01 <exit>
    printf(stdout, "error: creat big failed!\n");
     4dc:	83 ec 08             	sub    $0x8,%esp
     4df:	68 a3 2f 00 00       	push   $0x2fa3
     4e4:	ff 35 a8 59 00 00    	pushl  0x59a8
     4ea:	e8 51 26 00 00       	call   2b40 <printf>
    exit();
     4ef:	e8 0d 25 00 00       	call   2a01 <exit>
    printf(stdout, "unlink big failed\n");
     4f4:	83 ec 08             	sub    $0x8,%esp
     4f7:	68 21 30 00 00       	push   $0x3021
     4fc:	ff 35 a8 59 00 00    	pushl  0x59a8
     502:	e8 39 26 00 00       	call   2b40 <printf>
    exit();
     507:	e8 f5 24 00 00       	call   2a01 <exit>
     50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000510 <createtest>:
{
     510:	53                   	push   %ebx
  name[2] = '\0';
     511:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     516:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     519:	68 a4 3b 00 00       	push   $0x3ba4
     51e:	ff 35 a8 59 00 00    	pushl  0x59a8
     524:	e8 17 26 00 00       	call   2b40 <printf>
  name[0] = 'a';
     529:	c6 05 e0 61 00 00 61 	movb   $0x61,0x61e0
  name[2] = '\0';
     530:	c6 05 e2 61 00 00 00 	movb   $0x0,0x61e2
     537:	83 c4 10             	add    $0x10,%esp
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     540:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     543:	88 1d e1 61 00 00    	mov    %bl,0x61e1
     549:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     54c:	68 02 02 00 00       	push   $0x202
     551:	68 e0 61 00 00       	push   $0x61e0
     556:	e8 e6 24 00 00       	call   2a41 <open>
    close(fd);
     55b:	89 04 24             	mov    %eax,(%esp)
     55e:	e8 c6 24 00 00       	call   2a29 <close>
  for(i = 0; i < 52; i++) {
     563:	83 c4 10             	add    $0x10,%esp
     566:	80 fb 64             	cmp    $0x64,%bl
     569:	75 d5                	jne    540 <createtest+0x30>
  name[0] = 'a';
     56b:	c6 05 e0 61 00 00 61 	movb   $0x61,0x61e0
  name[2] = '\0';
     572:	c6 05 e2 61 00 00 00 	movb   $0x0,0x61e2
     579:	bb 30 00 00 00       	mov    $0x30,%ebx
     57e:	66 90                	xchg   %ax,%ax
    unlink(name);
     580:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     583:	88 1d e1 61 00 00    	mov    %bl,0x61e1
     589:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     58c:	68 e0 61 00 00       	push   $0x61e0
     591:	e8 bb 24 00 00       	call   2a51 <unlink>
  for(i = 0; i < 52; i++) {
     596:	83 c4 10             	add    $0x10,%esp
     599:	80 fb 64             	cmp    $0x64,%bl
     59c:	75 e2                	jne    580 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     59e:	83 ec 08             	sub    $0x8,%esp
     5a1:	68 cc 3b 00 00       	push   $0x3bcc
     5a6:	ff 35 a8 59 00 00    	pushl  0x59a8
     5ac:	e8 8f 25 00 00       	call   2b40 <printf>
}
     5b1:	83 c4 18             	add    $0x18,%esp
     5b4:	5b                   	pop    %ebx
     5b5:	c3                   	ret    
     5b6:	8d 76 00             	lea    0x0(%esi),%esi
     5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005c0 <dirtest>:
{
     5c0:	83 ec 14             	sub    $0x14,%esp
  printf(stdout, "mkdir test\n");
     5c3:	68 42 30 00 00       	push   $0x3042
     5c8:	ff 35 a8 59 00 00    	pushl  0x59a8
     5ce:	e8 6d 25 00 00       	call   2b40 <printf>
  if(mkdir("dir0") < 0) {
     5d3:	c7 04 24 4e 30 00 00 	movl   $0x304e,(%esp)
     5da:	e8 8a 24 00 00       	call   2a69 <mkdir>
     5df:	83 c4 10             	add    $0x10,%esp
     5e2:	85 c0                	test   %eax,%eax
     5e4:	78 57                	js     63d <dirtest+0x7d>
  if(chdir("dir0") < 0) {
     5e6:	83 ec 0c             	sub    $0xc,%esp
     5e9:	68 4e 30 00 00       	push   $0x304e
     5ee:	e8 7e 24 00 00       	call   2a71 <chdir>
     5f3:	83 c4 10             	add    $0x10,%esp
     5f6:	85 c0                	test   %eax,%eax
     5f8:	0f 88 84 00 00 00    	js     682 <dirtest+0xc2>
  if(chdir("..") < 0) {
     5fe:	83 ec 0c             	sub    $0xc,%esp
     601:	68 c9 35 00 00       	push   $0x35c9
     606:	e8 66 24 00 00       	call   2a71 <chdir>
     60b:	83 c4 10             	add    $0x10,%esp
     60e:	85 c0                	test   %eax,%eax
     610:	78 59                	js     66b <dirtest+0xab>
  if(unlink("dir0") < 0) {
     612:	83 ec 0c             	sub    $0xc,%esp
     615:	68 4e 30 00 00       	push   $0x304e
     61a:	e8 32 24 00 00       	call   2a51 <unlink>
     61f:	83 c4 10             	add    $0x10,%esp
     622:	85 c0                	test   %eax,%eax
     624:	78 2e                	js     654 <dirtest+0x94>
  printf(stdout, "mkdir test\n");
     626:	83 ec 08             	sub    $0x8,%esp
     629:	68 42 30 00 00       	push   $0x3042
     62e:	ff 35 a8 59 00 00    	pushl  0x59a8
     634:	e8 07 25 00 00       	call   2b40 <printf>
}
     639:	83 c4 1c             	add    $0x1c,%esp
     63c:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     63d:	50                   	push   %eax
     63e:	50                   	push   %eax
     63f:	68 53 30 00 00       	push   $0x3053
     644:	ff 35 a8 59 00 00    	pushl  0x59a8
     64a:	e8 f1 24 00 00       	call   2b40 <printf>
    exit();
     64f:	e8 ad 23 00 00       	call   2a01 <exit>
    printf(stdout, "unlink dir0 failed\n");
     654:	50                   	push   %eax
     655:	50                   	push   %eax
     656:	68 85 30 00 00       	push   $0x3085
     65b:	ff 35 a8 59 00 00    	pushl  0x59a8
     661:	e8 da 24 00 00       	call   2b40 <printf>
    exit();
     666:	e8 96 23 00 00       	call   2a01 <exit>
    printf(stdout, "chdir .. failed\n");
     66b:	52                   	push   %edx
     66c:	52                   	push   %edx
     66d:	68 74 30 00 00       	push   $0x3074
     672:	ff 35 a8 59 00 00    	pushl  0x59a8
     678:	e8 c3 24 00 00       	call   2b40 <printf>
    exit();
     67d:	e8 7f 23 00 00       	call   2a01 <exit>
    printf(stdout, "chdir dir0 failed\n");
     682:	51                   	push   %ecx
     683:	51                   	push   %ecx
     684:	68 61 30 00 00       	push   $0x3061
     689:	ff 35 a8 59 00 00    	pushl  0x59a8
     68f:	e8 ac 24 00 00       	call   2b40 <printf>
    exit();
     694:	e8 68 23 00 00       	call   2a01 <exit>
     699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006a0 <exectest>:
{
     6a0:	83 ec 14             	sub    $0x14,%esp
  printf(stdout, "exec test\n");
     6a3:	68 99 30 00 00       	push   $0x3099
     6a8:	ff 35 a8 59 00 00    	pushl  0x59a8
     6ae:	e8 8d 24 00 00       	call   2b40 <printf>
  if(exec("echo", echoargv) < 0) {
     6b3:	5a                   	pop    %edx
     6b4:	59                   	pop    %ecx
     6b5:	68 ac 59 00 00       	push   $0x59ac
     6ba:	68 63 2e 00 00       	push   $0x2e63
     6bf:	e8 75 23 00 00       	call   2a39 <exec>
     6c4:	83 c4 10             	add    $0x10,%esp
     6c7:	85 c0                	test   %eax,%eax
     6c9:	78 04                	js     6cf <exectest+0x2f>
}
     6cb:	83 c4 0c             	add    $0xc,%esp
     6ce:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     6cf:	50                   	push   %eax
     6d0:	50                   	push   %eax
     6d1:	68 a4 30 00 00       	push   $0x30a4
     6d6:	ff 35 a8 59 00 00    	pushl  0x59a8
     6dc:	e8 5f 24 00 00       	call   2b40 <printf>
    exit();
     6e1:	e8 1b 23 00 00       	call   2a01 <exit>
     6e6:	8d 76 00             	lea    0x0(%esi),%esi
     6e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006f0 <pipe1>:
{
     6f0:	55                   	push   %ebp
     6f1:	57                   	push   %edi
     6f2:	56                   	push   %esi
     6f3:	53                   	push   %ebx
     6f4:	83 ec 28             	sub    $0x28,%esp
  if(pipe(fds) != 0){
     6f7:	8d 44 24 14          	lea    0x14(%esp),%eax
     6fb:	50                   	push   %eax
     6fc:	e8 10 23 00 00       	call   2a11 <pipe>
     701:	83 c4 10             	add    $0x10,%esp
     704:	85 c0                	test   %eax,%eax
     706:	0f 85 47 01 00 00    	jne    853 <pipe1+0x163>
     70c:	89 c3                	mov    %eax,%ebx
  pid = fork();
     70e:	e8 e6 22 00 00       	call   29f9 <fork>
  if(pid == 0){
     713:	83 f8 00             	cmp    $0x0,%eax
  pid = fork();
     716:	89 c6                	mov    %eax,%esi
  if(pid == 0){
     718:	0f 84 82 00 00 00    	je     7a0 <pipe1+0xb0>
  } else if(pid > 0){
     71e:	0f 8e 43 01 00 00    	jle    867 <pipe1+0x177>
    close(fds[1]);
     724:	83 ec 0c             	sub    $0xc,%esp
    total = 0;
     727:	31 f6                	xor    %esi,%esi
    cc = 1;
     729:	bd 01 00 00 00       	mov    $0x1,%ebp
    close(fds[1]);
     72e:	ff 74 24 18          	pushl  0x18(%esp)
     732:	e8 f2 22 00 00       	call   2a29 <close>
    while((n = read(fds[0], buf, cc)) > 0){
     737:	83 c4 10             	add    $0x10,%esp
     73a:	83 ec 04             	sub    $0x4,%esp
     73d:	55                   	push   %ebp
     73e:	68 e0 59 00 00       	push   $0x59e0
     743:	ff 74 24 14          	pushl  0x14(%esp)
     747:	e8 cd 22 00 00       	call   2a19 <read>
     74c:	83 c4 10             	add    $0x10,%esp
     74f:	85 c0                	test   %eax,%eax
     751:	0f 8e a6 00 00 00    	jle    7fd <pipe1+0x10d>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     757:	89 d9                	mov    %ebx,%ecx
     759:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
     75c:	f7 d9                	neg    %ecx
     75e:	66 90                	xchg   %ax,%ax
     760:	38 9c 0b e0 59 00 00 	cmp    %bl,0x59e0(%ebx,%ecx,1)
     767:	8d 53 01             	lea    0x1(%ebx),%edx
     76a:	75 1a                	jne    786 <pipe1+0x96>
      for(i = 0; i < n; i++){
     76c:	39 fa                	cmp    %edi,%edx
     76e:	89 d3                	mov    %edx,%ebx
     770:	75 ee                	jne    760 <pipe1+0x70>
      cc = cc * 2;
     772:	01 ed                	add    %ebp,%ebp
      total += n;
     774:	01 c6                	add    %eax,%esi
     776:	b8 00 08 00 00       	mov    $0x800,%eax
     77b:	81 fd 00 08 00 00    	cmp    $0x800,%ebp
     781:	0f 4f e8             	cmovg  %eax,%ebp
     784:	eb b4                	jmp    73a <pipe1+0x4a>
          printf(1, "pipe1 oops 2\n");
     786:	83 ec 08             	sub    $0x8,%esp
     789:	68 d3 30 00 00       	push   $0x30d3
     78e:	6a 01                	push   $0x1
     790:	e8 ab 23 00 00       	call   2b40 <printf>
          return;
     795:	83 c4 10             	add    $0x10,%esp
}
     798:	83 c4 1c             	add    $0x1c,%esp
     79b:	5b                   	pop    %ebx
     79c:	5e                   	pop    %esi
     79d:	5f                   	pop    %edi
     79e:	5d                   	pop    %ebp
     79f:	c3                   	ret    
    close(fds[0]);
     7a0:	83 ec 0c             	sub    $0xc,%esp
     7a3:	ff 74 24 14          	pushl  0x14(%esp)
     7a7:	e8 7d 22 00 00       	call   2a29 <close>
     7ac:	83 c4 10             	add    $0x10,%esp
        buf[i] = seq++;
     7af:	89 f0                	mov    %esi,%eax
     7b1:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx
{
     7b7:	89 f3                	mov    %esi,%ebx
        buf[i] = seq++;
     7b9:	f7 d8                	neg    %eax
     7bb:	90                   	nop
     7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7c0:	88 9c 18 e0 59 00 00 	mov    %bl,0x59e0(%eax,%ebx,1)
     7c7:	83 c3 01             	add    $0x1,%ebx
      for(i = 0; i < 1033; i++)
     7ca:	39 d3                	cmp    %edx,%ebx
     7cc:	75 f2                	jne    7c0 <pipe1+0xd0>
      if(write(fds[1], buf, 1033) != 1033){
     7ce:	83 ec 04             	sub    $0x4,%esp
     7d1:	89 de                	mov    %ebx,%esi
     7d3:	68 09 04 00 00       	push   $0x409
     7d8:	68 e0 59 00 00       	push   $0x59e0
     7dd:	ff 74 24 18          	pushl  0x18(%esp)
     7e1:	e8 3b 22 00 00       	call   2a21 <write>
     7e6:	83 c4 10             	add    $0x10,%esp
     7e9:	3d 09 04 00 00       	cmp    $0x409,%eax
     7ee:	75 4f                	jne    83f <pipe1+0x14f>
    for(n = 0; n < 5; n++){
     7f0:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     7f6:	75 b7                	jne    7af <pipe1+0xbf>
    exit();
     7f8:	e8 04 22 00 00       	call   2a01 <exit>
    if(total != 5 * 1033)
     7fd:	81 fe 2d 14 00 00    	cmp    $0x142d,%esi
     803:	74 13                	je     818 <pipe1+0x128>
      printf(1, "pipe1 oops 3 total %d\n", total);
     805:	83 ec 04             	sub    $0x4,%esp
     808:	56                   	push   %esi
     809:	68 e1 30 00 00       	push   $0x30e1
     80e:	6a 01                	push   $0x1
     810:	e8 2b 23 00 00       	call   2b40 <printf>
     815:	83 c4 10             	add    $0x10,%esp
    close(fds[0]);
     818:	83 ec 0c             	sub    $0xc,%esp
     81b:	ff 74 24 14          	pushl  0x14(%esp)
     81f:	e8 05 22 00 00       	call   2a29 <close>
    wait();
     824:	e8 e0 21 00 00       	call   2a09 <wait>
  printf(1, "pipe1 ok\n");
     829:	58                   	pop    %eax
     82a:	5a                   	pop    %edx
     82b:	68 f8 30 00 00       	push   $0x30f8
     830:	6a 01                	push   $0x1
     832:	e8 09 23 00 00       	call   2b40 <printf>
     837:	83 c4 10             	add    $0x10,%esp
     83a:	e9 59 ff ff ff       	jmp    798 <pipe1+0xa8>
        printf(1, "pipe1 oops 1\n");
     83f:	83 ec 08             	sub    $0x8,%esp
     842:	68 c5 30 00 00       	push   $0x30c5
     847:	6a 01                	push   $0x1
     849:	e8 f2 22 00 00       	call   2b40 <printf>
        exit();
     84e:	e8 ae 21 00 00       	call   2a01 <exit>
    printf(1, "pipe() failed\n");
     853:	83 ec 08             	sub    $0x8,%esp
     856:	68 b6 30 00 00       	push   $0x30b6
     85b:	6a 01                	push   $0x1
     85d:	e8 de 22 00 00       	call   2b40 <printf>
    exit();
     862:	e8 9a 21 00 00       	call   2a01 <exit>
    printf(1, "fork() failed\n");
     867:	83 ec 08             	sub    $0x8,%esp
     86a:	68 02 31 00 00       	push   $0x3102
     86f:	6a 01                	push   $0x1
     871:	e8 ca 22 00 00       	call   2b40 <printf>
    exit();
     876:	e8 86 21 00 00       	call   2a01 <exit>
     87b:	90                   	nop
     87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000880 <preempt>:
{
     880:	57                   	push   %edi
     881:	56                   	push   %esi
     882:	53                   	push   %ebx
     883:	83 ec 18             	sub    $0x18,%esp
  printf(1, "preempt: ");
     886:	68 11 31 00 00       	push   $0x3111
     88b:	6a 01                	push   $0x1
     88d:	e8 ae 22 00 00       	call   2b40 <printf>
  pid1 = fork();
     892:	e8 62 21 00 00       	call   29f9 <fork>
  if(pid1 == 0)
     897:	83 c4 10             	add    $0x10,%esp
     89a:	85 c0                	test   %eax,%eax
     89c:	75 02                	jne    8a0 <preempt+0x20>
     89e:	eb fe                	jmp    89e <preempt+0x1e>
     8a0:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     8a2:	e8 52 21 00 00       	call   29f9 <fork>
  if(pid2 == 0)
     8a7:	85 c0                	test   %eax,%eax
  pid2 = fork();
     8a9:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     8ab:	75 02                	jne    8af <preempt+0x2f>
     8ad:	eb fe                	jmp    8ad <preempt+0x2d>
  pipe(pfds);
     8af:	83 ec 0c             	sub    $0xc,%esp
     8b2:	8d 44 24 14          	lea    0x14(%esp),%eax
     8b6:	50                   	push   %eax
     8b7:	e8 55 21 00 00       	call   2a11 <pipe>
  pid3 = fork();
     8bc:	e8 38 21 00 00       	call   29f9 <fork>
  if(pid3 == 0){
     8c1:	83 c4 10             	add    $0x10,%esp
     8c4:	85 c0                	test   %eax,%eax
  pid3 = fork();
     8c6:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     8c8:	75 4a                	jne    914 <preempt+0x94>
    close(pfds[0]);
     8ca:	83 ec 0c             	sub    $0xc,%esp
     8cd:	ff 74 24 14          	pushl  0x14(%esp)
     8d1:	e8 53 21 00 00       	call   2a29 <close>
    if(write(pfds[1], "x", 1) != 1)
     8d6:	83 c4 0c             	add    $0xc,%esp
     8d9:	6a 01                	push   $0x1
     8db:	68 ad 36 00 00       	push   $0x36ad
     8e0:	ff 74 24 18          	pushl  0x18(%esp)
     8e4:	e8 38 21 00 00       	call   2a21 <write>
     8e9:	83 c4 10             	add    $0x10,%esp
     8ec:	83 f8 01             	cmp    $0x1,%eax
     8ef:	74 12                	je     903 <preempt+0x83>
      printf(1, "preempt write error");
     8f1:	83 ec 08             	sub    $0x8,%esp
     8f4:	68 1b 31 00 00       	push   $0x311b
     8f9:	6a 01                	push   $0x1
     8fb:	e8 40 22 00 00       	call   2b40 <printf>
     900:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	ff 74 24 18          	pushl  0x18(%esp)
     90a:	e8 1a 21 00 00       	call   2a29 <close>
     90f:	83 c4 10             	add    $0x10,%esp
     912:	eb fe                	jmp    912 <preempt+0x92>
  close(pfds[1]);
     914:	83 ec 0c             	sub    $0xc,%esp
     917:	ff 74 24 18          	pushl  0x18(%esp)
     91b:	e8 09 21 00 00       	call   2a29 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     920:	83 c4 0c             	add    $0xc,%esp
     923:	68 00 08 00 00       	push   $0x800
     928:	68 e0 59 00 00       	push   $0x59e0
     92d:	ff 74 24 14          	pushl  0x14(%esp)
     931:	e8 e3 20 00 00       	call   2a19 <read>
     936:	83 c4 10             	add    $0x10,%esp
     939:	83 f8 01             	cmp    $0x1,%eax
     93c:	74 19                	je     957 <preempt+0xd7>
    printf(1, "preempt read error");
     93e:	83 ec 08             	sub    $0x8,%esp
     941:	68 2f 31 00 00       	push   $0x312f
     946:	6a 01                	push   $0x1
     948:	e8 f3 21 00 00       	call   2b40 <printf>
    return;
     94d:	83 c4 10             	add    $0x10,%esp
}
     950:	83 c4 10             	add    $0x10,%esp
     953:	5b                   	pop    %ebx
     954:	5e                   	pop    %esi
     955:	5f                   	pop    %edi
     956:	c3                   	ret    
  close(pfds[0]);
     957:	83 ec 0c             	sub    $0xc,%esp
     95a:	ff 74 24 14          	pushl  0x14(%esp)
     95e:	e8 c6 20 00 00       	call   2a29 <close>
  printf(1, "kill... ");
     963:	58                   	pop    %eax
     964:	5a                   	pop    %edx
     965:	68 42 31 00 00       	push   $0x3142
     96a:	6a 01                	push   $0x1
     96c:	e8 cf 21 00 00       	call   2b40 <printf>
  kill(pid1);
     971:	89 3c 24             	mov    %edi,(%esp)
     974:	e8 b8 20 00 00       	call   2a31 <kill>
  kill(pid2);
     979:	89 34 24             	mov    %esi,(%esp)
     97c:	e8 b0 20 00 00       	call   2a31 <kill>
  kill(pid3);
     981:	89 1c 24             	mov    %ebx,(%esp)
     984:	e8 a8 20 00 00       	call   2a31 <kill>
  printf(1, "wait... ");
     989:	59                   	pop    %ecx
     98a:	5b                   	pop    %ebx
     98b:	68 4b 31 00 00       	push   $0x314b
     990:	6a 01                	push   $0x1
     992:	e8 a9 21 00 00       	call   2b40 <printf>
  wait();
     997:	e8 6d 20 00 00       	call   2a09 <wait>
  wait();
     99c:	e8 68 20 00 00       	call   2a09 <wait>
  wait();
     9a1:	e8 63 20 00 00       	call   2a09 <wait>
  printf(1, "preempt ok\n");
     9a6:	5e                   	pop    %esi
     9a7:	5f                   	pop    %edi
     9a8:	68 54 31 00 00       	push   $0x3154
     9ad:	6a 01                	push   $0x1
     9af:	e8 8c 21 00 00       	call   2b40 <printf>
     9b4:	83 c4 10             	add    $0x10,%esp
     9b7:	eb 97                	jmp    950 <preempt+0xd0>
     9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009c0 <exitwait>:
{
     9c0:	56                   	push   %esi
     9c1:	53                   	push   %ebx
     9c2:	be 64 00 00 00       	mov    $0x64,%esi
     9c7:	83 ec 04             	sub    $0x4,%esp
     9ca:	eb 14                	jmp    9e0 <exitwait+0x20>
     9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     9d0:	74 66                	je     a38 <exitwait+0x78>
      if(wait() != pid){
     9d2:	e8 32 20 00 00       	call   2a09 <wait>
     9d7:	39 c3                	cmp    %eax,%ebx
     9d9:	75 2d                	jne    a08 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     9db:	83 ee 01             	sub    $0x1,%esi
     9de:	74 40                	je     a20 <exitwait+0x60>
    pid = fork();
     9e0:	e8 14 20 00 00       	call   29f9 <fork>
    if(pid < 0){
     9e5:	85 c0                	test   %eax,%eax
    pid = fork();
     9e7:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     9e9:	79 e5                	jns    9d0 <exitwait+0x10>
      printf(1, "fork failed\n");
     9eb:	83 ec 08             	sub    $0x8,%esp
     9ee:	68 60 31 00 00       	push   $0x3160
     9f3:	6a 01                	push   $0x1
     9f5:	e8 46 21 00 00       	call   2b40 <printf>
      return;
     9fa:	83 c4 10             	add    $0x10,%esp
}
     9fd:	83 c4 04             	add    $0x4,%esp
     a00:	5b                   	pop    %ebx
     a01:	5e                   	pop    %esi
     a02:	c3                   	ret    
     a03:	90                   	nop
     a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     a08:	83 ec 08             	sub    $0x8,%esp
     a0b:	68 6d 31 00 00       	push   $0x316d
     a10:	6a 01                	push   $0x1
     a12:	e8 29 21 00 00       	call   2b40 <printf>
        return;
     a17:	83 c4 10             	add    $0x10,%esp
}
     a1a:	83 c4 04             	add    $0x4,%esp
     a1d:	5b                   	pop    %ebx
     a1e:	5e                   	pop    %esi
     a1f:	c3                   	ret    
  printf(1, "exitwait ok\n");
     a20:	83 ec 08             	sub    $0x8,%esp
     a23:	68 7d 31 00 00       	push   $0x317d
     a28:	6a 01                	push   $0x1
     a2a:	e8 11 21 00 00       	call   2b40 <printf>
     a2f:	83 c4 10             	add    $0x10,%esp
}
     a32:	83 c4 04             	add    $0x4,%esp
     a35:	5b                   	pop    %ebx
     a36:	5e                   	pop    %esi
     a37:	c3                   	ret    
      exit();
     a38:	e8 c4 1f 00 00       	call   2a01 <exit>
     a3d:	8d 76 00             	lea    0x0(%esi),%esi

00000a40 <mem>:
{
     a40:	56                   	push   %esi
     a41:	53                   	push   %ebx
     a42:	83 ec 04             	sub    $0x4,%esp
  if((pid = fork()) == 0){
     a45:	e8 af 1f 00 00       	call   29f9 <fork>
     a4a:	85 c0                	test   %eax,%eax
     a4c:	75 72                	jne    ac0 <mem+0x80>
     a4e:	31 db                	xor    %ebx,%ebx
     a50:	eb 0a                	jmp    a5c <mem+0x1c>
     a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *(char**) m2 = m1;
     a58:	89 18                	mov    %ebx,(%eax)
     a5a:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0) {
     a5c:	83 ec 0c             	sub    $0xc,%esp
     a5f:	68 11 27 00 00       	push   $0x2711
     a64:	e8 17 23 00 00       	call   2d80 <malloc>
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	85 c0                	test   %eax,%eax
     a6e:	75 e8                	jne    a58 <mem+0x18>
    while(m1) {
     a70:	85 db                	test   %ebx,%ebx
     a72:	74 18                	je     a8c <mem+0x4c>
     a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     a78:	8b 33                	mov    (%ebx),%esi
      free(m1);
     a7a:	83 ec 0c             	sub    $0xc,%esp
     a7d:	53                   	push   %ebx
     a7e:	89 f3                	mov    %esi,%ebx
     a80:	e8 7b 22 00 00       	call   2d00 <free>
    while(m1) {
     a85:	83 c4 10             	add    $0x10,%esp
     a88:	85 db                	test   %ebx,%ebx
     a8a:	75 ec                	jne    a78 <mem+0x38>
    m1 = malloc(1024*20);
     a8c:	83 ec 0c             	sub    $0xc,%esp
     a8f:	68 00 50 00 00       	push   $0x5000
     a94:	e8 e7 22 00 00       	call   2d80 <malloc>
    if(m1 == 0) {
     a99:	83 c4 10             	add    $0x10,%esp
     a9c:	85 c0                	test   %eax,%eax
     a9e:	74 30                	je     ad0 <mem+0x90>
    free(m1);
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	50                   	push   %eax
     aa4:	e8 57 22 00 00       	call   2d00 <free>
    printf(1, "mem ok\n");
     aa9:	58                   	pop    %eax
     aaa:	5a                   	pop    %edx
     aab:	68 a4 31 00 00       	push   $0x31a4
     ab0:	6a 01                	push   $0x1
     ab2:	e8 89 20 00 00       	call   2b40 <printf>
    exit();
     ab7:	e8 45 1f 00 00       	call   2a01 <exit>
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     ac0:	83 c4 04             	add    $0x4,%esp
     ac3:	5b                   	pop    %ebx
     ac4:	5e                   	pop    %esi
    wait();
     ac5:	e9 3f 1f 00 00       	jmp    2a09 <wait>
     aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "couldn't allocate mem?!!\n");
     ad0:	83 ec 08             	sub    $0x8,%esp
     ad3:	68 8a 31 00 00       	push   $0x318a
     ad8:	6a 01                	push   $0x1
     ada:	e8 61 20 00 00       	call   2b40 <printf>
      exit();
     adf:	e8 1d 1f 00 00       	call   2a01 <exit>
     ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000af0 <sharedfd>:
{
     af0:	55                   	push   %ebp
     af1:	57                   	push   %edi
     af2:	56                   	push   %esi
     af3:	53                   	push   %ebx
     af4:	83 ec 38             	sub    $0x38,%esp
  unlink("sharedfd");
     af7:	68 ac 31 00 00       	push   $0x31ac
     afc:	e8 50 1f 00 00       	call   2a51 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     b01:	59                   	pop    %ecx
     b02:	5b                   	pop    %ebx
     b03:	68 02 02 00 00       	push   $0x202
     b08:	68 ac 31 00 00       	push   $0x31ac
     b0d:	e8 2f 1f 00 00       	call   2a41 <open>
  if(fd < 0){
     b12:	83 c4 10             	add    $0x10,%esp
     b15:	85 c0                	test   %eax,%eax
     b17:	0f 88 40 01 00 00    	js     c5d <sharedfd+0x16d>
     b1d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     b1f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     b24:	e8 d0 1e 00 00       	call   29f9 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     b29:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     b2c:	89 c5                	mov    %eax,%ebp
  memset(buf, pid==0?'c':'p', sizeof(buf));
     b2e:	19 c0                	sbb    %eax,%eax
     b30:	83 ec 04             	sub    $0x4,%esp
     b33:	83 e0 f3             	and    $0xfffffff3,%eax
     b36:	6a 0a                	push   $0xa
     b38:	83 c0 70             	add    $0x70,%eax
     b3b:	50                   	push   %eax
     b3c:	8d 74 24 22          	lea    0x22(%esp),%esi
     b40:	56                   	push   %esi
     b41:	e8 3a 1d 00 00       	call   2880 <memset>
     b46:	83 c4 10             	add    $0x10,%esp
     b49:	eb 0a                	jmp    b55 <sharedfd+0x65>
     b4b:	90                   	nop
     b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
     b50:	83 eb 01             	sub    $0x1,%ebx
     b53:	74 26                	je     b7b <sharedfd+0x8b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     b55:	83 ec 04             	sub    $0x4,%esp
     b58:	6a 0a                	push   $0xa
     b5a:	56                   	push   %esi
     b5b:	57                   	push   %edi
     b5c:	e8 c0 1e 00 00       	call   2a21 <write>
     b61:	83 c4 10             	add    $0x10,%esp
     b64:	83 f8 0a             	cmp    $0xa,%eax
     b67:	74 e7                	je     b50 <sharedfd+0x60>
      printf(1, "fstests: write sharedfd failed\n");
     b69:	83 ec 08             	sub    $0x8,%esp
     b6c:	68 20 3c 00 00       	push   $0x3c20
     b71:	6a 01                	push   $0x1
     b73:	e8 c8 1f 00 00       	call   2b40 <printf>
      break;
     b78:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     b7b:	85 ed                	test   %ebp,%ebp
     b7d:	0f 84 0e 01 00 00    	je     c91 <sharedfd+0x1a1>
    wait();
     b83:	e8 81 1e 00 00       	call   2a09 <wait>
  close(fd);
     b88:	83 ec 0c             	sub    $0xc,%esp
     b8b:	31 db                	xor    %ebx,%ebx
     b8d:	57                   	push   %edi
     b8e:	31 ff                	xor    %edi,%edi
     b90:	e8 94 1e 00 00       	call   2a29 <close>
  fd = open("sharedfd", 0);
     b95:	58                   	pop    %eax
     b96:	5a                   	pop    %edx
     b97:	6a 00                	push   $0x0
     b99:	68 ac 31 00 00       	push   $0x31ac
     b9e:	e8 9e 1e 00 00       	call   2a41 <open>
     ba3:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if(fd < 0){
     ba7:	83 c4 10             	add    $0x10,%esp
     baa:	85 c0                	test   %eax,%eax
     bac:	8d 6c 24 20          	lea    0x20(%esp),%ebp
     bb0:	0f 88 c1 00 00 00    	js     c77 <sharedfd+0x187>
     bb6:	8d 76 00             	lea    0x0(%esi),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     bc0:	83 ec 04             	sub    $0x4,%esp
     bc3:	6a 0a                	push   $0xa
     bc5:	56                   	push   %esi
     bc6:	ff 74 24 18          	pushl  0x18(%esp)
     bca:	e8 4a 1e 00 00       	call   2a19 <read>
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	85 c0                	test   %eax,%eax
     bd4:	7e 29                	jle    bff <sharedfd+0x10f>
     bd6:	89 f0                	mov    %esi,%eax
     bd8:	eb 18                	jmp    bf2 <sharedfd+0x102>
     bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        np++;
     be0:	80 f9 70             	cmp    $0x70,%cl
     be3:	0f 94 c1             	sete   %cl
     be6:	0f b6 c9             	movzbl %cl,%ecx
     be9:	01 cb                	add    %ecx,%ebx
     beb:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < sizeof(buf); i++){
     bee:	39 e8                	cmp    %ebp,%eax
     bf0:	74 ce                	je     bc0 <sharedfd+0xd0>
      if(buf[i] == 'c')
     bf2:	0f b6 08             	movzbl (%eax),%ecx
     bf5:	80 f9 63             	cmp    $0x63,%cl
     bf8:	75 e6                	jne    be0 <sharedfd+0xf0>
        nc++;
     bfa:	83 c7 01             	add    $0x1,%edi
     bfd:	eb ec                	jmp    beb <sharedfd+0xfb>
  close(fd);
     bff:	83 ec 0c             	sub    $0xc,%esp
     c02:	ff 74 24 18          	pushl  0x18(%esp)
     c06:	e8 1e 1e 00 00       	call   2a29 <close>
  unlink("sharedfd");
     c0b:	c7 04 24 ac 31 00 00 	movl   $0x31ac,(%esp)
     c12:	e8 3a 1e 00 00       	call   2a51 <unlink>
  if(nc == 10000 && np == 10000)
     c17:	83 c4 10             	add    $0x10,%esp
     c1a:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     c20:	75 22                	jne    c44 <sharedfd+0x154>
     c22:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     c28:	75 1a                	jne    c44 <sharedfd+0x154>
    printf(1, "sharedfd ok\n");
     c2a:	83 ec 08             	sub    $0x8,%esp
     c2d:	68 b5 31 00 00       	push   $0x31b5
     c32:	6a 01                	push   $0x1
     c34:	e8 07 1f 00 00       	call   2b40 <printf>
     c39:	83 c4 10             	add    $0x10,%esp
}
     c3c:	83 c4 2c             	add    $0x2c,%esp
     c3f:	5b                   	pop    %ebx
     c40:	5e                   	pop    %esi
     c41:	5f                   	pop    %edi
     c42:	5d                   	pop    %ebp
     c43:	c3                   	ret    
    printf(1, "sharedfd oops %d %d\n", nc, np);
     c44:	53                   	push   %ebx
     c45:	57                   	push   %edi
     c46:	68 c2 31 00 00       	push   $0x31c2
     c4b:	6a 01                	push   $0x1
     c4d:	e8 ee 1e 00 00       	call   2b40 <printf>
     c52:	83 c4 10             	add    $0x10,%esp
}
     c55:	83 c4 2c             	add    $0x2c,%esp
     c58:	5b                   	pop    %ebx
     c59:	5e                   	pop    %esi
     c5a:	5f                   	pop    %edi
     c5b:	5d                   	pop    %ebp
     c5c:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     c5d:	83 ec 08             	sub    $0x8,%esp
     c60:	68 f4 3b 00 00       	push   $0x3bf4
     c65:	6a 01                	push   $0x1
     c67:	e8 d4 1e 00 00       	call   2b40 <printf>
    return;
     c6c:	83 c4 10             	add    $0x10,%esp
}
     c6f:	83 c4 2c             	add    $0x2c,%esp
     c72:	5b                   	pop    %ebx
     c73:	5e                   	pop    %esi
     c74:	5f                   	pop    %edi
     c75:	5d                   	pop    %ebp
     c76:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c77:	83 ec 08             	sub    $0x8,%esp
     c7a:	68 40 3c 00 00       	push   $0x3c40
     c7f:	6a 01                	push   $0x1
     c81:	e8 ba 1e 00 00       	call   2b40 <printf>
    return;
     c86:	83 c4 10             	add    $0x10,%esp
}
     c89:	83 c4 2c             	add    $0x2c,%esp
     c8c:	5b                   	pop    %ebx
     c8d:	5e                   	pop    %esi
     c8e:	5f                   	pop    %edi
     c8f:	5d                   	pop    %ebp
     c90:	c3                   	ret    
    exit();
     c91:	e8 6b 1d 00 00       	call   2a01 <exit>
     c96:	8d 76 00             	lea    0x0(%esi),%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <twofiles>:
{
     ca0:	55                   	push   %ebp
     ca1:	57                   	push   %edi
     ca2:	56                   	push   %esi
     ca3:	53                   	push   %ebx
     ca4:	83 ec 14             	sub    $0x14,%esp
  printf(1, "twofiles test\n");
     ca7:	68 d7 31 00 00       	push   $0x31d7
     cac:	6a 01                	push   $0x1
     cae:	e8 8d 1e 00 00       	call   2b40 <printf>
  unlink("f1");
     cb3:	c7 04 24 27 33 00 00 	movl   $0x3327,(%esp)
     cba:	e8 92 1d 00 00       	call   2a51 <unlink>
  unlink("f2");
     cbf:	c7 04 24 2b 33 00 00 	movl   $0x332b,(%esp)
     cc6:	e8 86 1d 00 00       	call   2a51 <unlink>
  pid = fork();
     ccb:	e8 29 1d 00 00       	call   29f9 <fork>
  if(pid < 0){
     cd0:	83 c4 10             	add    $0x10,%esp
     cd3:	85 c0                	test   %eax,%eax
     cd5:	0f 88 7f 01 00 00    	js     e5a <twofiles+0x1ba>
     cdb:	89 c7                	mov    %eax,%edi
  fname = pid ? "f1" : "f2";
     cdd:	0f 84 3e 01 00 00    	je     e21 <twofiles+0x181>
  fd = open(fname, O_CREATE | O_RDWR);
     ce3:	83 ec 08             	sub    $0x8,%esp
     ce6:	68 02 02 00 00       	push   $0x202
     ceb:	68 27 33 00 00       	push   $0x3327
     cf0:	e8 4c 1d 00 00       	call   2a41 <open>
  if(fd < 0){
     cf5:	83 c4 10             	add    $0x10,%esp
     cf8:	85 c0                	test   %eax,%eax
  fd = open(fname, O_CREATE | O_RDWR);
     cfa:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     cfc:	0f 88 72 01 00 00    	js     e74 <twofiles+0x1d4>
  memset(buf, pid?'p':'c', 512);
     d02:	b8 70 00 00 00       	mov    $0x70,%eax
     d07:	83 ec 04             	sub    $0x4,%esp
     d0a:	bb 0c 00 00 00       	mov    $0xc,%ebx
     d0f:	68 00 02 00 00       	push   $0x200
     d14:	50                   	push   %eax
     d15:	68 e0 59 00 00       	push   $0x59e0
     d1a:	e8 61 1b 00 00       	call   2880 <memset>
     d1f:	83 c4 10             	add    $0x10,%esp
     d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if((n = write(fd, buf, 500)) != 500){
     d28:	83 ec 04             	sub    $0x4,%esp
     d2b:	68 f4 01 00 00       	push   $0x1f4
     d30:	68 e0 59 00 00       	push   $0x59e0
     d35:	56                   	push   %esi
     d36:	e8 e6 1c 00 00       	call   2a21 <write>
     d3b:	83 c4 10             	add    $0x10,%esp
     d3e:	3d f4 01 00 00       	cmp    $0x1f4,%eax
     d43:	0f 85 3f 01 00 00    	jne    e88 <twofiles+0x1e8>
  for(i = 0; i < 12; i++){
     d49:	83 eb 01             	sub    $0x1,%ebx
     d4c:	75 da                	jne    d28 <twofiles+0x88>
  close(fd);
     d4e:	83 ec 0c             	sub    $0xc,%esp
     d51:	56                   	push   %esi
     d52:	e8 d2 1c 00 00       	call   2a29 <close>
  if(pid)
     d57:	83 c4 10             	add    $0x10,%esp
     d5a:	85 ff                	test   %edi,%edi
     d5c:	0f 84 50 01 00 00    	je     eb2 <twofiles+0x212>
    wait();
     d62:	e8 a2 1c 00 00       	call   2a09 <wait>
  for(i = 0; i < 2; i++){
     d67:	31 ff                	xor    %edi,%edi
    fd = open(i?"f1":"f2", 0);
     d69:	b8 2b 33 00 00       	mov    $0x332b,%eax
     d6e:	83 ec 08             	sub    $0x8,%esp
     d71:	6a 00                	push   $0x0
     d73:	50                   	push   %eax
     d74:	e8 c8 1c 00 00       	call   2a41 <open>
     d79:	83 c4 10             	add    $0x10,%esp
     d7c:	83 ff 01             	cmp    $0x1,%edi
     d7f:	89 c6                	mov    %eax,%esi
     d81:	19 ed                	sbb    %ebp,%ebp
    total = 0;
     d83:	31 db                	xor    %ebx,%ebx
     d85:	83 e5 f3             	and    $0xfffffff3,%ebp
     d88:	83 c5 70             	add    $0x70,%ebp
     d8b:	90                   	nop
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
     d90:	83 ec 04             	sub    $0x4,%esp
     d93:	68 00 08 00 00       	push   $0x800
     d98:	68 e0 59 00 00       	push   $0x59e0
     d9d:	56                   	push   %esi
     d9e:	e8 76 1c 00 00       	call   2a19 <read>
     da3:	83 c4 10             	add    $0x10,%esp
     da6:	85 c0                	test   %eax,%eax
     da8:	7e 20                	jle    dca <twofiles+0x12a>
     daa:	31 d2                	xor    %edx,%edx
     dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(buf[j] != (i?'p':'c')){
     db0:	0f be 8a e0 59 00 00 	movsbl 0x59e0(%edx),%ecx
     db7:	39 cd                	cmp    %ecx,%ebp
     db9:	0f 85 87 00 00 00    	jne    e46 <twofiles+0x1a6>
      for(j = 0; j < n; j++){
     dbf:	83 c2 01             	add    $0x1,%edx
     dc2:	39 d0                	cmp    %edx,%eax
     dc4:	75 ea                	jne    db0 <twofiles+0x110>
      total += n;
     dc6:	01 c3                	add    %eax,%ebx
     dc8:	eb c6                	jmp    d90 <twofiles+0xf0>
    close(fd);
     dca:	83 ec 0c             	sub    $0xc,%esp
     dcd:	56                   	push   %esi
     dce:	e8 56 1c 00 00       	call   2a29 <close>
    if(total != 12*500){
     dd3:	83 c4 10             	add    $0x10,%esp
     dd6:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
     ddc:	0f 85 bb 00 00 00    	jne    e9d <twofiles+0x1fd>
  for(i = 0; i < 2; i++){
     de2:	83 c7 01             	add    $0x1,%edi
     de5:	b8 27 33 00 00       	mov    $0x3327,%eax
     dea:	83 ff 02             	cmp    $0x2,%edi
     ded:	0f 85 7b ff ff ff    	jne    d6e <twofiles+0xce>
  unlink("f1");
     df3:	83 ec 0c             	sub    $0xc,%esp
     df6:	50                   	push   %eax
     df7:	e8 55 1c 00 00       	call   2a51 <unlink>
  unlink("f2");
     dfc:	c7 04 24 2b 33 00 00 	movl   $0x332b,(%esp)
     e03:	e8 49 1c 00 00       	call   2a51 <unlink>
  printf(1, "twofiles ok\n");
     e08:	58                   	pop    %eax
     e09:	5a                   	pop    %edx
     e0a:	68 14 32 00 00       	push   $0x3214
     e0f:	6a 01                	push   $0x1
     e11:	e8 2a 1d 00 00       	call   2b40 <printf>
     e16:	83 c4 10             	add    $0x10,%esp
}
     e19:	83 c4 0c             	add    $0xc,%esp
     e1c:	5b                   	pop    %ebx
     e1d:	5e                   	pop    %esi
     e1e:	5f                   	pop    %edi
     e1f:	5d                   	pop    %ebp
     e20:	c3                   	ret    
  fd = open(fname, O_CREATE | O_RDWR);
     e21:	83 ec 08             	sub    $0x8,%esp
     e24:	68 02 02 00 00       	push   $0x202
     e29:	68 2b 33 00 00       	push   $0x332b
     e2e:	e8 0e 1c 00 00       	call   2a41 <open>
  if(fd < 0){
     e33:	83 c4 10             	add    $0x10,%esp
     e36:	85 c0                	test   %eax,%eax
  fd = open(fname, O_CREATE | O_RDWR);
     e38:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     e3a:	78 38                	js     e74 <twofiles+0x1d4>
  memset(buf, pid?'p':'c', 512);
     e3c:	b8 63 00 00 00       	mov    $0x63,%eax
     e41:	e9 c1 fe ff ff       	jmp    d07 <twofiles+0x67>
          printf(1, "wrong char\n");
     e46:	83 ec 08             	sub    $0x8,%esp
     e49:	68 f7 31 00 00       	push   $0x31f7
     e4e:	6a 01                	push   $0x1
     e50:	e8 eb 1c 00 00       	call   2b40 <printf>
          exit();
     e55:	e8 a7 1b 00 00       	call   2a01 <exit>
    printf(1, "fork failed\n");
     e5a:	83 ec 08             	sub    $0x8,%esp
     e5d:	68 60 31 00 00       	push   $0x3160
     e62:	6a 01                	push   $0x1
     e64:	e8 d7 1c 00 00       	call   2b40 <printf>
    return;
     e69:	83 c4 10             	add    $0x10,%esp
}
     e6c:	83 c4 0c             	add    $0xc,%esp
     e6f:	5b                   	pop    %ebx
     e70:	5e                   	pop    %esi
     e71:	5f                   	pop    %edi
     e72:	5d                   	pop    %ebp
     e73:	c3                   	ret    
    printf(1, "create failed\n");
     e74:	83 ec 08             	sub    $0x8,%esp
     e77:	68 5b 34 00 00       	push   $0x345b
     e7c:	6a 01                	push   $0x1
     e7e:	e8 bd 1c 00 00       	call   2b40 <printf>
    exit();
     e83:	e8 79 1b 00 00       	call   2a01 <exit>
      printf(1, "write failed %d\n", n);
     e88:	83 ec 04             	sub    $0x4,%esp
     e8b:	50                   	push   %eax
     e8c:	68 e6 31 00 00       	push   $0x31e6
     e91:	6a 01                	push   $0x1
     e93:	e8 a8 1c 00 00       	call   2b40 <printf>
      exit();
     e98:	e8 64 1b 00 00       	call   2a01 <exit>
      printf(1, "wrong length %d\n", total);
     e9d:	83 ec 04             	sub    $0x4,%esp
     ea0:	53                   	push   %ebx
     ea1:	68 03 32 00 00       	push   $0x3203
     ea6:	6a 01                	push   $0x1
     ea8:	e8 93 1c 00 00       	call   2b40 <printf>
      exit();
     ead:	e8 4f 1b 00 00       	call   2a01 <exit>
    exit();
     eb2:	e8 4a 1b 00 00       	call   2a01 <exit>
     eb7:	89 f6                	mov    %esi,%esi
     eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ec0 <createdelete>:
{
     ec0:	55                   	push   %ebp
     ec1:	57                   	push   %edi
     ec2:	56                   	push   %esi
     ec3:	53                   	push   %ebx
     ec4:	83 ec 34             	sub    $0x34,%esp
  printf(1, "createdelete test\n");
     ec7:	68 21 32 00 00       	push   $0x3221
     ecc:	6a 01                	push   $0x1
     ece:	e8 6d 1c 00 00       	call   2b40 <printf>
  pid = fork();
     ed3:	e8 21 1b 00 00       	call   29f9 <fork>
  if(pid < 0){
     ed8:	83 c4 10             	add    $0x10,%esp
     edb:	85 c0                	test   %eax,%eax
     edd:	0f 88 c6 01 00 00    	js     10a9 <createdelete+0x1e9>
  name[0] = pid ? 'p' : 'c';
     ee3:	83 f8 01             	cmp    $0x1,%eax
     ee6:	89 c5                	mov    %eax,%ebp
  name[2] = '\0';
     ee8:	c6 44 24 02 00       	movb   $0x0,0x2(%esp)
  name[0] = pid ? 'p' : 'c';
     eed:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
     eef:	bf 01 00 00 00       	mov    $0x1,%edi
     ef4:	31 db                	xor    %ebx,%ebx
  name[0] = pid ? 'p' : 'c';
     ef6:	83 e0 f3             	and    $0xfffffff3,%eax
     ef9:	89 e6                	mov    %esp,%esi
     efb:	83 c0 70             	add    $0x70,%eax
     efe:	88 04 24             	mov    %al,(%esp)
     f01:	eb 10                	jmp    f13 <createdelete+0x53>
     f03:	90                   	nop
     f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < N; i++){
     f08:	83 ff 14             	cmp    $0x14,%edi
     f0b:	74 73                	je     f80 <createdelete+0xc0>
     f0d:	83 c3 01             	add    $0x1,%ebx
     f10:	83 c7 01             	add    $0x1,%edi
    name[1] = '0' + i;
     f13:	8d 43 30             	lea    0x30(%ebx),%eax
    fd = open(name, O_CREATE | O_RDWR);
     f16:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     f19:	88 44 24 09          	mov    %al,0x9(%esp)
    fd = open(name, O_CREATE | O_RDWR);
     f1d:	68 02 02 00 00       	push   $0x202
     f22:	56                   	push   %esi
     f23:	e8 19 1b 00 00       	call   2a41 <open>
    if(fd < 0){
     f28:	83 c4 10             	add    $0x10,%esp
     f2b:	85 c0                	test   %eax,%eax
     f2d:	0f 88 48 01 00 00    	js     107b <createdelete+0x1bb>
    close(fd);
     f33:	83 ec 0c             	sub    $0xc,%esp
     f36:	50                   	push   %eax
     f37:	e8 ed 1a 00 00       	call   2a29 <close>
    if(i > 0 && (i % 2 ) == 0){
     f3c:	83 c4 10             	add    $0x10,%esp
     f3f:	85 db                	test   %ebx,%ebx
     f41:	74 ca                	je     f0d <createdelete+0x4d>
     f43:	f6 c3 01             	test   $0x1,%bl
     f46:	75 c0                	jne    f08 <createdelete+0x48>
      name[1] = '0' + (i / 2);
     f48:	89 d8                	mov    %ebx,%eax
      if(unlink(name) < 0){
     f4a:	83 ec 0c             	sub    $0xc,%esp
      name[1] = '0' + (i / 2);
     f4d:	d1 f8                	sar    %eax
     f4f:	83 c0 30             	add    $0x30,%eax
     f52:	88 44 24 0d          	mov    %al,0xd(%esp)
      if(unlink(name) < 0){
     f56:	56                   	push   %esi
     f57:	e8 f5 1a 00 00       	call   2a51 <unlink>
     f5c:	83 c4 10             	add    $0x10,%esp
     f5f:	85 c0                	test   %eax,%eax
     f61:	79 a5                	jns    f08 <createdelete+0x48>
        printf(1, "unlink failed\n");
     f63:	83 ec 08             	sub    $0x8,%esp
     f66:	68 34 32 00 00       	push   $0x3234
     f6b:	6a 01                	push   $0x1
     f6d:	e8 ce 1b 00 00       	call   2b40 <printf>
        exit();
     f72:	e8 8a 1a 00 00       	call   2a01 <exit>
     f77:	89 f6                	mov    %esi,%esi
     f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(pid==0)
     f80:	85 ed                	test   %ebp,%ebp
     f82:	0f 84 1c 01 00 00    	je     10a4 <createdelete+0x1e4>
  for(i = 0; i < N; i++){
     f88:	31 db                	xor    %ebx,%ebx
    wait();
     f8a:	e8 7a 1a 00 00       	call   2a09 <wait>
     f8f:	90                   	nop
     f90:	8d 6b 30             	lea    0x30(%ebx),%ebp
    name[0] = 'p';
     f93:	c6 04 24 70          	movb   $0x70,(%esp)
    fd = open(name, 0);
     f97:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     f9a:	89 e8                	mov    %ebp,%eax
     f9c:	88 44 24 09          	mov    %al,0x9(%esp)
    fd = open(name, 0);
     fa0:	6a 00                	push   $0x0
     fa2:	56                   	push   %esi
     fa3:	e8 99 1a 00 00       	call   2a41 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     fa8:	83 c4 10             	add    $0x10,%esp
     fab:	85 db                	test   %ebx,%ebx
     fad:	0f 94 c1             	sete   %cl
     fb0:	83 fb 09             	cmp    $0x9,%ebx
     fb3:	0f 9f c2             	setg   %dl
     fb6:	89 cf                	mov    %ecx,%edi
     fb8:	09 d7                	or     %edx,%edi
     fba:	89 c2                	mov    %eax,%edx
     fbc:	c1 ea 1f             	shr    $0x1f,%edx
     fbf:	84 d2                	test   %dl,%dl
     fc1:	74 0a                	je     fcd <createdelete+0x10d>
     fc3:	89 f9                	mov    %edi,%ecx
     fc5:	84 c9                	test   %cl,%cl
     fc7:	0f 85 c2 00 00 00    	jne    108f <createdelete+0x1cf>
    } else if((i >= 1 && i < N/2) && fd >= 0){
     fcd:	8d 53 ff             	lea    -0x1(%ebx),%edx
     fd0:	83 fa 08             	cmp    $0x8,%edx
     fd3:	0f 86 e4 00 00 00    	jbe    10bd <createdelete+0x1fd>
    if(fd >= 0)
     fd9:	85 c0                	test   %eax,%eax
     fdb:	78 0c                	js     fe9 <createdelete+0x129>
      close(fd);
     fdd:	83 ec 0c             	sub    $0xc,%esp
     fe0:	50                   	push   %eax
     fe1:	e8 43 1a 00 00       	call   2a29 <close>
     fe6:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + i;
     fe9:	89 e8                	mov    %ebp,%eax
    name[0] = 'c';
     feb:	c6 04 24 63          	movb   $0x63,(%esp)
    fd = open(name, 0);
     fef:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     ff2:	88 44 24 09          	mov    %al,0x9(%esp)
    fd = open(name, 0);
     ff6:	6a 00                	push   $0x0
     ff8:	56                   	push   %esi
     ff9:	e8 43 1a 00 00       	call   2a41 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     ffe:	89 c2                	mov    %eax,%edx
    1000:	83 c4 10             	add    $0x10,%esp
    1003:	c1 ea 1f             	shr    $0x1f,%edx
    1006:	84 d2                	test   %dl,%dl
    1008:	74 06                	je     1010 <createdelete+0x150>
    100a:	89 f9                	mov    %edi,%ecx
    100c:	84 c9                	test   %cl,%cl
    100e:	75 7f                	jne    108f <createdelete+0x1cf>
    if(fd >= 0)
    1010:	85 c0                	test   %eax,%eax
    1012:	78 0c                	js     1020 <createdelete+0x160>
      close(fd);
    1014:	83 ec 0c             	sub    $0xc,%esp
    1017:	50                   	push   %eax
    1018:	e8 0c 1a 00 00       	call   2a29 <close>
    101d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < N; i++){
    1020:	83 c3 01             	add    $0x1,%ebx
    1023:	83 fb 14             	cmp    $0x14,%ebx
    1026:	0f 85 64 ff ff ff    	jne    f90 <createdelete+0xd0>
    102c:	bb 30 00 00 00       	mov    $0x30,%ebx
    1031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    name[1] = '0' + i;
    1038:	88 5c 24 01          	mov    %bl,0x1(%esp)
    name[0] = 'p';
    103c:	c6 04 24 70          	movb   $0x70,(%esp)
    unlink(name);
    1040:	83 ec 0c             	sub    $0xc,%esp
    1043:	56                   	push   %esi
    1044:	83 c3 01             	add    $0x1,%ebx
    1047:	e8 05 1a 00 00       	call   2a51 <unlink>
    name[0] = 'c';
    104c:	c6 44 24 10 63       	movb   $0x63,0x10(%esp)
    unlink(name);
    1051:	89 34 24             	mov    %esi,(%esp)
    1054:	e8 f8 19 00 00       	call   2a51 <unlink>
  for(i = 0; i < N; i++){
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	80 fb 44             	cmp    $0x44,%bl
    105f:	75 d7                	jne    1038 <createdelete+0x178>
  printf(1, "createdelete ok\n");
    1061:	83 ec 08             	sub    $0x8,%esp
    1064:	68 43 32 00 00       	push   $0x3243
    1069:	6a 01                	push   $0x1
    106b:	e8 d0 1a 00 00       	call   2b40 <printf>
}
    1070:	83 c4 10             	add    $0x10,%esp
    1073:	83 c4 2c             	add    $0x2c,%esp
    1076:	5b                   	pop    %ebx
    1077:	5e                   	pop    %esi
    1078:	5f                   	pop    %edi
    1079:	5d                   	pop    %ebp
    107a:	c3                   	ret    
      printf(1, "create failed\n");
    107b:	83 ec 08             	sub    $0x8,%esp
    107e:	68 5b 34 00 00       	push   $0x345b
    1083:	6a 01                	push   $0x1
    1085:	e8 b6 1a 00 00       	call   2b40 <printf>
      exit();
    108a:	e8 72 19 00 00       	call   2a01 <exit>
      printf(1, "oops createdelete %s didn't exist\n", name);
    108f:	83 ec 04             	sub    $0x4,%esp
    1092:	56                   	push   %esi
    1093:	68 6c 3c 00 00       	push   $0x3c6c
    1098:	6a 01                	push   $0x1
    109a:	e8 a1 1a 00 00       	call   2b40 <printf>
      exit();
    109f:	e8 5d 19 00 00       	call   2a01 <exit>
    exit();
    10a4:	e8 58 19 00 00       	call   2a01 <exit>
    printf(1, "fork failed\n");
    10a9:	83 ec 08             	sub    $0x8,%esp
    10ac:	68 60 31 00 00       	push   $0x3160
    10b1:	6a 01                	push   $0x1
    10b3:	e8 88 1a 00 00       	call   2b40 <printf>
    exit();
    10b8:	e8 44 19 00 00       	call   2a01 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    10bd:	85 c0                	test   %eax,%eax
    10bf:	79 2f                	jns    10f0 <createdelete+0x230>
    name[1] = '0' + i;
    10c1:	89 e8                	mov    %ebp,%eax
    name[0] = 'c';
    10c3:	c6 04 24 63          	movb   $0x63,(%esp)
    fd = open(name, 0);
    10c7:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
    10ca:	88 44 24 09          	mov    %al,0x9(%esp)
    fd = open(name, 0);
    10ce:	6a 00                	push   $0x0
    10d0:	56                   	push   %esi
    10d1:	e8 6b 19 00 00       	call   2a41 <open>
    if((i == 0 || i >= N/2) && fd < 0){
    10d6:	89 c2                	mov    %eax,%edx
    10d8:	83 c4 10             	add    $0x10,%esp
    10db:	c1 ea 1f             	shr    $0x1f,%edx
    10de:	84 d2                	test   %dl,%dl
    10e0:	74 06                	je     10e8 <createdelete+0x228>
    10e2:	89 f9                	mov    %edi,%ecx
    10e4:	84 c9                	test   %cl,%cl
    10e6:	75 a7                	jne    108f <createdelete+0x1cf>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    10e8:	85 c0                	test   %eax,%eax
    10ea:	0f 88 30 ff ff ff    	js     1020 <createdelete+0x160>
      printf(1, "oops createdelete %s did exist\n", name);
    10f0:	83 ec 04             	sub    $0x4,%esp
    10f3:	56                   	push   %esi
    10f4:	68 90 3c 00 00       	push   $0x3c90
    10f9:	6a 01                	push   $0x1
    10fb:	e8 40 1a 00 00       	call   2b40 <printf>
      exit();
    1100:	e8 fc 18 00 00       	call   2a01 <exit>
    1105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <unlinkread>:
{
    1110:	56                   	push   %esi
    1111:	53                   	push   %ebx
    1112:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "unlinkread test\n");
    1115:	68 54 32 00 00       	push   $0x3254
    111a:	6a 01                	push   $0x1
    111c:	e8 1f 1a 00 00       	call   2b40 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1121:	5b                   	pop    %ebx
    1122:	5e                   	pop    %esi
    1123:	68 02 02 00 00       	push   $0x202
    1128:	68 65 32 00 00       	push   $0x3265
    112d:	e8 0f 19 00 00       	call   2a41 <open>
  if(fd < 0){
    1132:	83 c4 10             	add    $0x10,%esp
    1135:	85 c0                	test   %eax,%eax
    1137:	0f 88 e2 00 00 00    	js     121f <unlinkread+0x10f>
  write(fd, "hello", 5);
    113d:	83 ec 04             	sub    $0x4,%esp
    1140:	89 c3                	mov    %eax,%ebx
    1142:	6a 05                	push   $0x5
    1144:	68 8a 32 00 00       	push   $0x328a
    1149:	50                   	push   %eax
    114a:	e8 d2 18 00 00       	call   2a21 <write>
  close(fd);
    114f:	89 1c 24             	mov    %ebx,(%esp)
    1152:	e8 d2 18 00 00       	call   2a29 <close>
  fd = open("unlinkread", O_RDWR);
    1157:	58                   	pop    %eax
    1158:	5a                   	pop    %edx
    1159:	6a 02                	push   $0x2
    115b:	68 65 32 00 00       	push   $0x3265
    1160:	e8 dc 18 00 00       	call   2a41 <open>
  if(fd < 0){
    1165:	83 c4 10             	add    $0x10,%esp
    1168:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    116a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    116c:	0f 88 0c 01 00 00    	js     127e <unlinkread+0x16e>
  if(unlink("unlinkread") != 0){
    1172:	83 ec 0c             	sub    $0xc,%esp
    1175:	68 65 32 00 00       	push   $0x3265
    117a:	e8 d2 18 00 00       	call   2a51 <unlink>
    117f:	83 c4 10             	add    $0x10,%esp
    1182:	85 c0                	test   %eax,%eax
    1184:	0f 85 e1 00 00 00    	jne    126b <unlinkread+0x15b>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    118a:	83 ec 08             	sub    $0x8,%esp
    118d:	68 02 02 00 00       	push   $0x202
    1192:	68 65 32 00 00       	push   $0x3265
    1197:	e8 a5 18 00 00       	call   2a41 <open>
  write(fd1, "yyy", 3);
    119c:	83 c4 0c             	add    $0xc,%esp
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    119f:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    11a1:	6a 03                	push   $0x3
    11a3:	68 c2 32 00 00       	push   $0x32c2
    11a8:	50                   	push   %eax
    11a9:	e8 73 18 00 00       	call   2a21 <write>
  close(fd1);
    11ae:	89 34 24             	mov    %esi,(%esp)
    11b1:	e8 73 18 00 00       	call   2a29 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    11b6:	83 c4 0c             	add    $0xc,%esp
    11b9:	68 00 08 00 00       	push   $0x800
    11be:	68 e0 59 00 00       	push   $0x59e0
    11c3:	53                   	push   %ebx
    11c4:	e8 50 18 00 00       	call   2a19 <read>
    11c9:	83 c4 10             	add    $0x10,%esp
    11cc:	83 f8 05             	cmp    $0x5,%eax
    11cf:	0f 85 83 00 00 00    	jne    1258 <unlinkread+0x148>
  if(buf[0] != 'h'){
    11d5:	80 3d e0 59 00 00 68 	cmpb   $0x68,0x59e0
    11dc:	75 67                	jne    1245 <unlinkread+0x135>
  if(write(fd, buf, 10) != 10){
    11de:	83 ec 04             	sub    $0x4,%esp
    11e1:	6a 0a                	push   $0xa
    11e3:	68 e0 59 00 00       	push   $0x59e0
    11e8:	53                   	push   %ebx
    11e9:	e8 33 18 00 00       	call   2a21 <write>
    11ee:	83 c4 10             	add    $0x10,%esp
    11f1:	83 f8 0a             	cmp    $0xa,%eax
    11f4:	75 3c                	jne    1232 <unlinkread+0x122>
  close(fd);
    11f6:	83 ec 0c             	sub    $0xc,%esp
    11f9:	53                   	push   %ebx
    11fa:	e8 2a 18 00 00       	call   2a29 <close>
  unlink("unlinkread");
    11ff:	c7 04 24 65 32 00 00 	movl   $0x3265,(%esp)
    1206:	e8 46 18 00 00       	call   2a51 <unlink>
  printf(1, "unlinkread ok\n");
    120b:	58                   	pop    %eax
    120c:	5a                   	pop    %edx
    120d:	68 0d 33 00 00       	push   $0x330d
    1212:	6a 01                	push   $0x1
    1214:	e8 27 19 00 00       	call   2b40 <printf>
}
    1219:	83 c4 14             	add    $0x14,%esp
    121c:	5b                   	pop    %ebx
    121d:	5e                   	pop    %esi
    121e:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    121f:	51                   	push   %ecx
    1220:	51                   	push   %ecx
    1221:	68 70 32 00 00       	push   $0x3270
    1226:	6a 01                	push   $0x1
    1228:	e8 13 19 00 00       	call   2b40 <printf>
    exit();
    122d:	e8 cf 17 00 00       	call   2a01 <exit>
    printf(1, "unlinkread write failed\n");
    1232:	51                   	push   %ecx
    1233:	51                   	push   %ecx
    1234:	68 f4 32 00 00       	push   $0x32f4
    1239:	6a 01                	push   $0x1
    123b:	e8 00 19 00 00       	call   2b40 <printf>
    exit();
    1240:	e8 bc 17 00 00       	call   2a01 <exit>
    printf(1, "unlinkread wrong data\n");
    1245:	53                   	push   %ebx
    1246:	53                   	push   %ebx
    1247:	68 dd 32 00 00       	push   $0x32dd
    124c:	6a 01                	push   $0x1
    124e:	e8 ed 18 00 00       	call   2b40 <printf>
    exit();
    1253:	e8 a9 17 00 00       	call   2a01 <exit>
    printf(1, "unlinkread read failed");
    1258:	56                   	push   %esi
    1259:	56                   	push   %esi
    125a:	68 c6 32 00 00       	push   $0x32c6
    125f:	6a 01                	push   $0x1
    1261:	e8 da 18 00 00       	call   2b40 <printf>
    exit();
    1266:	e8 96 17 00 00       	call   2a01 <exit>
    printf(1, "unlink unlinkread failed\n");
    126b:	50                   	push   %eax
    126c:	50                   	push   %eax
    126d:	68 a8 32 00 00       	push   $0x32a8
    1272:	6a 01                	push   $0x1
    1274:	e8 c7 18 00 00       	call   2b40 <printf>
    exit();
    1279:	e8 83 17 00 00       	call   2a01 <exit>
    printf(1, "open unlinkread failed\n");
    127e:	50                   	push   %eax
    127f:	50                   	push   %eax
    1280:	68 90 32 00 00       	push   $0x3290
    1285:	6a 01                	push   $0x1
    1287:	e8 b4 18 00 00       	call   2b40 <printf>
    exit();
    128c:	e8 70 17 00 00       	call   2a01 <exit>
    1291:	eb 0d                	jmp    12a0 <linktest>
    1293:	90                   	nop
    1294:	90                   	nop
    1295:	90                   	nop
    1296:	90                   	nop
    1297:	90                   	nop
    1298:	90                   	nop
    1299:	90                   	nop
    129a:	90                   	nop
    129b:	90                   	nop
    129c:	90                   	nop
    129d:	90                   	nop
    129e:	90                   	nop
    129f:	90                   	nop

000012a0 <linktest>:
{
    12a0:	53                   	push   %ebx
    12a1:	83 ec 10             	sub    $0x10,%esp
  printf(1, "linktest\n");
    12a4:	68 1c 33 00 00       	push   $0x331c
    12a9:	6a 01                	push   $0x1
    12ab:	e8 90 18 00 00       	call   2b40 <printf>
  unlink("lf1");
    12b0:	c7 04 24 26 33 00 00 	movl   $0x3326,(%esp)
    12b7:	e8 95 17 00 00       	call   2a51 <unlink>
  unlink("lf2");
    12bc:	c7 04 24 2a 33 00 00 	movl   $0x332a,(%esp)
    12c3:	e8 89 17 00 00       	call   2a51 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    12c8:	58                   	pop    %eax
    12c9:	5a                   	pop    %edx
    12ca:	68 02 02 00 00       	push   $0x202
    12cf:	68 26 33 00 00       	push   $0x3326
    12d4:	e8 68 17 00 00       	call   2a41 <open>
  if(fd < 0){
    12d9:	83 c4 10             	add    $0x10,%esp
    12dc:	85 c0                	test   %eax,%eax
    12de:	0f 88 1b 01 00 00    	js     13ff <linktest+0x15f>
  if(write(fd, "hello", 5) != 5){
    12e4:	83 ec 04             	sub    $0x4,%esp
    12e7:	89 c3                	mov    %eax,%ebx
    12e9:	6a 05                	push   $0x5
    12eb:	68 8a 32 00 00       	push   $0x328a
    12f0:	50                   	push   %eax
    12f1:	e8 2b 17 00 00       	call   2a21 <write>
    12f6:	83 c4 10             	add    $0x10,%esp
    12f9:	83 f8 05             	cmp    $0x5,%eax
    12fc:	0f 85 95 01 00 00    	jne    1497 <linktest+0x1f7>
  close(fd);
    1302:	83 ec 0c             	sub    $0xc,%esp
    1305:	53                   	push   %ebx
    1306:	e8 1e 17 00 00       	call   2a29 <close>
  if(link("lf1", "lf2") < 0){
    130b:	5b                   	pop    %ebx
    130c:	58                   	pop    %eax
    130d:	68 2a 33 00 00       	push   $0x332a
    1312:	68 26 33 00 00       	push   $0x3326
    1317:	e8 45 17 00 00       	call   2a61 <link>
    131c:	83 c4 10             	add    $0x10,%esp
    131f:	85 c0                	test   %eax,%eax
    1321:	0f 88 5d 01 00 00    	js     1484 <linktest+0x1e4>
  unlink("lf1");
    1327:	83 ec 0c             	sub    $0xc,%esp
    132a:	68 26 33 00 00       	push   $0x3326
    132f:	e8 1d 17 00 00       	call   2a51 <unlink>
  if(open("lf1", 0) >= 0){
    1334:	58                   	pop    %eax
    1335:	5a                   	pop    %edx
    1336:	6a 00                	push   $0x0
    1338:	68 26 33 00 00       	push   $0x3326
    133d:	e8 ff 16 00 00       	call   2a41 <open>
    1342:	83 c4 10             	add    $0x10,%esp
    1345:	85 c0                	test   %eax,%eax
    1347:	0f 89 24 01 00 00    	jns    1471 <linktest+0x1d1>
  fd = open("lf2", 0);
    134d:	83 ec 08             	sub    $0x8,%esp
    1350:	6a 00                	push   $0x0
    1352:	68 2a 33 00 00       	push   $0x332a
    1357:	e8 e5 16 00 00       	call   2a41 <open>
  if(fd < 0){
    135c:	83 c4 10             	add    $0x10,%esp
    135f:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    1361:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1363:	0f 88 f5 00 00 00    	js     145e <linktest+0x1be>
  if(read(fd, buf, sizeof(buf)) != 5){
    1369:	83 ec 04             	sub    $0x4,%esp
    136c:	68 00 08 00 00       	push   $0x800
    1371:	68 e0 59 00 00       	push   $0x59e0
    1376:	50                   	push   %eax
    1377:	e8 9d 16 00 00       	call   2a19 <read>
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	83 f8 05             	cmp    $0x5,%eax
    1382:	0f 85 c3 00 00 00    	jne    144b <linktest+0x1ab>
  close(fd);
    1388:	83 ec 0c             	sub    $0xc,%esp
    138b:	53                   	push   %ebx
    138c:	e8 98 16 00 00       	call   2a29 <close>
  if(link("lf2", "lf2") >= 0){
    1391:	58                   	pop    %eax
    1392:	5a                   	pop    %edx
    1393:	68 2a 33 00 00       	push   $0x332a
    1398:	68 2a 33 00 00       	push   $0x332a
    139d:	e8 bf 16 00 00       	call   2a61 <link>
    13a2:	83 c4 10             	add    $0x10,%esp
    13a5:	85 c0                	test   %eax,%eax
    13a7:	0f 89 8b 00 00 00    	jns    1438 <linktest+0x198>
  unlink("lf2");
    13ad:	83 ec 0c             	sub    $0xc,%esp
    13b0:	68 2a 33 00 00       	push   $0x332a
    13b5:	e8 97 16 00 00       	call   2a51 <unlink>
  if(link("lf2", "lf1") >= 0){
    13ba:	59                   	pop    %ecx
    13bb:	5b                   	pop    %ebx
    13bc:	68 26 33 00 00       	push   $0x3326
    13c1:	68 2a 33 00 00       	push   $0x332a
    13c6:	e8 96 16 00 00       	call   2a61 <link>
    13cb:	83 c4 10             	add    $0x10,%esp
    13ce:	85 c0                	test   %eax,%eax
    13d0:	79 53                	jns    1425 <linktest+0x185>
  if(link(".", "lf1") >= 0){
    13d2:	83 ec 08             	sub    $0x8,%esp
    13d5:	68 26 33 00 00       	push   $0x3326
    13da:	68 ca 35 00 00       	push   $0x35ca
    13df:	e8 7d 16 00 00       	call   2a61 <link>
    13e4:	83 c4 10             	add    $0x10,%esp
    13e7:	85 c0                	test   %eax,%eax
    13e9:	79 27                	jns    1412 <linktest+0x172>
  printf(1, "linktest ok\n");
    13eb:	83 ec 08             	sub    $0x8,%esp
    13ee:	68 c4 33 00 00       	push   $0x33c4
    13f3:	6a 01                	push   $0x1
    13f5:	e8 46 17 00 00       	call   2b40 <printf>
}
    13fa:	83 c4 18             	add    $0x18,%esp
    13fd:	5b                   	pop    %ebx
    13fe:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    13ff:	50                   	push   %eax
    1400:	50                   	push   %eax
    1401:	68 2e 33 00 00       	push   $0x332e
    1406:	6a 01                	push   $0x1
    1408:	e8 33 17 00 00       	call   2b40 <printf>
    exit();
    140d:	e8 ef 15 00 00       	call   2a01 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1412:	50                   	push   %eax
    1413:	50                   	push   %eax
    1414:	68 a8 33 00 00       	push   $0x33a8
    1419:	6a 01                	push   $0x1
    141b:	e8 20 17 00 00       	call   2b40 <printf>
    exit();
    1420:	e8 dc 15 00 00       	call   2a01 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    1425:	52                   	push   %edx
    1426:	52                   	push   %edx
    1427:	68 d8 3c 00 00       	push   $0x3cd8
    142c:	6a 01                	push   $0x1
    142e:	e8 0d 17 00 00       	call   2b40 <printf>
    exit();
    1433:	e8 c9 15 00 00       	call   2a01 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1438:	50                   	push   %eax
    1439:	50                   	push   %eax
    143a:	68 8a 33 00 00       	push   $0x338a
    143f:	6a 01                	push   $0x1
    1441:	e8 fa 16 00 00       	call   2b40 <printf>
    exit();
    1446:	e8 b6 15 00 00       	call   2a01 <exit>
    printf(1, "read lf2 failed\n");
    144b:	51                   	push   %ecx
    144c:	51                   	push   %ecx
    144d:	68 79 33 00 00       	push   $0x3379
    1452:	6a 01                	push   $0x1
    1454:	e8 e7 16 00 00       	call   2b40 <printf>
    exit();
    1459:	e8 a3 15 00 00       	call   2a01 <exit>
    printf(1, "open lf2 failed\n");
    145e:	53                   	push   %ebx
    145f:	53                   	push   %ebx
    1460:	68 68 33 00 00       	push   $0x3368
    1465:	6a 01                	push   $0x1
    1467:	e8 d4 16 00 00       	call   2b40 <printf>
    exit();
    146c:	e8 90 15 00 00       	call   2a01 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1471:	50                   	push   %eax
    1472:	50                   	push   %eax
    1473:	68 b0 3c 00 00       	push   $0x3cb0
    1478:	6a 01                	push   $0x1
    147a:	e8 c1 16 00 00       	call   2b40 <printf>
    exit();
    147f:	e8 7d 15 00 00       	call   2a01 <exit>
    printf(1, "link lf1 lf2 failed\n");
    1484:	51                   	push   %ecx
    1485:	51                   	push   %ecx
    1486:	68 53 33 00 00       	push   $0x3353
    148b:	6a 01                	push   $0x1
    148d:	e8 ae 16 00 00       	call   2b40 <printf>
    exit();
    1492:	e8 6a 15 00 00       	call   2a01 <exit>
    printf(1, "write lf1 failed\n");
    1497:	50                   	push   %eax
    1498:	50                   	push   %eax
    1499:	68 41 33 00 00       	push   $0x3341
    149e:	6a 01                	push   $0x1
    14a0:	e8 9b 16 00 00       	call   2b40 <printf>
    exit();
    14a5:	e8 57 15 00 00       	call   2a01 <exit>
    14aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000014b0 <concreate>:
{
    14b0:	55                   	push   %ebp
    14b1:	57                   	push   %edi
    if(pid && (i % 3) == 1){
    14b2:	bf 56 55 55 55       	mov    $0x55555556,%edi
{
    14b7:	56                   	push   %esi
    14b8:	53                   	push   %ebx
  for(i = 0; i < 40; i++){
    14b9:	31 db                	xor    %ebx,%ebx
{
    14bb:	83 ec 54             	sub    $0x54,%esp
  printf(1, "concreate test\n");
    14be:	68 d1 33 00 00       	push   $0x33d1
    14c3:	6a 01                	push   $0x1
    14c5:	e8 76 16 00 00       	call   2b40 <printf>
  file[0] = 'C';
    14ca:	c6 44 24 15 43       	movb   $0x43,0x15(%esp)
  file[2] = '\0';
    14cf:	c6 44 24 17 00       	movb   $0x0,0x17(%esp)
    14d4:	83 c4 10             	add    $0x10,%esp
    14d7:	8d 74 24 05          	lea    0x5(%esp),%esi
    14db:	eb 50                	jmp    152d <concreate+0x7d>
    14dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(pid && (i % 3) == 1){
    14e0:	89 d8                	mov    %ebx,%eax
    14e2:	89 d9                	mov    %ebx,%ecx
    14e4:	f7 ef                	imul   %edi
    14e6:	89 d8                	mov    %ebx,%eax
    14e8:	c1 f8 1f             	sar    $0x1f,%eax
    14eb:	29 c2                	sub    %eax,%edx
    14ed:	8d 04 52             	lea    (%edx,%edx,2),%eax
    14f0:	29 c1                	sub    %eax,%ecx
    14f2:	83 f9 01             	cmp    $0x1,%ecx
    14f5:	0f 84 b5 00 00 00    	je     15b0 <concreate+0x100>
      fd = open(file, O_CREATE | O_RDWR);
    14fb:	83 ec 08             	sub    $0x8,%esp
    14fe:	68 02 02 00 00       	push   $0x202
    1503:	56                   	push   %esi
    1504:	e8 38 15 00 00       	call   2a41 <open>
      if(fd < 0){
    1509:	83 c4 10             	add    $0x10,%esp
    150c:	85 c0                	test   %eax,%eax
    150e:	78 6e                	js     157e <concreate+0xce>
      close(fd);
    1510:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1513:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    1516:	50                   	push   %eax
    1517:	e8 0d 15 00 00       	call   2a29 <close>
    151c:	83 c4 10             	add    $0x10,%esp
      wait();
    151f:	e8 e5 14 00 00       	call   2a09 <wait>
  for(i = 0; i < 40; i++){
    1524:	83 fb 28             	cmp    $0x28,%ebx
    1527:	0f 84 ab 00 00 00    	je     15d8 <concreate+0x128>
    file[1] = '0' + i;
    152d:	8d 43 30             	lea    0x30(%ebx),%eax
    unlink(file);
    1530:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    1533:	88 44 24 12          	mov    %al,0x12(%esp)
    unlink(file);
    1537:	56                   	push   %esi
    1538:	e8 14 15 00 00       	call   2a51 <unlink>
    pid = fork();
    153d:	e8 b7 14 00 00       	call   29f9 <fork>
    if(pid && (i % 3) == 1){
    1542:	83 c4 10             	add    $0x10,%esp
    1545:	85 c0                	test   %eax,%eax
    1547:	75 97                	jne    14e0 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1549:	89 d8                	mov    %ebx,%eax
    154b:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1550:	f7 ea                	imul   %edx
    1552:	89 d8                	mov    %ebx,%eax
    1554:	c1 f8 1f             	sar    $0x1f,%eax
    1557:	d1 fa                	sar    %edx
    1559:	29 c2                	sub    %eax,%edx
    155b:	8d 04 92             	lea    (%edx,%edx,4),%eax
    155e:	29 c3                	sub    %eax,%ebx
    1560:	83 fb 01             	cmp    $0x1,%ebx
    1563:	74 33                	je     1598 <concreate+0xe8>
      fd = open(file, O_CREATE | O_RDWR);
    1565:	83 ec 08             	sub    $0x8,%esp
    1568:	68 02 02 00 00       	push   $0x202
    156d:	56                   	push   %esi
    156e:	e8 ce 14 00 00       	call   2a41 <open>
      if(fd < 0){
    1573:	83 c4 10             	add    $0x10,%esp
    1576:	85 c0                	test   %eax,%eax
    1578:	0f 89 e6 01 00 00    	jns    1764 <concreate+0x2b4>
        printf(1, "concreate create %s failed\n", file);
    157e:	83 ec 04             	sub    $0x4,%esp
    1581:	56                   	push   %esi
    1582:	68 e4 33 00 00       	push   $0x33e4
    1587:	6a 01                	push   $0x1
    1589:	e8 b2 15 00 00       	call   2b40 <printf>
        exit();
    158e:	e8 6e 14 00 00       	call   2a01 <exit>
    1593:	90                   	nop
    1594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    1598:	83 ec 08             	sub    $0x8,%esp
    159b:	56                   	push   %esi
    159c:	68 e1 33 00 00       	push   $0x33e1
    15a1:	e8 bb 14 00 00       	call   2a61 <link>
    15a6:	83 c4 10             	add    $0x10,%esp
      exit();
    15a9:	e8 53 14 00 00       	call   2a01 <exit>
    15ae:	66 90                	xchg   %ax,%ax
      link("C0", file);
    15b0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    15b3:	83 c3 01             	add    $0x1,%ebx
      link("C0", file);
    15b6:	56                   	push   %esi
    15b7:	68 e1 33 00 00       	push   $0x33e1
    15bc:	e8 a0 14 00 00       	call   2a61 <link>
    15c1:	83 c4 10             	add    $0x10,%esp
      wait();
    15c4:	e8 40 14 00 00       	call   2a09 <wait>
  for(i = 0; i < 40; i++){
    15c9:	83 fb 28             	cmp    $0x28,%ebx
    15cc:	0f 85 5b ff ff ff    	jne    152d <concreate+0x7d>
    15d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  memset(fa, 0, sizeof(fa));
    15d8:	83 ec 04             	sub    $0x4,%esp
  n = 0;
    15db:	31 ed                	xor    %ebp,%ebp
  memset(fa, 0, sizeof(fa));
    15dd:	6a 28                	push   $0x28
    15df:	6a 00                	push   $0x0
    15e1:	8d 44 24 24          	lea    0x24(%esp),%eax
    15e5:	50                   	push   %eax
    15e6:	e8 95 12 00 00       	call   2880 <memset>
  fd = open(".", 0);
    15eb:	58                   	pop    %eax
    15ec:	5a                   	pop    %edx
    15ed:	6a 00                	push   $0x0
    15ef:	68 ca 35 00 00       	push   $0x35ca
    15f4:	e8 48 14 00 00       	call   2a41 <open>
  while(read(fd, &de, sizeof(de)) > 0){
    15f9:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    15fc:	89 c3                	mov    %eax,%ebx
    15fe:	8d 7c 24 08          	lea    0x8(%esp),%edi
    1602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1608:	83 ec 04             	sub    $0x4,%esp
    160b:	6a 10                	push   $0x10
    160d:	57                   	push   %edi
    160e:	53                   	push   %ebx
    160f:	e8 05 14 00 00       	call   2a19 <read>
    1614:	83 c4 10             	add    $0x10,%esp
    1617:	85 c0                	test   %eax,%eax
    1619:	7e 45                	jle    1660 <concreate+0x1b0>
    if(de.inum == 0)
    161b:	66 83 7c 24 08 00    	cmpw   $0x0,0x8(%esp)
    1621:	74 e5                	je     1608 <concreate+0x158>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1623:	80 7c 24 0a 43       	cmpb   $0x43,0xa(%esp)
    1628:	75 de                	jne    1608 <concreate+0x158>
    162a:	80 7c 24 0c 00       	cmpb   $0x0,0xc(%esp)
    162f:	75 d7                	jne    1608 <concreate+0x158>
      i = de.name[1] - '0';
    1631:	0f be 44 24 0b       	movsbl 0xb(%esp),%eax
    1636:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1639:	83 f8 27             	cmp    $0x27,%eax
    163c:	0f 87 09 01 00 00    	ja     174b <concreate+0x29b>
      if(fa[i]){
    1642:	80 7c 04 18 00       	cmpb   $0x0,0x18(%esp,%eax,1)
    1647:	0f 85 e5 00 00 00    	jne    1732 <concreate+0x282>
      fa[i] = 1;
    164d:	c6 44 04 18 01       	movb   $0x1,0x18(%esp,%eax,1)
      n++;
    1652:	83 c5 01             	add    $0x1,%ebp
    1655:	eb b1                	jmp    1608 <concreate+0x158>
    1657:	89 f6                	mov    %esi,%esi
    1659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  close(fd);
    1660:	83 ec 0c             	sub    $0xc,%esp
    1663:	53                   	push   %ebx
    1664:	e8 c0 13 00 00       	call   2a29 <close>
  if(n != 40){
    1669:	83 c4 10             	add    $0x10,%esp
    166c:	83 fd 28             	cmp    $0x28,%ebp
    166f:	0f 85 a9 00 00 00    	jne    171e <concreate+0x26e>
    1675:	31 db                	xor    %ebx,%ebx
    if(((i % 3) == 0 && pid == 0) ||
    1677:	bf 56 55 55 55       	mov    $0x55555556,%edi
    167c:	eb 32                	jmp    16b0 <concreate+0x200>
    167e:	66 90                	xchg   %ax,%ax
       ((i % 3) == 1 && pid != 0)){
    1680:	83 fa 01             	cmp    $0x1,%edx
    1683:	75 59                	jne    16de <concreate+0x22e>
      fd = open(file, 0);
    1685:	83 ec 08             	sub    $0x8,%esp
    1688:	6a 00                	push   $0x0
    168a:	56                   	push   %esi
    168b:	e8 b1 13 00 00       	call   2a41 <open>
      close(fd);
    1690:	89 04 24             	mov    %eax,(%esp)
    1693:	e8 91 13 00 00       	call   2a29 <close>
    1698:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    169b:	85 ed                	test   %ebp,%ebp
    169d:	0f 84 06 ff ff ff    	je     15a9 <concreate+0xf9>
  for(i = 0; i < 40; i++){
    16a3:	83 c3 01             	add    $0x1,%ebx
      wait();
    16a6:	e8 5e 13 00 00       	call   2a09 <wait>
  for(i = 0; i < 40; i++){
    16ab:	83 fb 28             	cmp    $0x28,%ebx
    16ae:	74 40                	je     16f0 <concreate+0x240>
    file[1] = '0' + i;
    16b0:	8d 43 30             	lea    0x30(%ebx),%eax
    16b3:	88 44 24 06          	mov    %al,0x6(%esp)
    pid = fork();
    16b7:	e8 3d 13 00 00       	call   29f9 <fork>
    if(pid < 0){
    16bc:	85 c0                	test   %eax,%eax
    pid = fork();
    16be:	89 c5                	mov    %eax,%ebp
    if(pid < 0){
    16c0:	78 48                	js     170a <concreate+0x25a>
    if(((i % 3) == 0 && pid == 0) ||
    16c2:	89 d8                	mov    %ebx,%eax
    16c4:	f7 ef                	imul   %edi
    16c6:	89 d8                	mov    %ebx,%eax
    16c8:	c1 f8 1f             	sar    $0x1f,%eax
    16cb:	29 c2                	sub    %eax,%edx
    16cd:	8d 04 52             	lea    (%edx,%edx,2),%eax
    16d0:	89 da                	mov    %ebx,%edx
    16d2:	29 c2                	sub    %eax,%edx
    16d4:	89 e8                	mov    %ebp,%eax
    16d6:	09 d0                	or     %edx,%eax
    16d8:	74 ab                	je     1685 <concreate+0x1d5>
       ((i % 3) == 1 && pid != 0)){
    16da:	85 ed                	test   %ebp,%ebp
    16dc:	75 a2                	jne    1680 <concreate+0x1d0>
      unlink(file);
    16de:	83 ec 0c             	sub    $0xc,%esp
    16e1:	56                   	push   %esi
    16e2:	e8 6a 13 00 00       	call   2a51 <unlink>
    16e7:	83 c4 10             	add    $0x10,%esp
    16ea:	eb af                	jmp    169b <concreate+0x1eb>
    16ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "concreate ok\n");
    16f0:	83 ec 08             	sub    $0x8,%esp
    16f3:	68 36 34 00 00       	push   $0x3436
    16f8:	6a 01                	push   $0x1
    16fa:	e8 41 14 00 00       	call   2b40 <printf>
}
    16ff:	83 c4 10             	add    $0x10,%esp
    1702:	83 c4 4c             	add    $0x4c,%esp
    1705:	5b                   	pop    %ebx
    1706:	5e                   	pop    %esi
    1707:	5f                   	pop    %edi
    1708:	5d                   	pop    %ebp
    1709:	c3                   	ret    
      printf(1, "fork failed\n");
    170a:	83 ec 08             	sub    $0x8,%esp
    170d:	68 60 31 00 00       	push   $0x3160
    1712:	6a 01                	push   $0x1
    1714:	e8 27 14 00 00       	call   2b40 <printf>
      exit();
    1719:	e8 e3 12 00 00       	call   2a01 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    171e:	83 ec 08             	sub    $0x8,%esp
    1721:	68 fc 3c 00 00       	push   $0x3cfc
    1726:	6a 01                	push   $0x1
    1728:	e8 13 14 00 00       	call   2b40 <printf>
    exit();
    172d:	e8 cf 12 00 00       	call   2a01 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1732:	83 ec 04             	sub    $0x4,%esp
    1735:	8d 44 24 0e          	lea    0xe(%esp),%eax
    1739:	50                   	push   %eax
    173a:	68 19 34 00 00       	push   $0x3419
    173f:	6a 01                	push   $0x1
    1741:	e8 fa 13 00 00       	call   2b40 <printf>
        exit();
    1746:	e8 b6 12 00 00       	call   2a01 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    174b:	83 ec 04             	sub    $0x4,%esp
    174e:	8d 44 24 0e          	lea    0xe(%esp),%eax
    1752:	50                   	push   %eax
    1753:	68 00 34 00 00       	push   $0x3400
    1758:	6a 01                	push   $0x1
    175a:	e8 e1 13 00 00       	call   2b40 <printf>
        exit();
    175f:	e8 9d 12 00 00       	call   2a01 <exit>
      close(fd);
    1764:	83 ec 0c             	sub    $0xc,%esp
    1767:	50                   	push   %eax
    1768:	e8 bc 12 00 00       	call   2a29 <close>
    176d:	83 c4 10             	add    $0x10,%esp
    1770:	e9 34 fe ff ff       	jmp    15a9 <concreate+0xf9>
    1775:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001780 <bigdir>:
{
    1780:	57                   	push   %edi
    1781:	56                   	push   %esi
    1782:	53                   	push   %ebx
    1783:	83 ec 18             	sub    $0x18,%esp
  printf(1, "bigdir test\n");
    1786:	68 44 34 00 00       	push   $0x3444
    178b:	6a 01                	push   $0x1
    178d:	e8 ae 13 00 00       	call   2b40 <printf>
  unlink("bd");
    1792:	c7 04 24 51 34 00 00 	movl   $0x3451,(%esp)
    1799:	e8 b3 12 00 00       	call   2a51 <unlink>
  fd = open("bd", O_CREATE);
    179e:	58                   	pop    %eax
    179f:	5a                   	pop    %edx
    17a0:	68 00 02 00 00       	push   $0x200
    17a5:	68 51 34 00 00       	push   $0x3451
    17aa:	e8 92 12 00 00       	call   2a41 <open>
  if(fd < 0){
    17af:	83 c4 10             	add    $0x10,%esp
    17b2:	85 c0                	test   %eax,%eax
    17b4:	0f 88 e9 00 00 00    	js     18a3 <bigdir+0x123>
  close(fd);
    17ba:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    17bd:	31 f6                	xor    %esi,%esi
  close(fd);
    17bf:	50                   	push   %eax
    17c0:	e8 64 12 00 00       	call   2a29 <close>
    17c5:	83 c4 10             	add    $0x10,%esp
    17c8:	8d 7c 24 06          	lea    0x6(%esp),%edi
    17cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    name[1] = '0' + (i / 64);
    17d0:	89 f0                	mov    %esi,%eax
    name[0] = 'x';
    17d2:	c6 44 24 06 78       	movb   $0x78,0x6(%esp)
    name[3] = '\0';
    17d7:	c6 44 24 09 00       	movb   $0x0,0x9(%esp)
    name[1] = '0' + (i / 64);
    17dc:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    17df:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + (i / 64);
    17e2:	83 c0 30             	add    $0x30,%eax
    17e5:	88 44 24 0f          	mov    %al,0xf(%esp)
    name[2] = '0' + (i % 64);
    17e9:	89 f0                	mov    %esi,%eax
    17eb:	83 e0 3f             	and    $0x3f,%eax
    17ee:	83 c0 30             	add    $0x30,%eax
    17f1:	88 44 24 10          	mov    %al,0x10(%esp)
    if(link("bd", name) != 0){
    17f5:	57                   	push   %edi
    17f6:	68 51 34 00 00       	push   $0x3451
    17fb:	e8 61 12 00 00       	call   2a61 <link>
    1800:	83 c4 10             	add    $0x10,%esp
    1803:	85 c0                	test   %eax,%eax
    1805:	89 c3                	mov    %eax,%ebx
    1807:	75 72                	jne    187b <bigdir+0xfb>
  for(i = 0; i < 500; i++){
    1809:	83 c6 01             	add    $0x1,%esi
    180c:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1812:	75 bc                	jne    17d0 <bigdir+0x50>
  unlink("bd");
    1814:	83 ec 0c             	sub    $0xc,%esp
    1817:	68 51 34 00 00       	push   $0x3451
    181c:	e8 30 12 00 00       	call   2a51 <unlink>
    1821:	83 c4 10             	add    $0x10,%esp
    1824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    name[1] = '0' + (i / 64);
    1828:	89 d8                	mov    %ebx,%eax
    name[0] = 'x';
    182a:	c6 44 24 06 78       	movb   $0x78,0x6(%esp)
    name[3] = '\0';
    182f:	c6 44 24 09 00       	movb   $0x0,0x9(%esp)
    name[1] = '0' + (i / 64);
    1834:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1837:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + (i / 64);
    183a:	83 c0 30             	add    $0x30,%eax
    183d:	88 44 24 13          	mov    %al,0x13(%esp)
    name[2] = '0' + (i % 64);
    1841:	89 d8                	mov    %ebx,%eax
    1843:	83 e0 3f             	and    $0x3f,%eax
    1846:	83 c0 30             	add    $0x30,%eax
    1849:	88 44 24 14          	mov    %al,0x14(%esp)
    if(unlink(name) != 0){
    184d:	57                   	push   %edi
    184e:	e8 fe 11 00 00       	call   2a51 <unlink>
    1853:	83 c4 10             	add    $0x10,%esp
    1856:	85 c0                	test   %eax,%eax
    1858:	75 35                	jne    188f <bigdir+0x10f>
  for(i = 0; i < 500; i++){
    185a:	83 c3 01             	add    $0x1,%ebx
    185d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1863:	75 c3                	jne    1828 <bigdir+0xa8>
  printf(1, "bigdir ok\n");
    1865:	83 ec 08             	sub    $0x8,%esp
    1868:	68 93 34 00 00       	push   $0x3493
    186d:	6a 01                	push   $0x1
    186f:	e8 cc 12 00 00       	call   2b40 <printf>
}
    1874:	83 c4 20             	add    $0x20,%esp
    1877:	5b                   	pop    %ebx
    1878:	5e                   	pop    %esi
    1879:	5f                   	pop    %edi
    187a:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    187b:	83 ec 08             	sub    $0x8,%esp
    187e:	68 6a 34 00 00       	push   $0x346a
    1883:	6a 01                	push   $0x1
    1885:	e8 b6 12 00 00       	call   2b40 <printf>
      exit();
    188a:	e8 72 11 00 00       	call   2a01 <exit>
      printf(1, "bigdir unlink failed");
    188f:	83 ec 08             	sub    $0x8,%esp
    1892:	68 7e 34 00 00       	push   $0x347e
    1897:	6a 01                	push   $0x1
    1899:	e8 a2 12 00 00       	call   2b40 <printf>
      exit();
    189e:	e8 5e 11 00 00       	call   2a01 <exit>
    printf(1, "bigdir create failed\n");
    18a3:	83 ec 08             	sub    $0x8,%esp
    18a6:	68 54 34 00 00       	push   $0x3454
    18ab:	6a 01                	push   $0x1
    18ad:	e8 8e 12 00 00       	call   2b40 <printf>
    exit();
    18b2:	e8 4a 11 00 00       	call   2a01 <exit>
    18b7:	89 f6                	mov    %esi,%esi
    18b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000018c0 <subdir>:
{
    18c0:	53                   	push   %ebx
    18c1:	83 ec 10             	sub    $0x10,%esp
  printf(1, "subdir test\n");
    18c4:	68 9e 34 00 00       	push   $0x349e
    18c9:	6a 01                	push   $0x1
    18cb:	e8 70 12 00 00       	call   2b40 <printf>
  unlink("ff");
    18d0:	c7 04 24 27 35 00 00 	movl   $0x3527,(%esp)
    18d7:	e8 75 11 00 00       	call   2a51 <unlink>
  if(mkdir("dd") != 0){
    18dc:	c7 04 24 c4 35 00 00 	movl   $0x35c4,(%esp)
    18e3:	e8 81 11 00 00       	call   2a69 <mkdir>
    18e8:	83 c4 10             	add    $0x10,%esp
    18eb:	85 c0                	test   %eax,%eax
    18ed:	0f 85 b0 05 00 00    	jne    1ea3 <subdir+0x5e3>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    18f3:	83 ec 08             	sub    $0x8,%esp
    18f6:	68 02 02 00 00       	push   $0x202
    18fb:	68 fd 34 00 00       	push   $0x34fd
    1900:	e8 3c 11 00 00       	call   2a41 <open>
  if(fd < 0){
    1905:	83 c4 10             	add    $0x10,%esp
    1908:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    190a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    190c:	0f 88 7e 05 00 00    	js     1e90 <subdir+0x5d0>
  write(fd, "ff", 2);
    1912:	83 ec 04             	sub    $0x4,%esp
    1915:	6a 02                	push   $0x2
    1917:	68 27 35 00 00       	push   $0x3527
    191c:	50                   	push   %eax
    191d:	e8 ff 10 00 00       	call   2a21 <write>
  close(fd);
    1922:	89 1c 24             	mov    %ebx,(%esp)
    1925:	e8 ff 10 00 00       	call   2a29 <close>
  if(unlink("dd") >= 0){
    192a:	c7 04 24 c4 35 00 00 	movl   $0x35c4,(%esp)
    1931:	e8 1b 11 00 00       	call   2a51 <unlink>
    1936:	83 c4 10             	add    $0x10,%esp
    1939:	85 c0                	test   %eax,%eax
    193b:	0f 89 3c 05 00 00    	jns    1e7d <subdir+0x5bd>
  if(mkdir("/dd/dd") != 0){
    1941:	83 ec 0c             	sub    $0xc,%esp
    1944:	68 d8 34 00 00       	push   $0x34d8
    1949:	e8 1b 11 00 00       	call   2a69 <mkdir>
    194e:	83 c4 10             	add    $0x10,%esp
    1951:	85 c0                	test   %eax,%eax
    1953:	0f 85 11 05 00 00    	jne    1e6a <subdir+0x5aa>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1959:	83 ec 08             	sub    $0x8,%esp
    195c:	68 02 02 00 00       	push   $0x202
    1961:	68 fa 34 00 00       	push   $0x34fa
    1966:	e8 d6 10 00 00       	call   2a41 <open>
  if(fd < 0){
    196b:	83 c4 10             	add    $0x10,%esp
    196e:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1970:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1972:	0f 88 21 04 00 00    	js     1d99 <subdir+0x4d9>
  write(fd, "FF", 2);
    1978:	83 ec 04             	sub    $0x4,%esp
    197b:	6a 02                	push   $0x2
    197d:	68 1b 35 00 00       	push   $0x351b
    1982:	50                   	push   %eax
    1983:	e8 99 10 00 00       	call   2a21 <write>
  close(fd);
    1988:	89 1c 24             	mov    %ebx,(%esp)
    198b:	e8 99 10 00 00       	call   2a29 <close>
  fd = open("dd/dd/../ff", 0);
    1990:	58                   	pop    %eax
    1991:	5a                   	pop    %edx
    1992:	6a 00                	push   $0x0
    1994:	68 1e 35 00 00       	push   $0x351e
    1999:	e8 a3 10 00 00       	call   2a41 <open>
  if(fd < 0){
    199e:	83 c4 10             	add    $0x10,%esp
    19a1:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    19a3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    19a5:	0f 88 db 03 00 00    	js     1d86 <subdir+0x4c6>
  cc = read(fd, buf, sizeof(buf));
    19ab:	83 ec 04             	sub    $0x4,%esp
    19ae:	68 00 08 00 00       	push   $0x800
    19b3:	68 e0 59 00 00       	push   $0x59e0
    19b8:	50                   	push   %eax
    19b9:	e8 5b 10 00 00       	call   2a19 <read>
  if(cc != 2 || buf[0] != 'f'){
    19be:	83 c4 10             	add    $0x10,%esp
    19c1:	83 f8 02             	cmp    $0x2,%eax
    19c4:	0f 85 37 03 00 00    	jne    1d01 <subdir+0x441>
    19ca:	80 3d e0 59 00 00 66 	cmpb   $0x66,0x59e0
    19d1:	0f 85 2a 03 00 00    	jne    1d01 <subdir+0x441>
  close(fd);
    19d7:	83 ec 0c             	sub    $0xc,%esp
    19da:	53                   	push   %ebx
    19db:	e8 49 10 00 00       	call   2a29 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    19e0:	5b                   	pop    %ebx
    19e1:	58                   	pop    %eax
    19e2:	68 5e 35 00 00       	push   $0x355e
    19e7:	68 fa 34 00 00       	push   $0x34fa
    19ec:	e8 70 10 00 00       	call   2a61 <link>
    19f1:	83 c4 10             	add    $0x10,%esp
    19f4:	85 c0                	test   %eax,%eax
    19f6:	0f 85 c3 03 00 00    	jne    1dbf <subdir+0x4ff>
  if(unlink("dd/dd/ff") != 0){
    19fc:	83 ec 0c             	sub    $0xc,%esp
    19ff:	68 fa 34 00 00       	push   $0x34fa
    1a04:	e8 48 10 00 00       	call   2a51 <unlink>
    1a09:	83 c4 10             	add    $0x10,%esp
    1a0c:	85 c0                	test   %eax,%eax
    1a0e:	0f 85 13 03 00 00    	jne    1d27 <subdir+0x467>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1a14:	83 ec 08             	sub    $0x8,%esp
    1a17:	6a 00                	push   $0x0
    1a19:	68 fa 34 00 00       	push   $0x34fa
    1a1e:	e8 1e 10 00 00       	call   2a41 <open>
    1a23:	83 c4 10             	add    $0x10,%esp
    1a26:	85 c0                	test   %eax,%eax
    1a28:	0f 89 29 04 00 00    	jns    1e57 <subdir+0x597>
  if(chdir("dd") != 0){
    1a2e:	83 ec 0c             	sub    $0xc,%esp
    1a31:	68 c4 35 00 00       	push   $0x35c4
    1a36:	e8 36 10 00 00       	call   2a71 <chdir>
    1a3b:	83 c4 10             	add    $0x10,%esp
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	0f 85 fe 03 00 00    	jne    1e44 <subdir+0x584>
  if(chdir("dd/../../dd") != 0){
    1a46:	83 ec 0c             	sub    $0xc,%esp
    1a49:	68 92 35 00 00       	push   $0x3592
    1a4e:	e8 1e 10 00 00       	call   2a71 <chdir>
    1a53:	83 c4 10             	add    $0x10,%esp
    1a56:	85 c0                	test   %eax,%eax
    1a58:	0f 85 b6 02 00 00    	jne    1d14 <subdir+0x454>
  if(chdir("dd/../../../dd") != 0){
    1a5e:	83 ec 0c             	sub    $0xc,%esp
    1a61:	68 b8 35 00 00       	push   $0x35b8
    1a66:	e8 06 10 00 00       	call   2a71 <chdir>
    1a6b:	83 c4 10             	add    $0x10,%esp
    1a6e:	85 c0                	test   %eax,%eax
    1a70:	0f 85 9e 02 00 00    	jne    1d14 <subdir+0x454>
  if(chdir("./..") != 0){
    1a76:	83 ec 0c             	sub    $0xc,%esp
    1a79:	68 c7 35 00 00       	push   $0x35c7
    1a7e:	e8 ee 0f 00 00       	call   2a71 <chdir>
    1a83:	83 c4 10             	add    $0x10,%esp
    1a86:	85 c0                	test   %eax,%eax
    1a88:	0f 85 1e 03 00 00    	jne    1dac <subdir+0x4ec>
  fd = open("dd/dd/ffff", 0);
    1a8e:	83 ec 08             	sub    $0x8,%esp
    1a91:	6a 00                	push   $0x0
    1a93:	68 5e 35 00 00       	push   $0x355e
    1a98:	e8 a4 0f 00 00       	call   2a41 <open>
  if(fd < 0){
    1a9d:	83 c4 10             	add    $0x10,%esp
    1aa0:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    1aa2:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1aa4:	0f 88 dd 04 00 00    	js     1f87 <subdir+0x6c7>
  if(read(fd, buf, sizeof(buf)) != 2){
    1aaa:	83 ec 04             	sub    $0x4,%esp
    1aad:	68 00 08 00 00       	push   $0x800
    1ab2:	68 e0 59 00 00       	push   $0x59e0
    1ab7:	50                   	push   %eax
    1ab8:	e8 5c 0f 00 00       	call   2a19 <read>
    1abd:	83 c4 10             	add    $0x10,%esp
    1ac0:	83 f8 02             	cmp    $0x2,%eax
    1ac3:	0f 85 ab 04 00 00    	jne    1f74 <subdir+0x6b4>
  close(fd);
    1ac9:	83 ec 0c             	sub    $0xc,%esp
    1acc:	53                   	push   %ebx
    1acd:	e8 57 0f 00 00       	call   2a29 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ad2:	59                   	pop    %ecx
    1ad3:	5b                   	pop    %ebx
    1ad4:	6a 00                	push   $0x0
    1ad6:	68 fa 34 00 00       	push   $0x34fa
    1adb:	e8 61 0f 00 00       	call   2a41 <open>
    1ae0:	83 c4 10             	add    $0x10,%esp
    1ae3:	85 c0                	test   %eax,%eax
    1ae5:	0f 89 62 02 00 00    	jns    1d4d <subdir+0x48d>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1aeb:	83 ec 08             	sub    $0x8,%esp
    1aee:	68 02 02 00 00       	push   $0x202
    1af3:	68 12 36 00 00       	push   $0x3612
    1af8:	e8 44 0f 00 00       	call   2a41 <open>
    1afd:	83 c4 10             	add    $0x10,%esp
    1b00:	85 c0                	test   %eax,%eax
    1b02:	0f 89 32 02 00 00    	jns    1d3a <subdir+0x47a>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1b08:	83 ec 08             	sub    $0x8,%esp
    1b0b:	68 02 02 00 00       	push   $0x202
    1b10:	68 37 36 00 00       	push   $0x3637
    1b15:	e8 27 0f 00 00       	call   2a41 <open>
    1b1a:	83 c4 10             	add    $0x10,%esp
    1b1d:	85 c0                	test   %eax,%eax
    1b1f:	0f 89 0c 03 00 00    	jns    1e31 <subdir+0x571>
  if(open("dd", O_CREATE) >= 0){
    1b25:	83 ec 08             	sub    $0x8,%esp
    1b28:	68 00 02 00 00       	push   $0x200
    1b2d:	68 c4 35 00 00       	push   $0x35c4
    1b32:	e8 0a 0f 00 00       	call   2a41 <open>
    1b37:	83 c4 10             	add    $0x10,%esp
    1b3a:	85 c0                	test   %eax,%eax
    1b3c:	0f 89 dc 02 00 00    	jns    1e1e <subdir+0x55e>
  if(open("dd", O_RDWR) >= 0){
    1b42:	83 ec 08             	sub    $0x8,%esp
    1b45:	6a 02                	push   $0x2
    1b47:	68 c4 35 00 00       	push   $0x35c4
    1b4c:	e8 f0 0e 00 00       	call   2a41 <open>
    1b51:	83 c4 10             	add    $0x10,%esp
    1b54:	85 c0                	test   %eax,%eax
    1b56:	0f 89 af 02 00 00    	jns    1e0b <subdir+0x54b>
  if(open("dd", O_WRONLY) >= 0){
    1b5c:	83 ec 08             	sub    $0x8,%esp
    1b5f:	6a 01                	push   $0x1
    1b61:	68 c4 35 00 00       	push   $0x35c4
    1b66:	e8 d6 0e 00 00       	call   2a41 <open>
    1b6b:	83 c4 10             	add    $0x10,%esp
    1b6e:	85 c0                	test   %eax,%eax
    1b70:	0f 89 82 02 00 00    	jns    1df8 <subdir+0x538>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1b76:	83 ec 08             	sub    $0x8,%esp
    1b79:	68 a6 36 00 00       	push   $0x36a6
    1b7e:	68 12 36 00 00       	push   $0x3612
    1b83:	e8 d9 0e 00 00       	call   2a61 <link>
    1b88:	83 c4 10             	add    $0x10,%esp
    1b8b:	85 c0                	test   %eax,%eax
    1b8d:	0f 84 52 02 00 00    	je     1de5 <subdir+0x525>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1b93:	83 ec 08             	sub    $0x8,%esp
    1b96:	68 a6 36 00 00       	push   $0x36a6
    1b9b:	68 37 36 00 00       	push   $0x3637
    1ba0:	e8 bc 0e 00 00       	call   2a61 <link>
    1ba5:	83 c4 10             	add    $0x10,%esp
    1ba8:	85 c0                	test   %eax,%eax
    1baa:	0f 84 22 02 00 00    	je     1dd2 <subdir+0x512>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1bb0:	83 ec 08             	sub    $0x8,%esp
    1bb3:	68 5e 35 00 00       	push   $0x355e
    1bb8:	68 fd 34 00 00       	push   $0x34fd
    1bbd:	e8 9f 0e 00 00       	call   2a61 <link>
    1bc2:	83 c4 10             	add    $0x10,%esp
    1bc5:	85 c0                	test   %eax,%eax
    1bc7:	0f 84 a6 01 00 00    	je     1d73 <subdir+0x4b3>
  if(mkdir("dd/ff/ff") == 0){
    1bcd:	83 ec 0c             	sub    $0xc,%esp
    1bd0:	68 12 36 00 00       	push   $0x3612
    1bd5:	e8 8f 0e 00 00       	call   2a69 <mkdir>
    1bda:	83 c4 10             	add    $0x10,%esp
    1bdd:	85 c0                	test   %eax,%eax
    1bdf:	0f 84 7b 01 00 00    	je     1d60 <subdir+0x4a0>
  if(mkdir("dd/xx/ff") == 0){
    1be5:	83 ec 0c             	sub    $0xc,%esp
    1be8:	68 37 36 00 00       	push   $0x3637
    1bed:	e8 77 0e 00 00       	call   2a69 <mkdir>
    1bf2:	83 c4 10             	add    $0x10,%esp
    1bf5:	85 c0                	test   %eax,%eax
    1bf7:	0f 84 64 03 00 00    	je     1f61 <subdir+0x6a1>
  if(mkdir("dd/dd/ffff") == 0){
    1bfd:	83 ec 0c             	sub    $0xc,%esp
    1c00:	68 5e 35 00 00       	push   $0x355e
    1c05:	e8 5f 0e 00 00       	call   2a69 <mkdir>
    1c0a:	83 c4 10             	add    $0x10,%esp
    1c0d:	85 c0                	test   %eax,%eax
    1c0f:	0f 84 39 03 00 00    	je     1f4e <subdir+0x68e>
  if(unlink("dd/xx/ff") == 0){
    1c15:	83 ec 0c             	sub    $0xc,%esp
    1c18:	68 37 36 00 00       	push   $0x3637
    1c1d:	e8 2f 0e 00 00       	call   2a51 <unlink>
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	85 c0                	test   %eax,%eax
    1c27:	0f 84 0e 03 00 00    	je     1f3b <subdir+0x67b>
  if(unlink("dd/ff/ff") == 0){
    1c2d:	83 ec 0c             	sub    $0xc,%esp
    1c30:	68 12 36 00 00       	push   $0x3612
    1c35:	e8 17 0e 00 00       	call   2a51 <unlink>
    1c3a:	83 c4 10             	add    $0x10,%esp
    1c3d:	85 c0                	test   %eax,%eax
    1c3f:	0f 84 e3 02 00 00    	je     1f28 <subdir+0x668>
  if(chdir("dd/ff") == 0){
    1c45:	83 ec 0c             	sub    $0xc,%esp
    1c48:	68 fd 34 00 00       	push   $0x34fd
    1c4d:	e8 1f 0e 00 00       	call   2a71 <chdir>
    1c52:	83 c4 10             	add    $0x10,%esp
    1c55:	85 c0                	test   %eax,%eax
    1c57:	0f 84 b8 02 00 00    	je     1f15 <subdir+0x655>
  if(chdir("dd/xx") == 0){
    1c5d:	83 ec 0c             	sub    $0xc,%esp
    1c60:	68 a9 36 00 00       	push   $0x36a9
    1c65:	e8 07 0e 00 00       	call   2a71 <chdir>
    1c6a:	83 c4 10             	add    $0x10,%esp
    1c6d:	85 c0                	test   %eax,%eax
    1c6f:	0f 84 8d 02 00 00    	je     1f02 <subdir+0x642>
  if(unlink("dd/dd/ffff") != 0){
    1c75:	83 ec 0c             	sub    $0xc,%esp
    1c78:	68 5e 35 00 00       	push   $0x355e
    1c7d:	e8 cf 0d 00 00       	call   2a51 <unlink>
    1c82:	83 c4 10             	add    $0x10,%esp
    1c85:	85 c0                	test   %eax,%eax
    1c87:	0f 85 9a 00 00 00    	jne    1d27 <subdir+0x467>
  if(unlink("dd/ff") != 0){
    1c8d:	83 ec 0c             	sub    $0xc,%esp
    1c90:	68 fd 34 00 00       	push   $0x34fd
    1c95:	e8 b7 0d 00 00       	call   2a51 <unlink>
    1c9a:	83 c4 10             	add    $0x10,%esp
    1c9d:	85 c0                	test   %eax,%eax
    1c9f:	0f 85 4a 02 00 00    	jne    1eef <subdir+0x62f>
  if(unlink("dd") == 0){
    1ca5:	83 ec 0c             	sub    $0xc,%esp
    1ca8:	68 c4 35 00 00       	push   $0x35c4
    1cad:	e8 9f 0d 00 00       	call   2a51 <unlink>
    1cb2:	83 c4 10             	add    $0x10,%esp
    1cb5:	85 c0                	test   %eax,%eax
    1cb7:	0f 84 1f 02 00 00    	je     1edc <subdir+0x61c>
  if(unlink("dd/dd") < 0){
    1cbd:	83 ec 0c             	sub    $0xc,%esp
    1cc0:	68 d9 34 00 00       	push   $0x34d9
    1cc5:	e8 87 0d 00 00       	call   2a51 <unlink>
    1cca:	83 c4 10             	add    $0x10,%esp
    1ccd:	85 c0                	test   %eax,%eax
    1ccf:	0f 88 f4 01 00 00    	js     1ec9 <subdir+0x609>
  if(unlink("dd") < 0){
    1cd5:	83 ec 0c             	sub    $0xc,%esp
    1cd8:	68 c4 35 00 00       	push   $0x35c4
    1cdd:	e8 6f 0d 00 00       	call   2a51 <unlink>
    1ce2:	83 c4 10             	add    $0x10,%esp
    1ce5:	85 c0                	test   %eax,%eax
    1ce7:	0f 88 c9 01 00 00    	js     1eb6 <subdir+0x5f6>
  printf(1, "subdir ok\n");
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 a6 37 00 00       	push   $0x37a6
    1cf5:	6a 01                	push   $0x1
    1cf7:	e8 44 0e 00 00       	call   2b40 <printf>
}
    1cfc:	83 c4 18             	add    $0x18,%esp
    1cff:	5b                   	pop    %ebx
    1d00:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    1d01:	50                   	push   %eax
    1d02:	50                   	push   %eax
    1d03:	68 43 35 00 00       	push   $0x3543
    1d08:	6a 01                	push   $0x1
    1d0a:	e8 31 0e 00 00       	call   2b40 <printf>
    exit();
    1d0f:	e8 ed 0c 00 00       	call   2a01 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    1d14:	50                   	push   %eax
    1d15:	50                   	push   %eax
    1d16:	68 9e 35 00 00       	push   $0x359e
    1d1b:	6a 01                	push   $0x1
    1d1d:	e8 1e 0e 00 00       	call   2b40 <printf>
    exit();
    1d22:	e8 da 0c 00 00       	call   2a01 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    1d27:	52                   	push   %edx
    1d28:	52                   	push   %edx
    1d29:	68 69 35 00 00       	push   $0x3569
    1d2e:	6a 01                	push   $0x1
    1d30:	e8 0b 0e 00 00       	call   2b40 <printf>
    exit();
    1d35:	e8 c7 0c 00 00       	call   2a01 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    1d3a:	50                   	push   %eax
    1d3b:	50                   	push   %eax
    1d3c:	68 1b 36 00 00       	push   $0x361b
    1d41:	6a 01                	push   $0x1
    1d43:	e8 f8 0d 00 00       	call   2b40 <printf>
    exit();
    1d48:	e8 b4 0c 00 00       	call   2a01 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1d4d:	52                   	push   %edx
    1d4e:	52                   	push   %edx
    1d4f:	68 a0 3d 00 00       	push   $0x3da0
    1d54:	6a 01                	push   $0x1
    1d56:	e8 e5 0d 00 00       	call   2b40 <printf>
    exit();
    1d5b:	e8 a1 0c 00 00       	call   2a01 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1d60:	52                   	push   %edx
    1d61:	52                   	push   %edx
    1d62:	68 af 36 00 00       	push   $0x36af
    1d67:	6a 01                	push   $0x1
    1d69:	e8 d2 0d 00 00       	call   2b40 <printf>
    exit();
    1d6e:	e8 8e 0c 00 00       	call   2a01 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1d73:	51                   	push   %ecx
    1d74:	51                   	push   %ecx
    1d75:	68 10 3e 00 00       	push   $0x3e10
    1d7a:	6a 01                	push   $0x1
    1d7c:	e8 bf 0d 00 00       	call   2b40 <printf>
    exit();
    1d81:	e8 7b 0c 00 00       	call   2a01 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    1d86:	50                   	push   %eax
    1d87:	50                   	push   %eax
    1d88:	68 2a 35 00 00       	push   $0x352a
    1d8d:	6a 01                	push   $0x1
    1d8f:	e8 ac 0d 00 00       	call   2b40 <printf>
    exit();
    1d94:	e8 68 0c 00 00       	call   2a01 <exit>
    printf(1, "create dd/dd/ff failed\n");
    1d99:	51                   	push   %ecx
    1d9a:	51                   	push   %ecx
    1d9b:	68 03 35 00 00       	push   $0x3503
    1da0:	6a 01                	push   $0x1
    1da2:	e8 99 0d 00 00       	call   2b40 <printf>
    exit();
    1da7:	e8 55 0c 00 00       	call   2a01 <exit>
    printf(1, "chdir ./.. failed\n");
    1dac:	50                   	push   %eax
    1dad:	50                   	push   %eax
    1dae:	68 cc 35 00 00       	push   $0x35cc
    1db3:	6a 01                	push   $0x1
    1db5:	e8 86 0d 00 00       	call   2b40 <printf>
    exit();
    1dba:	e8 42 0c 00 00       	call   2a01 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1dbf:	51                   	push   %ecx
    1dc0:	51                   	push   %ecx
    1dc1:	68 58 3d 00 00       	push   $0x3d58
    1dc6:	6a 01                	push   $0x1
    1dc8:	e8 73 0d 00 00       	call   2b40 <printf>
    exit();
    1dcd:	e8 2f 0c 00 00       	call   2a01 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    1dd2:	53                   	push   %ebx
    1dd3:	53                   	push   %ebx
    1dd4:	68 ec 3d 00 00       	push   $0x3dec
    1dd9:	6a 01                	push   $0x1
    1ddb:	e8 60 0d 00 00       	call   2b40 <printf>
    exit();
    1de0:	e8 1c 0c 00 00       	call   2a01 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    1de5:	50                   	push   %eax
    1de6:	50                   	push   %eax
    1de7:	68 c8 3d 00 00       	push   $0x3dc8
    1dec:	6a 01                	push   $0x1
    1dee:	e8 4d 0d 00 00       	call   2b40 <printf>
    exit();
    1df3:	e8 09 0c 00 00       	call   2a01 <exit>
    printf(1, "open dd wronly succeeded!\n");
    1df8:	50                   	push   %eax
    1df9:	50                   	push   %eax
    1dfa:	68 8b 36 00 00       	push   $0x368b
    1dff:	6a 01                	push   $0x1
    1e01:	e8 3a 0d 00 00       	call   2b40 <printf>
    exit();
    1e06:	e8 f6 0b 00 00       	call   2a01 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    1e0b:	50                   	push   %eax
    1e0c:	50                   	push   %eax
    1e0d:	68 72 36 00 00       	push   $0x3672
    1e12:	6a 01                	push   $0x1
    1e14:	e8 27 0d 00 00       	call   2b40 <printf>
    exit();
    1e19:	e8 e3 0b 00 00       	call   2a01 <exit>
    printf(1, "create dd succeeded!\n");
    1e1e:	50                   	push   %eax
    1e1f:	50                   	push   %eax
    1e20:	68 5c 36 00 00       	push   $0x365c
    1e25:	6a 01                	push   $0x1
    1e27:	e8 14 0d 00 00       	call   2b40 <printf>
    exit();
    1e2c:	e8 d0 0b 00 00       	call   2a01 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    1e31:	50                   	push   %eax
    1e32:	50                   	push   %eax
    1e33:	68 40 36 00 00       	push   $0x3640
    1e38:	6a 01                	push   $0x1
    1e3a:	e8 01 0d 00 00       	call   2b40 <printf>
    exit();
    1e3f:	e8 bd 0b 00 00       	call   2a01 <exit>
    printf(1, "chdir dd failed\n");
    1e44:	50                   	push   %eax
    1e45:	50                   	push   %eax
    1e46:	68 81 35 00 00       	push   $0x3581
    1e4b:	6a 01                	push   $0x1
    1e4d:	e8 ee 0c 00 00       	call   2b40 <printf>
    exit();
    1e52:	e8 aa 0b 00 00       	call   2a01 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1e57:	50                   	push   %eax
    1e58:	50                   	push   %eax
    1e59:	68 7c 3d 00 00       	push   $0x3d7c
    1e5e:	6a 01                	push   $0x1
    1e60:	e8 db 0c 00 00       	call   2b40 <printf>
    exit();
    1e65:	e8 97 0b 00 00       	call   2a01 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    1e6a:	53                   	push   %ebx
    1e6b:	53                   	push   %ebx
    1e6c:	68 df 34 00 00       	push   $0x34df
    1e71:	6a 01                	push   $0x1
    1e73:	e8 c8 0c 00 00       	call   2b40 <printf>
    exit();
    1e78:	e8 84 0b 00 00       	call   2a01 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1e7d:	50                   	push   %eax
    1e7e:	50                   	push   %eax
    1e7f:	68 30 3d 00 00       	push   $0x3d30
    1e84:	6a 01                	push   $0x1
    1e86:	e8 b5 0c 00 00       	call   2b40 <printf>
    exit();
    1e8b:	e8 71 0b 00 00       	call   2a01 <exit>
    printf(1, "create dd/ff failed\n");
    1e90:	50                   	push   %eax
    1e91:	50                   	push   %eax
    1e92:	68 c3 34 00 00       	push   $0x34c3
    1e97:	6a 01                	push   $0x1
    1e99:	e8 a2 0c 00 00       	call   2b40 <printf>
    exit();
    1e9e:	e8 5e 0b 00 00       	call   2a01 <exit>
    printf(1, "subdir mkdir dd failed\n");
    1ea3:	50                   	push   %eax
    1ea4:	50                   	push   %eax
    1ea5:	68 ab 34 00 00       	push   $0x34ab
    1eaa:	6a 01                	push   $0x1
    1eac:	e8 8f 0c 00 00       	call   2b40 <printf>
    exit();
    1eb1:	e8 4b 0b 00 00       	call   2a01 <exit>
    printf(1, "unlink dd failed\n");
    1eb6:	50                   	push   %eax
    1eb7:	50                   	push   %eax
    1eb8:	68 94 37 00 00       	push   $0x3794
    1ebd:	6a 01                	push   $0x1
    1ebf:	e8 7c 0c 00 00       	call   2b40 <printf>
    exit();
    1ec4:	e8 38 0b 00 00       	call   2a01 <exit>
    printf(1, "unlink dd/dd failed\n");
    1ec9:	52                   	push   %edx
    1eca:	52                   	push   %edx
    1ecb:	68 7f 37 00 00       	push   $0x377f
    1ed0:	6a 01                	push   $0x1
    1ed2:	e8 69 0c 00 00       	call   2b40 <printf>
    exit();
    1ed7:	e8 25 0b 00 00       	call   2a01 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    1edc:	51                   	push   %ecx
    1edd:	51                   	push   %ecx
    1ede:	68 34 3e 00 00       	push   $0x3e34
    1ee3:	6a 01                	push   $0x1
    1ee5:	e8 56 0c 00 00       	call   2b40 <printf>
    exit();
    1eea:	e8 12 0b 00 00       	call   2a01 <exit>
    printf(1, "unlink dd/ff failed\n");
    1eef:	53                   	push   %ebx
    1ef0:	53                   	push   %ebx
    1ef1:	68 6a 37 00 00       	push   $0x376a
    1ef6:	6a 01                	push   $0x1
    1ef8:	e8 43 0c 00 00       	call   2b40 <printf>
    exit();
    1efd:	e8 ff 0a 00 00       	call   2a01 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    1f02:	50                   	push   %eax
    1f03:	50                   	push   %eax
    1f04:	68 52 37 00 00       	push   $0x3752
    1f09:	6a 01                	push   $0x1
    1f0b:	e8 30 0c 00 00       	call   2b40 <printf>
    exit();
    1f10:	e8 ec 0a 00 00       	call   2a01 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    1f15:	50                   	push   %eax
    1f16:	50                   	push   %eax
    1f17:	68 3a 37 00 00       	push   $0x373a
    1f1c:	6a 01                	push   $0x1
    1f1e:	e8 1d 0c 00 00       	call   2b40 <printf>
    exit();
    1f23:	e8 d9 0a 00 00       	call   2a01 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    1f28:	50                   	push   %eax
    1f29:	50                   	push   %eax
    1f2a:	68 1e 37 00 00       	push   $0x371e
    1f2f:	6a 01                	push   $0x1
    1f31:	e8 0a 0c 00 00       	call   2b40 <printf>
    exit();
    1f36:	e8 c6 0a 00 00       	call   2a01 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    1f3b:	50                   	push   %eax
    1f3c:	50                   	push   %eax
    1f3d:	68 02 37 00 00       	push   $0x3702
    1f42:	6a 01                	push   $0x1
    1f44:	e8 f7 0b 00 00       	call   2b40 <printf>
    exit();
    1f49:	e8 b3 0a 00 00       	call   2a01 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    1f4e:	50                   	push   %eax
    1f4f:	50                   	push   %eax
    1f50:	68 e5 36 00 00       	push   $0x36e5
    1f55:	6a 01                	push   $0x1
    1f57:	e8 e4 0b 00 00       	call   2b40 <printf>
    exit();
    1f5c:	e8 a0 0a 00 00       	call   2a01 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    1f61:	50                   	push   %eax
    1f62:	50                   	push   %eax
    1f63:	68 ca 36 00 00       	push   $0x36ca
    1f68:	6a 01                	push   $0x1
    1f6a:	e8 d1 0b 00 00       	call   2b40 <printf>
    exit();
    1f6f:	e8 8d 0a 00 00       	call   2a01 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    1f74:	50                   	push   %eax
    1f75:	50                   	push   %eax
    1f76:	68 f7 35 00 00       	push   $0x35f7
    1f7b:	6a 01                	push   $0x1
    1f7d:	e8 be 0b 00 00       	call   2b40 <printf>
    exit();
    1f82:	e8 7a 0a 00 00       	call   2a01 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    1f87:	50                   	push   %eax
    1f88:	50                   	push   %eax
    1f89:	68 df 35 00 00       	push   $0x35df
    1f8e:	6a 01                	push   $0x1
    1f90:	e8 ab 0b 00 00       	call   2b40 <printf>
    exit();
    1f95:	e8 67 0a 00 00       	call   2a01 <exit>
    1f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001fa0 <bigfile>:
{
    1fa0:	57                   	push   %edi
    1fa1:	56                   	push   %esi
    1fa2:	53                   	push   %ebx
  printf(1, "bigfile test\n");
    1fa3:	83 ec 08             	sub    $0x8,%esp
    1fa6:	68 b1 37 00 00       	push   $0x37b1
    1fab:	6a 01                	push   $0x1
    1fad:	e8 8e 0b 00 00       	call   2b40 <printf>
  unlink("bigfile");
    1fb2:	c7 04 24 cd 37 00 00 	movl   $0x37cd,(%esp)
    1fb9:	e8 93 0a 00 00       	call   2a51 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    1fbe:	5e                   	pop    %esi
    1fbf:	5f                   	pop    %edi
    1fc0:	68 02 02 00 00       	push   $0x202
    1fc5:	68 cd 37 00 00       	push   $0x37cd
    1fca:	e8 72 0a 00 00       	call   2a41 <open>
  if(fd < 0){
    1fcf:	83 c4 10             	add    $0x10,%esp
    1fd2:	85 c0                	test   %eax,%eax
    1fd4:	0f 88 5e 01 00 00    	js     2138 <bigfile+0x198>
    1fda:	89 c6                	mov    %eax,%esi
    1fdc:	31 db                	xor    %ebx,%ebx
    1fde:	66 90                	xchg   %ax,%ax
    memset(buf, i, 600);
    1fe0:	83 ec 04             	sub    $0x4,%esp
    1fe3:	68 58 02 00 00       	push   $0x258
    1fe8:	53                   	push   %ebx
    1fe9:	68 e0 59 00 00       	push   $0x59e0
    1fee:	e8 8d 08 00 00       	call   2880 <memset>
    if(write(fd, buf, 600) != 600){
    1ff3:	83 c4 0c             	add    $0xc,%esp
    1ff6:	68 58 02 00 00       	push   $0x258
    1ffb:	68 e0 59 00 00       	push   $0x59e0
    2000:	56                   	push   %esi
    2001:	e8 1b 0a 00 00       	call   2a21 <write>
    2006:	83 c4 10             	add    $0x10,%esp
    2009:	3d 58 02 00 00       	cmp    $0x258,%eax
    200e:	0f 85 fc 00 00 00    	jne    2110 <bigfile+0x170>
  for(i = 0; i < 20; i++){
    2014:	83 c3 01             	add    $0x1,%ebx
    2017:	83 fb 14             	cmp    $0x14,%ebx
    201a:	75 c4                	jne    1fe0 <bigfile+0x40>
  close(fd);
    201c:	83 ec 0c             	sub    $0xc,%esp
    201f:	56                   	push   %esi
    2020:	e8 04 0a 00 00       	call   2a29 <close>
  fd = open("bigfile", 0);
    2025:	59                   	pop    %ecx
    2026:	5b                   	pop    %ebx
    2027:	6a 00                	push   $0x0
    2029:	68 cd 37 00 00       	push   $0x37cd
    202e:	e8 0e 0a 00 00       	call   2a41 <open>
  if(fd < 0){
    2033:	83 c4 10             	add    $0x10,%esp
    2036:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2038:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    203a:	0f 88 e4 00 00 00    	js     2124 <bigfile+0x184>
    2040:	31 f6                	xor    %esi,%esi
    2042:	31 db                	xor    %ebx,%ebx
    2044:	eb 38                	jmp    207e <bigfile+0xde>
    2046:	8d 76 00             	lea    0x0(%esi),%esi
    2049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(cc != 300){
    2050:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2055:	0f 85 8d 00 00 00    	jne    20e8 <bigfile+0x148>
    if(buf[0] != i/2 || buf[299] != i/2){
    205b:	0f be 05 e0 59 00 00 	movsbl 0x59e0,%eax
    2062:	89 da                	mov    %ebx,%edx
    2064:	d1 fa                	sar    %edx
    2066:	39 d0                	cmp    %edx,%eax
    2068:	75 6a                	jne    20d4 <bigfile+0x134>
    206a:	0f be 15 0b 5b 00 00 	movsbl 0x5b0b,%edx
    2071:	39 d0                	cmp    %edx,%eax
    2073:	75 5f                	jne    20d4 <bigfile+0x134>
    total += cc;
    2075:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  for(i = 0; ; i++){
    207b:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    207e:	83 ec 04             	sub    $0x4,%esp
    2081:	68 2c 01 00 00       	push   $0x12c
    2086:	68 e0 59 00 00       	push   $0x59e0
    208b:	57                   	push   %edi
    208c:	e8 88 09 00 00       	call   2a19 <read>
    if(cc < 0){
    2091:	83 c4 10             	add    $0x10,%esp
    2094:	85 c0                	test   %eax,%eax
    2096:	78 64                	js     20fc <bigfile+0x15c>
    if(cc == 0)
    2098:	75 b6                	jne    2050 <bigfile+0xb0>
  close(fd);
    209a:	83 ec 0c             	sub    $0xc,%esp
    209d:	57                   	push   %edi
    209e:	e8 86 09 00 00       	call   2a29 <close>
  if(total != 20*600){
    20a3:	83 c4 10             	add    $0x10,%esp
    20a6:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    20ac:	0f 85 9a 00 00 00    	jne    214c <bigfile+0x1ac>
  unlink("bigfile");
    20b2:	83 ec 0c             	sub    $0xc,%esp
    20b5:	68 cd 37 00 00       	push   $0x37cd
    20ba:	e8 92 09 00 00       	call   2a51 <unlink>
  printf(1, "bigfile test ok\n");
    20bf:	58                   	pop    %eax
    20c0:	5a                   	pop    %edx
    20c1:	68 5c 38 00 00       	push   $0x385c
    20c6:	6a 01                	push   $0x1
    20c8:	e8 73 0a 00 00       	call   2b40 <printf>
}
    20cd:	83 c4 10             	add    $0x10,%esp
    20d0:	5b                   	pop    %ebx
    20d1:	5e                   	pop    %esi
    20d2:	5f                   	pop    %edi
    20d3:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    20d4:	83 ec 08             	sub    $0x8,%esp
    20d7:	68 29 38 00 00       	push   $0x3829
    20dc:	6a 01                	push   $0x1
    20de:	e8 5d 0a 00 00       	call   2b40 <printf>
      exit();
    20e3:	e8 19 09 00 00       	call   2a01 <exit>
      printf(1, "short read bigfile\n");
    20e8:	83 ec 08             	sub    $0x8,%esp
    20eb:	68 15 38 00 00       	push   $0x3815
    20f0:	6a 01                	push   $0x1
    20f2:	e8 49 0a 00 00       	call   2b40 <printf>
      exit();
    20f7:	e8 05 09 00 00       	call   2a01 <exit>
      printf(1, "read bigfile failed\n");
    20fc:	83 ec 08             	sub    $0x8,%esp
    20ff:	68 00 38 00 00       	push   $0x3800
    2104:	6a 01                	push   $0x1
    2106:	e8 35 0a 00 00       	call   2b40 <printf>
      exit();
    210b:	e8 f1 08 00 00       	call   2a01 <exit>
      printf(1, "write bigfile failed\n");
    2110:	83 ec 08             	sub    $0x8,%esp
    2113:	68 d5 37 00 00       	push   $0x37d5
    2118:	6a 01                	push   $0x1
    211a:	e8 21 0a 00 00       	call   2b40 <printf>
      exit();
    211f:	e8 dd 08 00 00       	call   2a01 <exit>
    printf(1, "cannot open bigfile\n");
    2124:	83 ec 08             	sub    $0x8,%esp
    2127:	68 eb 37 00 00       	push   $0x37eb
    212c:	6a 01                	push   $0x1
    212e:	e8 0d 0a 00 00       	call   2b40 <printf>
    exit();
    2133:	e8 c9 08 00 00       	call   2a01 <exit>
    printf(1, "cannot create bigfile");
    2138:	83 ec 08             	sub    $0x8,%esp
    213b:	68 bf 37 00 00       	push   $0x37bf
    2140:	6a 01                	push   $0x1
    2142:	e8 f9 09 00 00       	call   2b40 <printf>
    exit();
    2147:	e8 b5 08 00 00       	call   2a01 <exit>
    printf(1, "read bigfile wrong total\n");
    214c:	83 ec 08             	sub    $0x8,%esp
    214f:	68 42 38 00 00       	push   $0x3842
    2154:	6a 01                	push   $0x1
    2156:	e8 e5 09 00 00       	call   2b40 <printf>
    exit();
    215b:	e8 a1 08 00 00       	call   2a01 <exit>

00002160 <fourteen>:
{
    2160:	83 ec 14             	sub    $0x14,%esp
  printf(1, "fourteen test\n");
    2163:	68 6d 38 00 00       	push   $0x386d
    2168:	6a 01                	push   $0x1
    216a:	e8 d1 09 00 00       	call   2b40 <printf>
  if(mkdir("12345678901234") != 0){
    216f:	c7 04 24 a8 38 00 00 	movl   $0x38a8,(%esp)
    2176:	e8 ee 08 00 00       	call   2a69 <mkdir>
    217b:	83 c4 10             	add    $0x10,%esp
    217e:	85 c0                	test   %eax,%eax
    2180:	0f 85 96 00 00 00    	jne    221c <fourteen+0xbc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2186:	83 ec 0c             	sub    $0xc,%esp
    2189:	68 54 3e 00 00       	push   $0x3e54
    218e:	e8 d6 08 00 00       	call   2a69 <mkdir>
    2193:	83 c4 10             	add    $0x10,%esp
    2196:	85 c0                	test   %eax,%eax
    2198:	0f 85 dd 00 00 00    	jne    227b <fourteen+0x11b>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    219e:	83 ec 08             	sub    $0x8,%esp
    21a1:	68 00 02 00 00       	push   $0x200
    21a6:	68 a4 3e 00 00       	push   $0x3ea4
    21ab:	e8 91 08 00 00       	call   2a41 <open>
  if(fd < 0){
    21b0:	83 c4 10             	add    $0x10,%esp
    21b3:	85 c0                	test   %eax,%eax
    21b5:	0f 88 ad 00 00 00    	js     2268 <fourteen+0x108>
  close(fd);
    21bb:	83 ec 0c             	sub    $0xc,%esp
    21be:	50                   	push   %eax
    21bf:	e8 65 08 00 00       	call   2a29 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    21c4:	58                   	pop    %eax
    21c5:	5a                   	pop    %edx
    21c6:	6a 00                	push   $0x0
    21c8:	68 14 3f 00 00       	push   $0x3f14
    21cd:	e8 6f 08 00 00       	call   2a41 <open>
  if(fd < 0){
    21d2:	83 c4 10             	add    $0x10,%esp
    21d5:	85 c0                	test   %eax,%eax
    21d7:	78 7c                	js     2255 <fourteen+0xf5>
  close(fd);
    21d9:	83 ec 0c             	sub    $0xc,%esp
    21dc:	50                   	push   %eax
    21dd:	e8 47 08 00 00       	call   2a29 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    21e2:	c7 04 24 99 38 00 00 	movl   $0x3899,(%esp)
    21e9:	e8 7b 08 00 00       	call   2a69 <mkdir>
    21ee:	83 c4 10             	add    $0x10,%esp
    21f1:	85 c0                	test   %eax,%eax
    21f3:	74 4d                	je     2242 <fourteen+0xe2>
  if(mkdir("123456789012345/12345678901234") == 0){
    21f5:	83 ec 0c             	sub    $0xc,%esp
    21f8:	68 b0 3f 00 00       	push   $0x3fb0
    21fd:	e8 67 08 00 00       	call   2a69 <mkdir>
    2202:	83 c4 10             	add    $0x10,%esp
    2205:	85 c0                	test   %eax,%eax
    2207:	74 26                	je     222f <fourteen+0xcf>
  printf(1, "fourteen ok\n");
    2209:	83 ec 08             	sub    $0x8,%esp
    220c:	68 b7 38 00 00       	push   $0x38b7
    2211:	6a 01                	push   $0x1
    2213:	e8 28 09 00 00       	call   2b40 <printf>
}
    2218:	83 c4 1c             	add    $0x1c,%esp
    221b:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    221c:	50                   	push   %eax
    221d:	50                   	push   %eax
    221e:	68 7c 38 00 00       	push   $0x387c
    2223:	6a 01                	push   $0x1
    2225:	e8 16 09 00 00       	call   2b40 <printf>
    exit();
    222a:	e8 d2 07 00 00       	call   2a01 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    222f:	50                   	push   %eax
    2230:	50                   	push   %eax
    2231:	68 d0 3f 00 00       	push   $0x3fd0
    2236:	6a 01                	push   $0x1
    2238:	e8 03 09 00 00       	call   2b40 <printf>
    exit();
    223d:	e8 bf 07 00 00       	call   2a01 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2242:	52                   	push   %edx
    2243:	52                   	push   %edx
    2244:	68 80 3f 00 00       	push   $0x3f80
    2249:	6a 01                	push   $0x1
    224b:	e8 f0 08 00 00       	call   2b40 <printf>
    exit();
    2250:	e8 ac 07 00 00       	call   2a01 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2255:	51                   	push   %ecx
    2256:	51                   	push   %ecx
    2257:	68 44 3f 00 00       	push   $0x3f44
    225c:	6a 01                	push   $0x1
    225e:	e8 dd 08 00 00       	call   2b40 <printf>
    exit();
    2263:	e8 99 07 00 00       	call   2a01 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2268:	51                   	push   %ecx
    2269:	51                   	push   %ecx
    226a:	68 d4 3e 00 00       	push   $0x3ed4
    226f:	6a 01                	push   $0x1
    2271:	e8 ca 08 00 00       	call   2b40 <printf>
    exit();
    2276:	e8 86 07 00 00       	call   2a01 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    227b:	50                   	push   %eax
    227c:	50                   	push   %eax
    227d:	68 74 3e 00 00       	push   $0x3e74
    2282:	6a 01                	push   $0x1
    2284:	e8 b7 08 00 00       	call   2b40 <printf>
    exit();
    2289:	e8 73 07 00 00       	call   2a01 <exit>
    228e:	66 90                	xchg   %ax,%ax

00002290 <rmdot>:
{
    2290:	83 ec 14             	sub    $0x14,%esp
  printf(1, "rmdot test\n");
    2293:	68 c4 38 00 00       	push   $0x38c4
    2298:	6a 01                	push   $0x1
    229a:	e8 a1 08 00 00       	call   2b40 <printf>
  if(mkdir("dots") != 0){
    229f:	c7 04 24 d0 38 00 00 	movl   $0x38d0,(%esp)
    22a6:	e8 be 07 00 00       	call   2a69 <mkdir>
    22ab:	83 c4 10             	add    $0x10,%esp
    22ae:	85 c0                	test   %eax,%eax
    22b0:	0f 85 af 00 00 00    	jne    2365 <rmdot+0xd5>
  if(chdir("dots") != 0){
    22b6:	83 ec 0c             	sub    $0xc,%esp
    22b9:	68 d0 38 00 00       	push   $0x38d0
    22be:	e8 ae 07 00 00       	call   2a71 <chdir>
    22c3:	83 c4 10             	add    $0x10,%esp
    22c6:	85 c0                	test   %eax,%eax
    22c8:	0f 85 1c 01 00 00    	jne    23ea <rmdot+0x15a>
  if(unlink(".") == 0){
    22ce:	83 ec 0c             	sub    $0xc,%esp
    22d1:	68 ca 35 00 00       	push   $0x35ca
    22d6:	e8 76 07 00 00       	call   2a51 <unlink>
    22db:	83 c4 10             	add    $0x10,%esp
    22de:	85 c0                	test   %eax,%eax
    22e0:	0f 84 f1 00 00 00    	je     23d7 <rmdot+0x147>
  if(unlink("..") == 0){
    22e6:	83 ec 0c             	sub    $0xc,%esp
    22e9:	68 c9 35 00 00       	push   $0x35c9
    22ee:	e8 5e 07 00 00       	call   2a51 <unlink>
    22f3:	83 c4 10             	add    $0x10,%esp
    22f6:	85 c0                	test   %eax,%eax
    22f8:	0f 84 c6 00 00 00    	je     23c4 <rmdot+0x134>
  if(chdir("/") != 0){
    22fe:	83 ec 0c             	sub    $0xc,%esp
    2301:	68 18 39 00 00       	push   $0x3918
    2306:	e8 66 07 00 00       	call   2a71 <chdir>
    230b:	83 c4 10             	add    $0x10,%esp
    230e:	85 c0                	test   %eax,%eax
    2310:	0f 85 9b 00 00 00    	jne    23b1 <rmdot+0x121>
  if(unlink("dots/.") == 0){
    2316:	83 ec 0c             	sub    $0xc,%esp
    2319:	68 2a 39 00 00       	push   $0x392a
    231e:	e8 2e 07 00 00       	call   2a51 <unlink>
    2323:	83 c4 10             	add    $0x10,%esp
    2326:	85 c0                	test   %eax,%eax
    2328:	74 74                	je     239e <rmdot+0x10e>
  if(unlink("dots/..") == 0){
    232a:	83 ec 0c             	sub    $0xc,%esp
    232d:	68 48 39 00 00       	push   $0x3948
    2332:	e8 1a 07 00 00       	call   2a51 <unlink>
    2337:	83 c4 10             	add    $0x10,%esp
    233a:	85 c0                	test   %eax,%eax
    233c:	74 4d                	je     238b <rmdot+0xfb>
  if(unlink("dots") != 0){
    233e:	83 ec 0c             	sub    $0xc,%esp
    2341:	68 d0 38 00 00       	push   $0x38d0
    2346:	e8 06 07 00 00       	call   2a51 <unlink>
    234b:	83 c4 10             	add    $0x10,%esp
    234e:	85 c0                	test   %eax,%eax
    2350:	75 26                	jne    2378 <rmdot+0xe8>
  printf(1, "rmdot ok\n");
    2352:	83 ec 08             	sub    $0x8,%esp
    2355:	68 7d 39 00 00       	push   $0x397d
    235a:	6a 01                	push   $0x1
    235c:	e8 df 07 00 00       	call   2b40 <printf>
}
    2361:	83 c4 1c             	add    $0x1c,%esp
    2364:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    2365:	50                   	push   %eax
    2366:	50                   	push   %eax
    2367:	68 d5 38 00 00       	push   $0x38d5
    236c:	6a 01                	push   $0x1
    236e:	e8 cd 07 00 00       	call   2b40 <printf>
    exit();
    2373:	e8 89 06 00 00       	call   2a01 <exit>
    printf(1, "unlink dots failed!\n");
    2378:	50                   	push   %eax
    2379:	50                   	push   %eax
    237a:	68 68 39 00 00       	push   $0x3968
    237f:	6a 01                	push   $0x1
    2381:	e8 ba 07 00 00       	call   2b40 <printf>
    exit();
    2386:	e8 76 06 00 00       	call   2a01 <exit>
    printf(1, "unlink dots/.. worked!\n");
    238b:	52                   	push   %edx
    238c:	52                   	push   %edx
    238d:	68 50 39 00 00       	push   $0x3950
    2392:	6a 01                	push   $0x1
    2394:	e8 a7 07 00 00       	call   2b40 <printf>
    exit();
    2399:	e8 63 06 00 00       	call   2a01 <exit>
    printf(1, "unlink dots/. worked!\n");
    239e:	51                   	push   %ecx
    239f:	51                   	push   %ecx
    23a0:	68 31 39 00 00       	push   $0x3931
    23a5:	6a 01                	push   $0x1
    23a7:	e8 94 07 00 00       	call   2b40 <printf>
    exit();
    23ac:	e8 50 06 00 00       	call   2a01 <exit>
    printf(1, "chdir / failed\n");
    23b1:	50                   	push   %eax
    23b2:	50                   	push   %eax
    23b3:	68 1a 39 00 00       	push   $0x391a
    23b8:	6a 01                	push   $0x1
    23ba:	e8 81 07 00 00       	call   2b40 <printf>
    exit();
    23bf:	e8 3d 06 00 00       	call   2a01 <exit>
    printf(1, "rm .. worked!\n");
    23c4:	50                   	push   %eax
    23c5:	50                   	push   %eax
    23c6:	68 09 39 00 00       	push   $0x3909
    23cb:	6a 01                	push   $0x1
    23cd:	e8 6e 07 00 00       	call   2b40 <printf>
    exit();
    23d2:	e8 2a 06 00 00       	call   2a01 <exit>
    printf(1, "rm . worked!\n");
    23d7:	50                   	push   %eax
    23d8:	50                   	push   %eax
    23d9:	68 fb 38 00 00       	push   $0x38fb
    23de:	6a 01                	push   $0x1
    23e0:	e8 5b 07 00 00       	call   2b40 <printf>
    exit();
    23e5:	e8 17 06 00 00       	call   2a01 <exit>
    printf(1, "chdir dots failed\n");
    23ea:	50                   	push   %eax
    23eb:	50                   	push   %eax
    23ec:	68 e8 38 00 00       	push   $0x38e8
    23f1:	6a 01                	push   $0x1
    23f3:	e8 48 07 00 00       	call   2b40 <printf>
    exit();
    23f8:	e8 04 06 00 00       	call   2a01 <exit>
    23fd:	8d 76 00             	lea    0x0(%esi),%esi

00002400 <dirfile>:
{
    2400:	53                   	push   %ebx
    2401:	83 ec 10             	sub    $0x10,%esp
  printf(1, "dir vs file\n");
    2404:	68 87 39 00 00       	push   $0x3987
    2409:	6a 01                	push   $0x1
    240b:	e8 30 07 00 00       	call   2b40 <printf>
  fd = open("dirfile", O_CREATE);
    2410:	59                   	pop    %ecx
    2411:	5b                   	pop    %ebx
    2412:	68 00 02 00 00       	push   $0x200
    2417:	68 94 39 00 00       	push   $0x3994
    241c:	e8 20 06 00 00       	call   2a41 <open>
  if(fd < 0){
    2421:	83 c4 10             	add    $0x10,%esp
    2424:	85 c0                	test   %eax,%eax
    2426:	0f 88 40 01 00 00    	js     256c <dirfile+0x16c>
  close(fd);
    242c:	83 ec 0c             	sub    $0xc,%esp
    242f:	50                   	push   %eax
    2430:	e8 f4 05 00 00       	call   2a29 <close>
  if(chdir("dirfile") == 0){
    2435:	c7 04 24 94 39 00 00 	movl   $0x3994,(%esp)
    243c:	e8 30 06 00 00       	call   2a71 <chdir>
    2441:	83 c4 10             	add    $0x10,%esp
    2444:	85 c0                	test   %eax,%eax
    2446:	0f 84 0d 01 00 00    	je     2559 <dirfile+0x159>
  fd = open("dirfile/xx", 0);
    244c:	83 ec 08             	sub    $0x8,%esp
    244f:	6a 00                	push   $0x0
    2451:	68 cd 39 00 00       	push   $0x39cd
    2456:	e8 e6 05 00 00       	call   2a41 <open>
  if(fd >= 0){
    245b:	83 c4 10             	add    $0x10,%esp
    245e:	85 c0                	test   %eax,%eax
    2460:	0f 89 e0 00 00 00    	jns    2546 <dirfile+0x146>
  fd = open("dirfile/xx", O_CREATE);
    2466:	83 ec 08             	sub    $0x8,%esp
    2469:	68 00 02 00 00       	push   $0x200
    246e:	68 cd 39 00 00       	push   $0x39cd
    2473:	e8 c9 05 00 00       	call   2a41 <open>
  if(fd >= 0){
    2478:	83 c4 10             	add    $0x10,%esp
    247b:	85 c0                	test   %eax,%eax
    247d:	0f 89 c3 00 00 00    	jns    2546 <dirfile+0x146>
  if(mkdir("dirfile/xx") == 0){
    2483:	83 ec 0c             	sub    $0xc,%esp
    2486:	68 cd 39 00 00       	push   $0x39cd
    248b:	e8 d9 05 00 00       	call   2a69 <mkdir>
    2490:	83 c4 10             	add    $0x10,%esp
    2493:	85 c0                	test   %eax,%eax
    2495:	0f 84 43 01 00 00    	je     25de <dirfile+0x1de>
  if(unlink("dirfile/xx") == 0){
    249b:	83 ec 0c             	sub    $0xc,%esp
    249e:	68 cd 39 00 00       	push   $0x39cd
    24a3:	e8 a9 05 00 00       	call   2a51 <unlink>
    24a8:	83 c4 10             	add    $0x10,%esp
    24ab:	85 c0                	test   %eax,%eax
    24ad:	0f 84 18 01 00 00    	je     25cb <dirfile+0x1cb>
  if(link("README", "dirfile/xx") == 0){
    24b3:	83 ec 08             	sub    $0x8,%esp
    24b6:	68 cd 39 00 00       	push   $0x39cd
    24bb:	68 31 3a 00 00       	push   $0x3a31
    24c0:	e8 9c 05 00 00       	call   2a61 <link>
    24c5:	83 c4 10             	add    $0x10,%esp
    24c8:	85 c0                	test   %eax,%eax
    24ca:	0f 84 e8 00 00 00    	je     25b8 <dirfile+0x1b8>
  if(unlink("dirfile") != 0){
    24d0:	83 ec 0c             	sub    $0xc,%esp
    24d3:	68 94 39 00 00       	push   $0x3994
    24d8:	e8 74 05 00 00       	call   2a51 <unlink>
    24dd:	83 c4 10             	add    $0x10,%esp
    24e0:	85 c0                	test   %eax,%eax
    24e2:	0f 85 bd 00 00 00    	jne    25a5 <dirfile+0x1a5>
  fd = open(".", O_RDWR);
    24e8:	83 ec 08             	sub    $0x8,%esp
    24eb:	6a 02                	push   $0x2
    24ed:	68 ca 35 00 00       	push   $0x35ca
    24f2:	e8 4a 05 00 00       	call   2a41 <open>
  if(fd >= 0){
    24f7:	83 c4 10             	add    $0x10,%esp
    24fa:	85 c0                	test   %eax,%eax
    24fc:	0f 89 90 00 00 00    	jns    2592 <dirfile+0x192>
  fd = open(".", 0);
    2502:	83 ec 08             	sub    $0x8,%esp
    2505:	6a 00                	push   $0x0
    2507:	68 ca 35 00 00       	push   $0x35ca
    250c:	e8 30 05 00 00       	call   2a41 <open>
  if(write(fd, "x", 1) > 0){
    2511:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", 0);
    2514:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2516:	6a 01                	push   $0x1
    2518:	68 ad 36 00 00       	push   $0x36ad
    251d:	50                   	push   %eax
    251e:	e8 fe 04 00 00       	call   2a21 <write>
    2523:	83 c4 10             	add    $0x10,%esp
    2526:	85 c0                	test   %eax,%eax
    2528:	7f 55                	jg     257f <dirfile+0x17f>
  close(fd);
    252a:	83 ec 0c             	sub    $0xc,%esp
    252d:	53                   	push   %ebx
    252e:	e8 f6 04 00 00       	call   2a29 <close>
  printf(1, "dir vs file OK\n");
    2533:	58                   	pop    %eax
    2534:	5a                   	pop    %edx
    2535:	68 64 3a 00 00       	push   $0x3a64
    253a:	6a 01                	push   $0x1
    253c:	e8 ff 05 00 00       	call   2b40 <printf>
}
    2541:	83 c4 18             	add    $0x18,%esp
    2544:	5b                   	pop    %ebx
    2545:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2546:	50                   	push   %eax
    2547:	50                   	push   %eax
    2548:	68 d8 39 00 00       	push   $0x39d8
    254d:	6a 01                	push   $0x1
    254f:	e8 ec 05 00 00       	call   2b40 <printf>
    exit();
    2554:	e8 a8 04 00 00       	call   2a01 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2559:	50                   	push   %eax
    255a:	50                   	push   %eax
    255b:	68 b3 39 00 00       	push   $0x39b3
    2560:	6a 01                	push   $0x1
    2562:	e8 d9 05 00 00       	call   2b40 <printf>
    exit();
    2567:	e8 95 04 00 00       	call   2a01 <exit>
    printf(1, "create dirfile failed\n");
    256c:	52                   	push   %edx
    256d:	52                   	push   %edx
    256e:	68 9c 39 00 00       	push   $0x399c
    2573:	6a 01                	push   $0x1
    2575:	e8 c6 05 00 00       	call   2b40 <printf>
    exit();
    257a:	e8 82 04 00 00       	call   2a01 <exit>
    printf(1, "write . succeeded!\n");
    257f:	51                   	push   %ecx
    2580:	51                   	push   %ecx
    2581:	68 50 3a 00 00       	push   $0x3a50
    2586:	6a 01                	push   $0x1
    2588:	e8 b3 05 00 00       	call   2b40 <printf>
    exit();
    258d:	e8 6f 04 00 00       	call   2a01 <exit>
    printf(1, "open . for writing succeeded!\n");
    2592:	53                   	push   %ebx
    2593:	53                   	push   %ebx
    2594:	68 24 40 00 00       	push   $0x4024
    2599:	6a 01                	push   $0x1
    259b:	e8 a0 05 00 00       	call   2b40 <printf>
    exit();
    25a0:	e8 5c 04 00 00       	call   2a01 <exit>
    printf(1, "unlink dirfile failed!\n");
    25a5:	50                   	push   %eax
    25a6:	50                   	push   %eax
    25a7:	68 38 3a 00 00       	push   $0x3a38
    25ac:	6a 01                	push   $0x1
    25ae:	e8 8d 05 00 00       	call   2b40 <printf>
    exit();
    25b3:	e8 49 04 00 00       	call   2a01 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    25b8:	50                   	push   %eax
    25b9:	50                   	push   %eax
    25ba:	68 04 40 00 00       	push   $0x4004
    25bf:	6a 01                	push   $0x1
    25c1:	e8 7a 05 00 00       	call   2b40 <printf>
    exit();
    25c6:	e8 36 04 00 00       	call   2a01 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    25cb:	50                   	push   %eax
    25cc:	50                   	push   %eax
    25cd:	68 13 3a 00 00       	push   $0x3a13
    25d2:	6a 01                	push   $0x1
    25d4:	e8 67 05 00 00       	call   2b40 <printf>
    exit();
    25d9:	e8 23 04 00 00       	call   2a01 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    25de:	50                   	push   %eax
    25df:	50                   	push   %eax
    25e0:	68 f6 39 00 00       	push   $0x39f6
    25e5:	6a 01                	push   $0x1
    25e7:	e8 54 05 00 00       	call   2b40 <printf>
    exit();
    25ec:	e8 10 04 00 00       	call   2a01 <exit>
    25f1:	eb 0d                	jmp    2600 <iref>
    25f3:	90                   	nop
    25f4:	90                   	nop
    25f5:	90                   	nop
    25f6:	90                   	nop
    25f7:	90                   	nop
    25f8:	90                   	nop
    25f9:	90                   	nop
    25fa:	90                   	nop
    25fb:	90                   	nop
    25fc:	90                   	nop
    25fd:	90                   	nop
    25fe:	90                   	nop
    25ff:	90                   	nop

00002600 <iref>:
{
    2600:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2601:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2606:	83 ec 10             	sub    $0x10,%esp
  printf(1, "empty file name\n");
    2609:	68 74 3a 00 00       	push   $0x3a74
    260e:	6a 01                	push   $0x1
    2610:	e8 2b 05 00 00       	call   2b40 <printf>
    2615:	83 c4 10             	add    $0x10,%esp
    2618:	90                   	nop
    2619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2620:	83 ec 0c             	sub    $0xc,%esp
    2623:	68 85 3a 00 00       	push   $0x3a85
    2628:	e8 3c 04 00 00       	call   2a69 <mkdir>
    262d:	83 c4 10             	add    $0x10,%esp
    2630:	85 c0                	test   %eax,%eax
    2632:	0f 85 b8 00 00 00    	jne    26f0 <iref+0xf0>
    if(chdir("irefd") != 0){
    2638:	83 ec 0c             	sub    $0xc,%esp
    263b:	68 85 3a 00 00       	push   $0x3a85
    2640:	e8 2c 04 00 00       	call   2a71 <chdir>
    2645:	83 c4 10             	add    $0x10,%esp
    2648:	85 c0                	test   %eax,%eax
    264a:	0f 85 b4 00 00 00    	jne    2704 <iref+0x104>
    mkdir("");
    2650:	83 ec 0c             	sub    $0xc,%esp
    2653:	68 a3 31 00 00       	push   $0x31a3
    2658:	e8 0c 04 00 00       	call   2a69 <mkdir>
    link("README", "");
    265d:	59                   	pop    %ecx
    265e:	58                   	pop    %eax
    265f:	68 a3 31 00 00       	push   $0x31a3
    2664:	68 31 3a 00 00       	push   $0x3a31
    2669:	e8 f3 03 00 00       	call   2a61 <link>
    fd = open("", O_CREATE);
    266e:	58                   	pop    %eax
    266f:	5a                   	pop    %edx
    2670:	68 00 02 00 00       	push   $0x200
    2675:	68 a3 31 00 00       	push   $0x31a3
    267a:	e8 c2 03 00 00       	call   2a41 <open>
    if(fd >= 0)
    267f:	83 c4 10             	add    $0x10,%esp
    2682:	85 c0                	test   %eax,%eax
    2684:	78 0c                	js     2692 <iref+0x92>
      close(fd);
    2686:	83 ec 0c             	sub    $0xc,%esp
    2689:	50                   	push   %eax
    268a:	e8 9a 03 00 00       	call   2a29 <close>
    268f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2692:	83 ec 08             	sub    $0x8,%esp
    2695:	68 00 02 00 00       	push   $0x200
    269a:	68 ac 36 00 00       	push   $0x36ac
    269f:	e8 9d 03 00 00       	call   2a41 <open>
    if(fd >= 0)
    26a4:	83 c4 10             	add    $0x10,%esp
    26a7:	85 c0                	test   %eax,%eax
    26a9:	78 0c                	js     26b7 <iref+0xb7>
      close(fd);
    26ab:	83 ec 0c             	sub    $0xc,%esp
    26ae:	50                   	push   %eax
    26af:	e8 75 03 00 00       	call   2a29 <close>
    26b4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    26b7:	83 ec 0c             	sub    $0xc,%esp
    26ba:	68 ac 36 00 00       	push   $0x36ac
    26bf:	e8 8d 03 00 00       	call   2a51 <unlink>
  for(i = 0; i < 50 + 1; i++){
    26c4:	83 c4 10             	add    $0x10,%esp
    26c7:	83 eb 01             	sub    $0x1,%ebx
    26ca:	0f 85 50 ff ff ff    	jne    2620 <iref+0x20>
  chdir("/");
    26d0:	83 ec 0c             	sub    $0xc,%esp
    26d3:	68 18 39 00 00       	push   $0x3918
    26d8:	e8 94 03 00 00       	call   2a71 <chdir>
  printf(1, "empty file name OK\n");
    26dd:	58                   	pop    %eax
    26de:	5a                   	pop    %edx
    26df:	68 b3 3a 00 00       	push   $0x3ab3
    26e4:	6a 01                	push   $0x1
    26e6:	e8 55 04 00 00       	call   2b40 <printf>
}
    26eb:	83 c4 18             	add    $0x18,%esp
    26ee:	5b                   	pop    %ebx
    26ef:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    26f0:	83 ec 08             	sub    $0x8,%esp
    26f3:	68 8b 3a 00 00       	push   $0x3a8b
    26f8:	6a 01                	push   $0x1
    26fa:	e8 41 04 00 00       	call   2b40 <printf>
      exit();
    26ff:	e8 fd 02 00 00       	call   2a01 <exit>
      printf(1, "chdir irefd failed\n");
    2704:	83 ec 08             	sub    $0x8,%esp
    2707:	68 9f 3a 00 00       	push   $0x3a9f
    270c:	6a 01                	push   $0x1
    270e:	e8 2d 04 00 00       	call   2b40 <printf>
      exit();
    2713:	e8 e9 02 00 00       	call   2a01 <exit>
    2718:	90                   	nop
    2719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002720 <forktest>:
{
    2720:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2721:	31 db                	xor    %ebx,%ebx
{
    2723:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fork test\n");
    2726:	68 c7 3a 00 00       	push   $0x3ac7
    272b:	6a 01                	push   $0x1
    272d:	e8 0e 04 00 00       	call   2b40 <printf>
    2732:	83 c4 10             	add    $0x10,%esp
    2735:	eb 16                	jmp    274d <forktest+0x2d>
    2737:	89 f6                	mov    %esi,%esi
    2739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(pid == 0)
    2740:	74 62                	je     27a4 <forktest+0x84>
  for(n=0; n<1000; n++){
    2742:	83 c3 01             	add    $0x1,%ebx
    2745:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    274b:	74 43                	je     2790 <forktest+0x70>
    pid = fork();
    274d:	e8 a7 02 00 00       	call   29f9 <fork>
    if(pid < 0)
    2752:	85 c0                	test   %eax,%eax
    2754:	79 ea                	jns    2740 <forktest+0x20>
  for(; n > 0; n--){
    2756:	85 db                	test   %ebx,%ebx
    2758:	74 14                	je     276e <forktest+0x4e>
    275a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2760:	e8 a4 02 00 00       	call   2a09 <wait>
    2765:	85 c0                	test   %eax,%eax
    2767:	78 40                	js     27a9 <forktest+0x89>
  for(; n > 0; n--){
    2769:	83 eb 01             	sub    $0x1,%ebx
    276c:	75 f2                	jne    2760 <forktest+0x40>
  if(wait() != -1){
    276e:	e8 96 02 00 00       	call   2a09 <wait>
    2773:	83 f8 ff             	cmp    $0xffffffff,%eax
    2776:	75 45                	jne    27bd <forktest+0x9d>
  printf(1, "fork test OK\n");
    2778:	83 ec 08             	sub    $0x8,%esp
    277b:	68 f9 3a 00 00       	push   $0x3af9
    2780:	6a 01                	push   $0x1
    2782:	e8 b9 03 00 00       	call   2b40 <printf>
}
    2787:	83 c4 10             	add    $0x10,%esp
    278a:	83 c4 08             	add    $0x8,%esp
    278d:	5b                   	pop    %ebx
    278e:	c3                   	ret    
    278f:	90                   	nop
    printf(1, "fork claimed to work 1000 times!\n");
    2790:	83 ec 08             	sub    $0x8,%esp
    2793:	68 44 40 00 00       	push   $0x4044
    2798:	6a 01                	push   $0x1
    279a:	e8 a1 03 00 00       	call   2b40 <printf>
    exit();
    279f:	e8 5d 02 00 00       	call   2a01 <exit>
      exit();
    27a4:	e8 58 02 00 00       	call   2a01 <exit>
      printf(1, "wait stopped early\n");
    27a9:	83 ec 08             	sub    $0x8,%esp
    27ac:	68 d2 3a 00 00       	push   $0x3ad2
    27b1:	6a 01                	push   $0x1
    27b3:	e8 88 03 00 00       	call   2b40 <printf>
      exit();
    27b8:	e8 44 02 00 00       	call   2a01 <exit>
    printf(1, "wait got too many\n");
    27bd:	83 ec 08             	sub    $0x8,%esp
    27c0:	68 e6 3a 00 00       	push   $0x3ae6
    27c5:	6a 01                	push   $0x1
    27c7:	e8 74 03 00 00       	call   2b40 <printf>
    exit();
    27cc:	e8 30 02 00 00       	call   2a01 <exit>
    27d1:	66 90                	xchg   %ax,%ax
    27d3:	66 90                	xchg   %ax,%ax
    27d5:	66 90                	xchg   %ax,%ax
    27d7:	66 90                	xchg   %ax,%ax
    27d9:	66 90                	xchg   %ax,%ax
    27db:	66 90                	xchg   %ax,%ax
    27dd:	66 90                	xchg   %ax,%ax
    27df:	90                   	nop

000027e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    27e0:	53                   	push   %ebx
    27e1:	8b 44 24 08          	mov    0x8(%esp),%eax
    27e5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    27e9:	89 c2                	mov    %eax,%edx
    27eb:	90                   	nop
    27ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    27f0:	83 c1 01             	add    $0x1,%ecx
    27f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    27f7:	83 c2 01             	add    $0x1,%edx
    27fa:	84 db                	test   %bl,%bl
    27fc:	88 5a ff             	mov    %bl,-0x1(%edx)
    27ff:	75 ef                	jne    27f0 <strcpy+0x10>
    ;
  return os;
}
    2801:	5b                   	pop    %ebx
    2802:	c3                   	ret    
    2803:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002810 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    2810:	56                   	push   %esi
    2811:	53                   	push   %ebx
    2812:	8b 54 24 0c          	mov    0xc(%esp),%edx
    2816:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
    281a:	0f b6 02             	movzbl (%edx),%eax
    281d:	0f b6 19             	movzbl (%ecx),%ebx
    2820:	84 c0                	test   %al,%al
    2822:	75 1f                	jne    2843 <strcmp+0x33>
    2824:	eb 2a                	jmp    2850 <strcmp+0x40>
    2826:	8d 76 00             	lea    0x0(%esi),%esi
    2829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    2830:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    2833:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    2836:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
    2839:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    283d:	84 c0                	test   %al,%al
    283f:	74 0f                	je     2850 <strcmp+0x40>
    2841:	89 f1                	mov    %esi,%ecx
    2843:	38 d8                	cmp    %bl,%al
    2845:	74 e9                	je     2830 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    2847:	29 d8                	sub    %ebx,%eax
}
    2849:	5b                   	pop    %ebx
    284a:	5e                   	pop    %esi
    284b:	c3                   	ret    
    284c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
    2850:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    2852:	29 d8                	sub    %ebx,%eax
}
    2854:	5b                   	pop    %ebx
    2855:	5e                   	pop    %esi
    2856:	c3                   	ret    
    2857:	89 f6                	mov    %esi,%esi
    2859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002860 <strlen>:

uint
strlen(char *s)
{
    2860:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    2864:	80 39 00             	cmpb   $0x0,(%ecx)
    2867:	74 14                	je     287d <strlen+0x1d>
    2869:	31 d2                	xor    %edx,%edx
    286b:	90                   	nop
    286c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2870:	83 c2 01             	add    $0x1,%edx
    2873:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    2877:	89 d0                	mov    %edx,%eax
    2879:	75 f5                	jne    2870 <strlen+0x10>
    287b:	f3 c3                	repz ret 
    287d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    287f:	c3                   	ret    

00002880 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2880:	57                   	push   %edi
    2881:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    2885:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    2889:	8b 44 24 0c          	mov    0xc(%esp),%eax
    288d:	89 d7                	mov    %edx,%edi
    288f:	fc                   	cld    
    2890:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    2892:	89 d0                	mov    %edx,%eax
    2894:	5f                   	pop    %edi
    2895:	c3                   	ret    
    2896:	8d 76 00             	lea    0x0(%esi),%esi
    2899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000028a0 <strchr>:

char*
strchr(const char *s, char c)
{
    28a0:	53                   	push   %ebx
    28a1:	8b 44 24 08          	mov    0x8(%esp),%eax
    28a5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
    28a9:	0f b6 10             	movzbl (%eax),%edx
    28ac:	84 d2                	test   %dl,%dl
    28ae:	74 1e                	je     28ce <strchr+0x2e>
    if(*s == c)
    28b0:	38 d3                	cmp    %dl,%bl
    28b2:	89 d9                	mov    %ebx,%ecx
    28b4:	75 0e                	jne    28c4 <strchr+0x24>
    28b6:	eb 18                	jmp    28d0 <strchr+0x30>
    28b8:	90                   	nop
    28b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    28c0:	38 ca                	cmp    %cl,%dl
    28c2:	74 0c                	je     28d0 <strchr+0x30>
  for(; *s; s++)
    28c4:	83 c0 01             	add    $0x1,%eax
    28c7:	0f b6 10             	movzbl (%eax),%edx
    28ca:	84 d2                	test   %dl,%dl
    28cc:	75 f2                	jne    28c0 <strchr+0x20>
      return (char*) s;
  return 0;
    28ce:	31 c0                	xor    %eax,%eax
}
    28d0:	5b                   	pop    %ebx
    28d1:	c3                   	ret    
    28d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    28d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000028e0 <gets>:

char*
gets(char *buf, int max)
{
    28e0:	55                   	push   %ebp
    28e1:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    28e2:	31 ff                	xor    %edi,%edi
{
    28e4:	56                   	push   %esi
    28e5:	53                   	push   %ebx
    28e6:	83 ec 1c             	sub    $0x1c,%esp
    28e9:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
    28ed:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
    28f1:	eb 2c                	jmp    291f <gets+0x3f>
    28f3:	90                   	nop
    28f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
    28f8:	83 ec 04             	sub    $0x4,%esp
    28fb:	6a 01                	push   $0x1
    28fd:	55                   	push   %ebp
    28fe:	6a 00                	push   $0x0
    2900:	e8 14 01 00 00       	call   2a19 <read>
    if(cc < 1)
    2905:	83 c4 10             	add    $0x10,%esp
    2908:	85 c0                	test   %eax,%eax
    290a:	7e 1c                	jle    2928 <gets+0x48>
      break;
    buf[i++] = c;
    290c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
    2911:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
    2913:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
    2915:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
    2919:	74 25                	je     2940 <gets+0x60>
    291b:	3c 0d                	cmp    $0xd,%al
    291d:	74 21                	je     2940 <gets+0x60>
  for(i=0; i+1 < max; ){
    291f:	8d 5f 01             	lea    0x1(%edi),%ebx
    2922:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
    2926:	7c d0                	jl     28f8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
    2928:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
    292c:	83 c4 1c             	add    $0x1c,%esp
    292f:	89 f0                	mov    %esi,%eax
    2931:	5b                   	pop    %ebx
    2932:	5e                   	pop    %esi
    2933:	5f                   	pop    %edi
    2934:	5d                   	pop    %ebp
    2935:	c3                   	ret    
    2936:	8d 76 00             	lea    0x0(%esi),%esi
    2939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
    2940:	89 df                	mov    %ebx,%edi
}
    2942:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
    2944:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
    2948:	83 c4 1c             	add    $0x1c,%esp
    294b:	5b                   	pop    %ebx
    294c:	5e                   	pop    %esi
    294d:	5f                   	pop    %edi
    294e:	5d                   	pop    %ebp
    294f:	c3                   	ret    

00002950 <stat>:

int
stat(char *n, struct stat_new *st)
{
    2950:	56                   	push   %esi
    2951:	53                   	push   %ebx
    2952:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2955:	6a 00                	push   $0x0
    2957:	ff 74 24 1c          	pushl  0x1c(%esp)
    295b:	e8 e1 00 00 00       	call   2a41 <open>
  if(fd < 0)
    2960:	83 c4 10             	add    $0x10,%esp
    2963:	85 c0                	test   %eax,%eax
    2965:	78 29                	js     2990 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    2967:	83 ec 08             	sub    $0x8,%esp
    296a:	89 c3                	mov    %eax,%ebx
    296c:	ff 74 24 1c          	pushl  0x1c(%esp)
    2970:	50                   	push   %eax
    2971:	e8 e3 00 00 00       	call   2a59 <fstat>
  close(fd);
    2976:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    2979:	89 c6                	mov    %eax,%esi
  close(fd);
    297b:	e8 a9 00 00 00       	call   2a29 <close>
  return r;
    2980:	83 c4 10             	add    $0x10,%esp
}
    2983:	83 c4 04             	add    $0x4,%esp
    2986:	89 f0                	mov    %esi,%eax
    2988:	5b                   	pop    %ebx
    2989:	5e                   	pop    %esi
    298a:	c3                   	ret    
    298b:	90                   	nop
    298c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
    2990:	be ff ff ff ff       	mov    $0xffffffff,%esi
    2995:	eb ec                	jmp    2983 <stat+0x33>
    2997:	89 f6                	mov    %esi,%esi
    2999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000029a0 <atoi>:

int
atoi(const char *s)
{
    29a0:	53                   	push   %ebx
    29a1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    29a5:	0f be 11             	movsbl (%ecx),%edx
    29a8:	8d 42 d0             	lea    -0x30(%edx),%eax
    29ab:	3c 09                	cmp    $0x9,%al
    29ad:	b8 00 00 00 00       	mov    $0x0,%eax
    29b2:	77 19                	ja     29cd <atoi+0x2d>
    29b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    29b8:	8d 04 80             	lea    (%eax,%eax,4),%eax
    29bb:	83 c1 01             	add    $0x1,%ecx
    29be:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    29c2:	0f be 11             	movsbl (%ecx),%edx
    29c5:	8d 5a d0             	lea    -0x30(%edx),%ebx
    29c8:	80 fb 09             	cmp    $0x9,%bl
    29cb:	76 eb                	jbe    29b8 <atoi+0x18>
  return n;
}
    29cd:	5b                   	pop    %ebx
    29ce:	c3                   	ret    
    29cf:	90                   	nop

000029d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    29d0:	56                   	push   %esi
    29d1:	53                   	push   %ebx
    29d2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
    29d6:	8b 44 24 0c          	mov    0xc(%esp),%eax
    29da:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    29de:	85 db                	test   %ebx,%ebx
    29e0:	7e 14                	jle    29f6 <memmove+0x26>
    29e2:	31 d2                	xor    %edx,%edx
    29e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    29e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    29ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    29ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    29f2:	39 da                	cmp    %ebx,%edx
    29f4:	75 f2                	jne    29e8 <memmove+0x18>
  return vdst;
}
    29f6:	5b                   	pop    %ebx
    29f7:	5e                   	pop    %esi
    29f8:	c3                   	ret    

000029f9 <fork>:
    29f9:	b8 01 00 00 00       	mov    $0x1,%eax
    29fe:	cd 40                	int    $0x40
    2a00:	c3                   	ret    

00002a01 <exit>:
    2a01:	b8 02 00 00 00       	mov    $0x2,%eax
    2a06:	cd 40                	int    $0x40
    2a08:	c3                   	ret    

00002a09 <wait>:
    2a09:	b8 03 00 00 00       	mov    $0x3,%eax
    2a0e:	cd 40                	int    $0x40
    2a10:	c3                   	ret    

00002a11 <pipe>:
    2a11:	b8 04 00 00 00       	mov    $0x4,%eax
    2a16:	cd 40                	int    $0x40
    2a18:	c3                   	ret    

00002a19 <read>:
    2a19:	b8 06 00 00 00       	mov    $0x6,%eax
    2a1e:	cd 40                	int    $0x40
    2a20:	c3                   	ret    

00002a21 <write>:
    2a21:	b8 05 00 00 00       	mov    $0x5,%eax
    2a26:	cd 40                	int    $0x40
    2a28:	c3                   	ret    

00002a29 <close>:
    2a29:	b8 07 00 00 00       	mov    $0x7,%eax
    2a2e:	cd 40                	int    $0x40
    2a30:	c3                   	ret    

00002a31 <kill>:
    2a31:	b8 08 00 00 00       	mov    $0x8,%eax
    2a36:	cd 40                	int    $0x40
    2a38:	c3                   	ret    

00002a39 <exec>:
    2a39:	b8 09 00 00 00       	mov    $0x9,%eax
    2a3e:	cd 40                	int    $0x40
    2a40:	c3                   	ret    

00002a41 <open>:
    2a41:	b8 0a 00 00 00       	mov    $0xa,%eax
    2a46:	cd 40                	int    $0x40
    2a48:	c3                   	ret    

00002a49 <mknod>:
    2a49:	b8 0b 00 00 00       	mov    $0xb,%eax
    2a4e:	cd 40                	int    $0x40
    2a50:	c3                   	ret    

00002a51 <unlink>:
    2a51:	b8 0c 00 00 00       	mov    $0xc,%eax
    2a56:	cd 40                	int    $0x40
    2a58:	c3                   	ret    

00002a59 <fstat>:
    2a59:	b8 0d 00 00 00       	mov    $0xd,%eax
    2a5e:	cd 40                	int    $0x40
    2a60:	c3                   	ret    

00002a61 <link>:
    2a61:	b8 0e 00 00 00       	mov    $0xe,%eax
    2a66:	cd 40                	int    $0x40
    2a68:	c3                   	ret    

00002a69 <mkdir>:
    2a69:	b8 0f 00 00 00       	mov    $0xf,%eax
    2a6e:	cd 40                	int    $0x40
    2a70:	c3                   	ret    

00002a71 <chdir>:
    2a71:	b8 10 00 00 00       	mov    $0x10,%eax
    2a76:	cd 40                	int    $0x40
    2a78:	c3                   	ret    

00002a79 <dup>:
    2a79:	b8 11 00 00 00       	mov    $0x11,%eax
    2a7e:	cd 40                	int    $0x40
    2a80:	c3                   	ret    

00002a81 <getpid>:
    2a81:	b8 12 00 00 00       	mov    $0x12,%eax
    2a86:	cd 40                	int    $0x40
    2a88:	c3                   	ret    

00002a89 <sbrk>:
    2a89:	b8 13 00 00 00       	mov    $0x13,%eax
    2a8e:	cd 40                	int    $0x40
    2a90:	c3                   	ret    

00002a91 <sleep>:
    2a91:	b8 14 00 00 00       	mov    $0x14,%eax
    2a96:	cd 40                	int    $0x40
    2a98:	c3                   	ret    
    2a99:	66 90                	xchg   %ax,%ax
    2a9b:	66 90                	xchg   %ax,%ax
    2a9d:	66 90                	xchg   %ax,%ax
    2a9f:	90                   	nop

00002aa0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    2aa0:	55                   	push   %ebp
    2aa1:	57                   	push   %edi
    2aa2:	89 c7                	mov    %eax,%edi
    2aa4:	56                   	push   %esi
    2aa5:	53                   	push   %ebx
    2aa6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    2aa9:	8b 5c 24 50          	mov    0x50(%esp),%ebx
    2aad:	85 db                	test   %ebx,%ebx
    2aaf:	74 7f                	je     2b30 <printint+0x90>
    2ab1:	89 d0                	mov    %edx,%eax
    2ab3:	c1 e8 1f             	shr    $0x1f,%eax
    2ab6:	84 c0                	test   %al,%al
    2ab8:	74 76                	je     2b30 <printint+0x90>
    neg = 1;
    x = -xx;
    2aba:	89 d0                	mov    %edx,%eax
    neg = 1;
    2abc:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2ac3:	00 
    x = -xx;
    2ac4:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
    2ac6:	31 ed                	xor    %ebp,%ebp
    2ac8:	8d 74 24 1f          	lea    0x1f(%esp),%esi
    2acc:	eb 04                	jmp    2ad2 <printint+0x32>
    2ace:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
    2ad0:	89 dd                	mov    %ebx,%ebp
    2ad2:	31 d2                	xor    %edx,%edx
    2ad4:	8d 5d 01             	lea    0x1(%ebp),%ebx
    2ad7:	f7 f1                	div    %ecx
    2ad9:	0f b6 92 9c 40 00 00 	movzbl 0x409c(%edx),%edx
  }while((x /= base) != 0);
    2ae0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    2ae2:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    2ae5:	75 e9                	jne    2ad0 <printint+0x30>
  if(neg)
    2ae7:	8b 44 24 0c          	mov    0xc(%esp),%eax
    2aeb:	85 c0                	test   %eax,%eax
    2aed:	74 08                	je     2af7 <printint+0x57>
    buf[i++] = '-';
    2aef:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
    2af4:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
    2af7:	83 eb 01             	sub    $0x1,%ebx
    2afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2b00:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
    2b05:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
    2b08:	83 eb 01             	sub    $0x1,%ebx
    2b0b:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
    2b0f:	6a 01                	push   $0x1
    2b11:	56                   	push   %esi
    2b12:	57                   	push   %edi
    2b13:	e8 09 ff ff ff       	call   2a21 <write>
  while(--i >= 0)
    2b18:	83 c4 10             	add    $0x10,%esp
    2b1b:	83 fb ff             	cmp    $0xffffffff,%ebx
    2b1e:	75 e0                	jne    2b00 <printint+0x60>
    putc(fd, buf[i]);
}
    2b20:	83 c4 3c             	add    $0x3c,%esp
    2b23:	5b                   	pop    %ebx
    2b24:	5e                   	pop    %esi
    2b25:	5f                   	pop    %edi
    2b26:	5d                   	pop    %ebp
    2b27:	c3                   	ret    
    2b28:	90                   	nop
    2b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
    2b30:	89 d0                	mov    %edx,%eax
  neg = 0;
    2b32:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2b39:	00 
    2b3a:	eb 8a                	jmp    2ac6 <printint+0x26>
    2b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002b40 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2b40:	55                   	push   %ebp
    2b41:	57                   	push   %edi
    2b42:	56                   	push   %esi
    2b43:	53                   	push   %ebx
    2b44:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2b47:	8b 74 24 44          	mov    0x44(%esp),%esi
    2b4b:	8d 44 24 48          	lea    0x48(%esp),%eax
{
    2b4f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
    2b53:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b57:	0f b6 1e             	movzbl (%esi),%ebx
    2b5a:	83 c6 01             	add    $0x1,%esi
    2b5d:	84 db                	test   %bl,%bl
    2b5f:	0f 84 ad 00 00 00    	je     2c12 <printf+0xd2>
    2b65:	31 ed                	xor    %ebp,%ebp
    2b67:	eb 32                	jmp    2b9b <printf+0x5b>
    2b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    2b70:	83 f8 25             	cmp    $0x25,%eax
    2b73:	0f 84 a7 00 00 00    	je     2c20 <printf+0xe0>
    2b79:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
    2b7d:	83 ec 04             	sub    $0x4,%esp
    2b80:	6a 01                	push   $0x1
    2b82:	8d 44 24 22          	lea    0x22(%esp),%eax
    2b86:	50                   	push   %eax
    2b87:	57                   	push   %edi
    2b88:	e8 94 fe ff ff       	call   2a21 <write>
    2b8d:	83 c4 10             	add    $0x10,%esp
    2b90:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    2b93:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    2b97:	84 db                	test   %bl,%bl
    2b99:	74 77                	je     2c12 <printf+0xd2>
    if(state == 0){
    2b9b:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
    2b9d:	0f be cb             	movsbl %bl,%ecx
    2ba0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    2ba3:	74 cb                	je     2b70 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    2ba5:	83 fd 25             	cmp    $0x25,%ebp
    2ba8:	75 e6                	jne    2b90 <printf+0x50>
      if(c == 'd'){
    2baa:	83 f8 64             	cmp    $0x64,%eax
    2bad:	0f 84 0d 01 00 00    	je     2cc0 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2bb3:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    2bb9:	83 f9 70             	cmp    $0x70,%ecx
    2bbc:	74 72                	je     2c30 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2bbe:	83 f8 73             	cmp    $0x73,%eax
    2bc1:	0f 84 99 00 00 00    	je     2c60 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2bc7:	83 f8 63             	cmp    $0x63,%eax
    2bca:	0f 84 ff 00 00 00    	je     2ccf <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    2bd0:	83 f8 25             	cmp    $0x25,%eax
    2bd3:	0f 84 cf 00 00 00    	je     2ca8 <printf+0x168>
    2bd9:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
    2bde:	83 ec 04             	sub    $0x4,%esp
    2be1:	6a 01                	push   $0x1
    2be3:	8d 44 24 27          	lea    0x27(%esp),%eax
    2be7:	50                   	push   %eax
    2be8:	57                   	push   %edi
    2be9:	e8 33 fe ff ff       	call   2a21 <write>
    2bee:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
    2bf2:	83 c4 0c             	add    $0xc,%esp
    2bf5:	6a 01                	push   $0x1
    2bf7:	8d 44 24 26          	lea    0x26(%esp),%eax
    2bfb:	50                   	push   %eax
    2bfc:	57                   	push   %edi
    2bfd:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    2c00:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
    2c02:	e8 1a fe ff ff       	call   2a21 <write>
  for(i = 0; fmt[i]; i++){
    2c07:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    2c0b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    2c0e:	84 db                	test   %bl,%bl
    2c10:	75 89                	jne    2b9b <printf+0x5b>
    }
  }
}
    2c12:	83 c4 2c             	add    $0x2c,%esp
    2c15:	5b                   	pop    %ebx
    2c16:	5e                   	pop    %esi
    2c17:	5f                   	pop    %edi
    2c18:	5d                   	pop    %ebp
    2c19:	c3                   	ret    
    2c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    2c20:	bd 25 00 00 00       	mov    $0x25,%ebp
    2c25:	e9 66 ff ff ff       	jmp    2b90 <printf+0x50>
    2c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    2c30:	83 ec 0c             	sub    $0xc,%esp
    2c33:	b9 10 00 00 00       	mov    $0x10,%ecx
    2c38:	6a 00                	push   $0x0
    2c3a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
    2c3e:	89 f8                	mov    %edi,%eax
    2c40:	8b 13                	mov    (%ebx),%edx
    2c42:	e8 59 fe ff ff       	call   2aa0 <printint>
        ap++;
    2c47:	89 d8                	mov    %ebx,%eax
      state = 0;
    2c49:	31 ed                	xor    %ebp,%ebp
        ap++;
    2c4b:	83 c0 04             	add    $0x4,%eax
    2c4e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    2c52:	83 c4 10             	add    $0x10,%esp
    2c55:	e9 36 ff ff ff       	jmp    2b90 <printf+0x50>
    2c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
    2c60:	8b 44 24 0c          	mov    0xc(%esp),%eax
    2c64:	8b 28                	mov    (%eax),%ebp
        ap++;
    2c66:	83 c0 04             	add    $0x4,%eax
    2c69:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
    2c6d:	85 ed                	test   %ebp,%ebp
    2c6f:	74 7d                	je     2cee <printf+0x1ae>
        while(*s != 0){
    2c71:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
    2c75:	84 c0                	test   %al,%al
    2c77:	74 25                	je     2c9e <printf+0x15e>
    2c79:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
    2c7d:	8d 76 00             	lea    0x0(%esi),%esi
    2c80:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
    2c84:	83 ec 04             	sub    $0x4,%esp
          s++;
    2c87:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
    2c8a:	6a 01                	push   $0x1
    2c8c:	53                   	push   %ebx
    2c8d:	57                   	push   %edi
    2c8e:	e8 8e fd ff ff       	call   2a21 <write>
        while(*s != 0){
    2c93:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
    2c97:	83 c4 10             	add    $0x10,%esp
    2c9a:	84 c0                	test   %al,%al
    2c9c:	75 e2                	jne    2c80 <printf+0x140>
      state = 0;
    2c9e:	31 ed                	xor    %ebp,%ebp
    2ca0:	e9 eb fe ff ff       	jmp    2b90 <printf+0x50>
    2ca5:	8d 76 00             	lea    0x0(%esi),%esi
    2ca8:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
    2cac:	83 ec 04             	sub    $0x4,%esp
    2caf:	6a 01                	push   $0x1
    2cb1:	8d 44 24 25          	lea    0x25(%esp),%eax
    2cb5:	e9 41 ff ff ff       	jmp    2bfb <printf+0xbb>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    2cc0:	83 ec 0c             	sub    $0xc,%esp
    2cc3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    2cc8:	6a 01                	push   $0x1
    2cca:	e9 6b ff ff ff       	jmp    2c3a <printf+0xfa>
        putc(fd, *ap);
    2ccf:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
    2cd3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    2cd6:	8b 03                	mov    (%ebx),%eax
    2cd8:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
    2cdc:	6a 01                	push   $0x1
    2cde:	8d 44 24 24          	lea    0x24(%esp),%eax
    2ce2:	50                   	push   %eax
    2ce3:	57                   	push   %edi
    2ce4:	e8 38 fd ff ff       	call   2a21 <write>
    2ce9:	e9 59 ff ff ff       	jmp    2c47 <printf+0x107>
        while(*s != 0){
    2cee:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    2cf3:	bd 94 40 00 00       	mov    $0x4094,%ebp
    2cf8:	e9 7c ff ff ff       	jmp    2c79 <printf+0x139>
    2cfd:	66 90                	xchg   %ax,%ax
    2cff:	90                   	nop

00002d00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2d00:	57                   	push   %edi
    2d01:	56                   	push   %esi
    2d02:	53                   	push   %ebx
    2d03:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d07:	a1 c0 59 00 00       	mov    0x59c0,%eax
  bp = (Header*) ap - 1;
    2d0c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2d0f:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d11:	39 c8                	cmp    %ecx,%eax
    2d13:	73 13                	jae    2d28 <free+0x28>
    2d15:	8d 76 00             	lea    0x0(%esi),%esi
    2d18:	39 d1                	cmp    %edx,%ecx
    2d1a:	72 14                	jb     2d30 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2d1c:	39 d0                	cmp    %edx,%eax
    2d1e:	73 10                	jae    2d30 <free+0x30>
{
    2d20:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d22:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2d24:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2d26:	72 f0                	jb     2d18 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    2d28:	39 d0                	cmp    %edx,%eax
    2d2a:	72 f4                	jb     2d20 <free+0x20>
    2d2c:	39 d1                	cmp    %edx,%ecx
    2d2e:	73 f0                	jae    2d20 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    2d30:	8b 73 fc             	mov    -0x4(%ebx),%esi
    2d33:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    2d36:	39 fa                	cmp    %edi,%edx
    2d38:	74 18                	je     2d52 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    2d3a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    2d3d:	8b 50 04             	mov    0x4(%eax),%edx
    2d40:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    2d43:	39 f1                	cmp    %esi,%ecx
    2d45:	74 22                	je     2d69 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    2d47:	89 08                	mov    %ecx,(%eax)
  freep = p;
    2d49:	a3 c0 59 00 00       	mov    %eax,0x59c0
}
    2d4e:	5b                   	pop    %ebx
    2d4f:	5e                   	pop    %esi
    2d50:	5f                   	pop    %edi
    2d51:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    2d52:	03 72 04             	add    0x4(%edx),%esi
    2d55:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    2d58:	8b 10                	mov    (%eax),%edx
    2d5a:	8b 12                	mov    (%edx),%edx
    2d5c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    2d5f:	8b 50 04             	mov    0x4(%eax),%edx
    2d62:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    2d65:	39 f1                	cmp    %esi,%ecx
    2d67:	75 de                	jne    2d47 <free+0x47>
    p->s.size += bp->s.size;
    2d69:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    2d6c:	a3 c0 59 00 00       	mov    %eax,0x59c0
    p->s.size += bp->s.size;
    2d71:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2d74:	8b 53 f8             	mov    -0x8(%ebx),%edx
    2d77:	89 10                	mov    %edx,(%eax)
}
    2d79:	5b                   	pop    %ebx
    2d7a:	5e                   	pop    %esi
    2d7b:	5f                   	pop    %edi
    2d7c:	c3                   	ret    
    2d7d:	8d 76 00             	lea    0x0(%esi),%esi

00002d80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    2d80:	57                   	push   %edi
    2d81:	56                   	push   %esi
    2d82:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2d83:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
    2d87:	8b 15 c0 59 00 00    	mov    0x59c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2d8d:	8d 78 07             	lea    0x7(%eax),%edi
    2d90:	c1 ef 03             	shr    $0x3,%edi
    2d93:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    2d96:	85 d2                	test   %edx,%edx
    2d98:	0f 84 90 00 00 00    	je     2e2e <malloc+0xae>
    2d9e:	8b 02                	mov    (%edx),%eax
    2da0:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    2da3:	39 cf                	cmp    %ecx,%edi
    2da5:	76 61                	jbe    2e08 <malloc+0x88>
    2da7:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    2dad:	bb 00 10 00 00       	mov    $0x1000,%ebx
    2db2:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    2db5:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    2dbc:	eb 0b                	jmp    2dc9 <malloc+0x49>
    2dbe:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2dc0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    2dc2:	8b 48 04             	mov    0x4(%eax),%ecx
    2dc5:	39 cf                	cmp    %ecx,%edi
    2dc7:	76 3f                	jbe    2e08 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
    2dc9:	39 05 c0 59 00 00    	cmp    %eax,0x59c0
    2dcf:	89 c2                	mov    %eax,%edx
    2dd1:	75 ed                	jne    2dc0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    2dd3:	83 ec 0c             	sub    $0xc,%esp
    2dd6:	56                   	push   %esi
    2dd7:	e8 ad fc ff ff       	call   2a89 <sbrk>
  if(p == (char*) -1)
    2ddc:	83 c4 10             	add    $0x10,%esp
    2ddf:	83 f8 ff             	cmp    $0xffffffff,%eax
    2de2:	74 1c                	je     2e00 <malloc+0x80>
  hp->s.size = nu;
    2de4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    2de7:	83 ec 0c             	sub    $0xc,%esp
    2dea:	83 c0 08             	add    $0x8,%eax
    2ded:	50                   	push   %eax
    2dee:	e8 0d ff ff ff       	call   2d00 <free>
  return freep;
    2df3:	8b 15 c0 59 00 00    	mov    0x59c0,%edx
      if((p = morecore(nunits)) == 0)
    2df9:	83 c4 10             	add    $0x10,%esp
    2dfc:	85 d2                	test   %edx,%edx
    2dfe:	75 c0                	jne    2dc0 <malloc+0x40>
        return 0;
    2e00:	31 c0                	xor    %eax,%eax
    2e02:	eb 1c                	jmp    2e20 <malloc+0xa0>
    2e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    2e08:	39 cf                	cmp    %ecx,%edi
    2e0a:	74 1c                	je     2e28 <malloc+0xa8>
        p->s.size -= nunits;
    2e0c:	29 f9                	sub    %edi,%ecx
    2e0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    2e11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    2e14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    2e17:	89 15 c0 59 00 00    	mov    %edx,0x59c0
      return (void*) (p + 1);
    2e1d:	83 c0 08             	add    $0x8,%eax
  }
}
    2e20:	5b                   	pop    %ebx
    2e21:	5e                   	pop    %esi
    2e22:	5f                   	pop    %edi
    2e23:	c3                   	ret    
    2e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    2e28:	8b 08                	mov    (%eax),%ecx
    2e2a:	89 0a                	mov    %ecx,(%edx)
    2e2c:	eb e9                	jmp    2e17 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
    2e2e:	c7 05 c0 59 00 00 c4 	movl   $0x59c4,0x59c0
    2e35:	59 00 00 
    2e38:	c7 05 c4 59 00 00 c4 	movl   $0x59c4,0x59c4
    2e3f:	59 00 00 
    base.s.size = 0;
    2e42:	b8 c4 59 00 00       	mov    $0x59c4,%eax
    2e47:	c7 05 c8 59 00 00 00 	movl   $0x0,0x59c8
    2e4e:	00 00 00 
    2e51:	e9 51 ff ff ff       	jmp    2da7 <malloc+0x27>

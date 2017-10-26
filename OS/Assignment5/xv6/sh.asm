
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
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
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f c3 00 00 00    	jg     e4 <main+0xe4>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 b9 11 00 00       	push   $0x11b9
      2b:	e8 d1 0c 00 00       	call   d01 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 02 1c 00 00 20 	cmpb   $0x20,0x1c02
      47:	74 5d                	je     a6 <main+0xa6>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;
  
  pid = fork();
      50:	e8 64 0c 00 00       	call   cb9 <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	74 3f                	je     99 <main+0x99>
    if(fork1() == 0)
      5a:	85 c0                	test   %eax,%eax
      5c:	0f 84 98 00 00 00    	je     fa <main+0xfa>
    wait();
      62:	e8 62 0c 00 00       	call   cc9 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	6a 64                	push   $0x64
      6c:	68 00 1c 00 00       	push   $0x1c00
      71:	e8 9a 00 00 00       	call   110 <getcmd>
      76:	83 c4 10             	add    $0x10,%esp
      79:	85 c0                	test   %eax,%eax
      7b:	78 78                	js     f5 <main+0xf5>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      7d:	80 3d 00 1c 00 00 63 	cmpb   $0x63,0x1c00
      84:	75 ca                	jne    50 <main+0x50>
      86:	80 3d 01 1c 00 00 64 	cmpb   $0x64,0x1c01
      8d:	74 b1                	je     40 <main+0x40>
  pid = fork();
      8f:	e8 25 0c 00 00       	call   cb9 <fork>
  if(pid == -1)
      94:	83 f8 ff             	cmp    $0xffffffff,%eax
      97:	75 c1                	jne    5a <main+0x5a>
    panic("fork");
      99:	83 ec 0c             	sub    $0xc,%esp
      9c:	68 42 11 00 00       	push   $0x1142
      a1:	e8 aa 00 00 00       	call   150 <panic>
      buf[strlen(buf)-1] = 0;  // chop \n
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	68 00 1c 00 00       	push   $0x1c00
      ae:	e8 6d 0a 00 00       	call   b20 <strlen>
      if(chdir(buf+3) < 0)
      b3:	c7 04 24 03 1c 00 00 	movl   $0x1c03,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ba:	c6 80 ff 1b 00 00 00 	movb   $0x0,0x1bff(%eax)
      if(chdir(buf+3) < 0)
      c1:	e8 6b 0c 00 00       	call   d31 <chdir>
      c6:	83 c4 10             	add    $0x10,%esp
      c9:	85 c0                	test   %eax,%eax
      cb:	79 9a                	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
      cd:	50                   	push   %eax
      ce:	68 03 1c 00 00       	push   $0x1c03
      d3:	68 c1 11 00 00       	push   $0x11c1
      d8:	6a 02                	push   $0x2
      da:	e8 21 0d 00 00       	call   e00 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	eb 83                	jmp    67 <main+0x67>
      close(fd);
      e4:	83 ec 0c             	sub    $0xc,%esp
      e7:	50                   	push   %eax
      e8:	e8 fc 0b 00 00       	call   ce9 <close>
      break;
      ed:	83 c4 10             	add    $0x10,%esp
      f0:	e9 72 ff ff ff       	jmp    67 <main+0x67>
  exit();
      f5:	e8 c7 0b 00 00       	call   cc1 <exit>
      runcmd(parsecmd(buf));
      fa:	83 ec 0c             	sub    $0xc,%esp
      fd:	68 00 1c 00 00       	push   $0x1c00
     102:	e8 29 09 00 00       	call   a30 <parsecmd>
     107:	89 04 24             	mov    %eax,(%esp)
     10a:	e8 61 00 00 00       	call   170 <runcmd>
     10f:	90                   	nop

00000110 <getcmd>:
{
     110:	56                   	push   %esi
     111:	53                   	push   %ebx
     112:	83 ec 0c             	sub    $0xc,%esp
     115:	8b 5c 24 18          	mov    0x18(%esp),%ebx
     119:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  printf(2, "$ ");
     11d:	68 18 11 00 00       	push   $0x1118
     122:	6a 02                	push   $0x2
     124:	e8 d7 0c 00 00       	call   e00 <printf>
  memset(buf, 0, nbuf);
     129:	83 c4 0c             	add    $0xc,%esp
     12c:	56                   	push   %esi
     12d:	6a 00                	push   $0x0
     12f:	53                   	push   %ebx
     130:	e8 0b 0a 00 00       	call   b40 <memset>
  gets(buf, nbuf);
     135:	58                   	pop    %eax
     136:	5a                   	pop    %edx
     137:	56                   	push   %esi
     138:	53                   	push   %ebx
     139:	e8 62 0a 00 00       	call   ba0 <gets>
  if(buf[0] == 0) // EOF
     13e:	31 c0                	xor    %eax,%eax
     140:	80 3b 00             	cmpb   $0x0,(%ebx)
     143:	0f 94 c0             	sete   %al
}
     146:	83 c4 14             	add    $0x14,%esp
  if(buf[0] == 0) // EOF
     149:	f7 d8                	neg    %eax
}
     14b:	5b                   	pop    %ebx
     14c:	5e                   	pop    %esi
     14d:	c3                   	ret    
     14e:	66 90                	xchg   %ax,%ax

00000150 <panic>:
{
     150:	83 ec 10             	sub    $0x10,%esp
  printf(2, "%s\n", s);
     153:	ff 74 24 14          	pushl  0x14(%esp)
     157:	68 b5 11 00 00       	push   $0x11b5
     15c:	6a 02                	push   $0x2
     15e:	e8 9d 0c 00 00       	call   e00 <printf>
  exit();
     163:	e8 59 0b 00 00       	call   cc1 <exit>
     168:	90                   	nop
     169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <runcmd>:
{
     170:	53                   	push   %ebx
     171:	83 ec 18             	sub    $0x18,%esp
     174:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  if(cmd == 0)
     178:	85 db                	test   %ebx,%ebx
     17a:	74 79                	je     1f5 <runcmd+0x85>
  switch(cmd->type){
     17c:	83 3b 05             	cmpl   $0x5,(%ebx)
     17f:	0f 87 fb 00 00 00    	ja     280 <runcmd+0x110>
     185:	8b 03                	mov    (%ebx),%eax
     187:	ff 24 85 d0 11 00 00 	jmp    *0x11d0(,%eax,4)
    if(pipe(p) < 0)
     18e:	83 ec 0c             	sub    $0xc,%esp
     191:	8d 44 24 14          	lea    0x14(%esp),%eax
     195:	50                   	push   %eax
     196:	e8 36 0b 00 00       	call   cd1 <pipe>
     19b:	83 c4 10             	add    $0x10,%esp
     19e:	85 c0                	test   %eax,%eax
     1a0:	0f 88 09 01 00 00    	js     2af <runcmd+0x13f>
  pid = fork();
     1a6:	e8 0e 0b 00 00       	call   cb9 <fork>
  if(pid == -1)
     1ab:	83 f8 ff             	cmp    $0xffffffff,%eax
     1ae:	0f 84 d9 00 00 00    	je     28d <runcmd+0x11d>
    if(fork1() == 0){
     1b4:	85 c0                	test   %eax,%eax
     1b6:	0f 84 00 01 00 00    	je     2bc <runcmd+0x14c>
  pid = fork();
     1bc:	e8 f8 0a 00 00       	call   cb9 <fork>
  if(pid == -1)
     1c1:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c4:	0f 84 c3 00 00 00    	je     28d <runcmd+0x11d>
    if(fork1() == 0){
     1ca:	85 c0                	test   %eax,%eax
     1cc:	0f 84 1b 01 00 00    	je     2ed <runcmd+0x17d>
    close(p[0]);
     1d2:	83 ec 0c             	sub    $0xc,%esp
     1d5:	ff 74 24 14          	pushl  0x14(%esp)
     1d9:	e8 0b 0b 00 00       	call   ce9 <close>
    close(p[1]);
     1de:	58                   	pop    %eax
     1df:	ff 74 24 18          	pushl  0x18(%esp)
     1e3:	e8 01 0b 00 00       	call   ce9 <close>
    wait();
     1e8:	e8 dc 0a 00 00       	call   cc9 <wait>
    wait();
     1ed:	e8 d7 0a 00 00       	call   cc9 <wait>
    break;
     1f2:	83 c4 10             	add    $0x10,%esp
    exit();
     1f5:	e8 c7 0a 00 00       	call   cc1 <exit>
  pid = fork();
     1fa:	e8 ba 0a 00 00       	call   cb9 <fork>
  if(pid == -1)
     1ff:	83 f8 ff             	cmp    $0xffffffff,%eax
     202:	0f 84 85 00 00 00    	je     28d <runcmd+0x11d>
    if(fork1() == 0)
     208:	85 c0                	test   %eax,%eax
     20a:	75 e9                	jne    1f5 <runcmd+0x85>
     20c:	eb 49                	jmp    257 <runcmd+0xe7>
    if(ecmd->argv[0] == 0)
     20e:	8b 43 04             	mov    0x4(%ebx),%eax
     211:	85 c0                	test   %eax,%eax
     213:	74 e0                	je     1f5 <runcmd+0x85>
    exec(ecmd->argv[0], ecmd->argv);
     215:	52                   	push   %edx
     216:	52                   	push   %edx
     217:	8d 53 04             	lea    0x4(%ebx),%edx
     21a:	52                   	push   %edx
     21b:	50                   	push   %eax
     21c:	e8 d8 0a 00 00       	call   cf9 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     221:	83 c4 0c             	add    $0xc,%esp
     224:	ff 73 04             	pushl  0x4(%ebx)
     227:	68 22 11 00 00       	push   $0x1122
     22c:	6a 02                	push   $0x2
     22e:	e8 cd 0b 00 00       	call   e00 <printf>
    break;
     233:	83 c4 10             	add    $0x10,%esp
     236:	eb bd                	jmp    1f5 <runcmd+0x85>
    close(rcmd->fd);
     238:	83 ec 0c             	sub    $0xc,%esp
     23b:	ff 73 14             	pushl  0x14(%ebx)
     23e:	e8 a6 0a 00 00       	call   ce9 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     243:	59                   	pop    %ecx
     244:	58                   	pop    %eax
     245:	ff 73 10             	pushl  0x10(%ebx)
     248:	ff 73 08             	pushl  0x8(%ebx)
     24b:	e8 b1 0a 00 00       	call   d01 <open>
     250:	83 c4 10             	add    $0x10,%esp
     253:	85 c0                	test   %eax,%eax
     255:	78 43                	js     29a <runcmd+0x12a>
      runcmd(bcmd->cmd);
     257:	83 ec 0c             	sub    $0xc,%esp
     25a:	ff 73 04             	pushl  0x4(%ebx)
     25d:	e8 0e ff ff ff       	call   170 <runcmd>
  pid = fork();
     262:	e8 52 0a 00 00       	call   cb9 <fork>
  if(pid == -1)
     267:	83 f8 ff             	cmp    $0xffffffff,%eax
     26a:	74 21                	je     28d <runcmd+0x11d>
    if(fork1() == 0)
     26c:	85 c0                	test   %eax,%eax
     26e:	74 e7                	je     257 <runcmd+0xe7>
    wait();
     270:	e8 54 0a 00 00       	call   cc9 <wait>
    runcmd(lcmd->right);
     275:	83 ec 0c             	sub    $0xc,%esp
     278:	ff 73 08             	pushl  0x8(%ebx)
     27b:	e8 f0 fe ff ff       	call   170 <runcmd>
    panic("runcmd");
     280:	83 ec 0c             	sub    $0xc,%esp
     283:	68 1b 11 00 00       	push   $0x111b
     288:	e8 c3 fe ff ff       	call   150 <panic>
    panic("fork");
     28d:	83 ec 0c             	sub    $0xc,%esp
     290:	68 42 11 00 00       	push   $0x1142
     295:	e8 b6 fe ff ff       	call   150 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     29a:	52                   	push   %edx
     29b:	ff 73 08             	pushl  0x8(%ebx)
     29e:	68 32 11 00 00       	push   $0x1132
     2a3:	6a 02                	push   $0x2
     2a5:	e8 56 0b 00 00       	call   e00 <printf>
      exit();
     2aa:	e8 12 0a 00 00       	call   cc1 <exit>
      panic("pipe");
     2af:	83 ec 0c             	sub    $0xc,%esp
     2b2:	68 47 11 00 00       	push   $0x1147
     2b7:	e8 94 fe ff ff       	call   150 <panic>
      close(1);
     2bc:	83 ec 0c             	sub    $0xc,%esp
     2bf:	6a 01                	push   $0x1
     2c1:	e8 23 0a 00 00       	call   ce9 <close>
      dup(p[1]);
     2c6:	58                   	pop    %eax
     2c7:	ff 74 24 18          	pushl  0x18(%esp)
     2cb:	e8 69 0a 00 00       	call   d39 <dup>
      close(p[0]);
     2d0:	58                   	pop    %eax
     2d1:	ff 74 24 14          	pushl  0x14(%esp)
     2d5:	e8 0f 0a 00 00       	call   ce9 <close>
      close(p[1]);
     2da:	58                   	pop    %eax
     2db:	ff 74 24 18          	pushl  0x18(%esp)
     2df:	e8 05 0a 00 00       	call   ce9 <close>
      runcmd(pcmd->left);
     2e4:	58                   	pop    %eax
     2e5:	ff 73 04             	pushl  0x4(%ebx)
     2e8:	e8 83 fe ff ff       	call   170 <runcmd>
      close(0);
     2ed:	83 ec 0c             	sub    $0xc,%esp
     2f0:	6a 00                	push   $0x0
     2f2:	e8 f2 09 00 00       	call   ce9 <close>
      dup(p[0]);
     2f7:	5a                   	pop    %edx
     2f8:	ff 74 24 14          	pushl  0x14(%esp)
     2fc:	e8 38 0a 00 00       	call   d39 <dup>
      close(p[0]);
     301:	59                   	pop    %ecx
     302:	ff 74 24 14          	pushl  0x14(%esp)
     306:	e8 de 09 00 00       	call   ce9 <close>
      close(p[1]);
     30b:	58                   	pop    %eax
     30c:	ff 74 24 18          	pushl  0x18(%esp)
     310:	e8 d4 09 00 00       	call   ce9 <close>
      runcmd(pcmd->right);
     315:	58                   	pop    %eax
     316:	ff 73 08             	pushl  0x8(%ebx)
     319:	e8 52 fe ff ff       	call   170 <runcmd>
     31e:	66 90                	xchg   %ax,%ax

00000320 <fork1>:
{
     320:	83 ec 0c             	sub    $0xc,%esp
  pid = fork();
     323:	e8 91 09 00 00       	call   cb9 <fork>
  if(pid == -1)
     328:	83 f8 ff             	cmp    $0xffffffff,%eax
     32b:	74 04                	je     331 <fork1+0x11>
  return pid;
}
     32d:	83 c4 0c             	add    $0xc,%esp
     330:	c3                   	ret    
    panic("fork");
     331:	83 ec 0c             	sub    $0xc,%esp
     334:	68 42 11 00 00       	push   $0x1142
     339:	e8 12 fe ff ff       	call   150 <panic>
     33e:	66 90                	xchg   %ax,%ax

00000340 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     340:	53                   	push   %ebx
     341:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     344:	6a 54                	push   $0x54
     346:	e8 f5 0c 00 00       	call   1040 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34b:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     34e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     350:	6a 54                	push   $0x54
     352:	6a 00                	push   $0x0
     354:	50                   	push   %eax
     355:	e8 e6 07 00 00       	call   b40 <memset>
  cmd->type = EXEC;
     35a:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     360:	83 c4 18             	add    $0x18,%esp
     363:	89 d8                	mov    %ebx,%eax
     365:	5b                   	pop    %ebx
     366:	c3                   	ret    
     367:	89 f6                	mov    %esi,%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	53                   	push   %ebx
     371:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     374:	6a 18                	push   $0x18
     376:	e8 c5 0c 00 00       	call   1040 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37b:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     37e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     380:	6a 18                	push   $0x18
     382:	6a 00                	push   $0x0
     384:	50                   	push   %eax
     385:	e8 b6 07 00 00       	call   b40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     38a:	8b 44 24 20          	mov    0x20(%esp),%eax
  cmd->type = REDIR;
     38e:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     394:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     397:	8b 44 24 24          	mov    0x24(%esp),%eax
     39b:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39e:	8b 44 24 28          	mov    0x28(%esp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     3a9:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ac:	8b 44 24 30          	mov    0x30(%esp),%eax
     3b0:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b3:	83 c4 18             	add    $0x18,%esp
     3b6:	89 d8                	mov    %ebx,%eax
     3b8:	5b                   	pop    %ebx
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3c0:	53                   	push   %ebx
     3c1:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c4:	6a 0c                	push   $0xc
     3c6:	e8 75 0c 00 00       	call   1040 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3cb:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3ce:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d0:	6a 0c                	push   $0xc
     3d2:	6a 00                	push   $0x0
     3d4:	50                   	push   %eax
     3d5:	e8 66 07 00 00       	call   b40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3da:	8b 44 24 20          	mov    0x20(%esp),%eax
  cmd->type = PIPE;
     3de:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e4:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e7:	8b 44 24 24          	mov    0x24(%esp),%eax
     3eb:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ee:	83 c4 18             	add    $0x18,%esp
     3f1:	89 d8                	mov    %ebx,%eax
     3f3:	5b                   	pop    %ebx
     3f4:	c3                   	ret    
     3f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     400:	53                   	push   %ebx
     401:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     404:	6a 0c                	push   $0xc
     406:	e8 35 0c 00 00       	call   1040 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40b:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     40e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     410:	6a 0c                	push   $0xc
     412:	6a 00                	push   $0x0
     414:	50                   	push   %eax
     415:	e8 26 07 00 00       	call   b40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     41a:	8b 44 24 20          	mov    0x20(%esp),%eax
  cmd->type = LIST;
     41e:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     424:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     427:	8b 44 24 24          	mov    0x24(%esp),%eax
     42b:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     42e:	83 c4 18             	add    $0x18,%esp
     431:	89 d8                	mov    %ebx,%eax
     433:	5b                   	pop    %ebx
     434:	c3                   	ret    
     435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     440:	53                   	push   %ebx
     441:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     444:	6a 08                	push   $0x8
     446:	e8 f5 0b 00 00       	call   1040 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44b:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     44e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     450:	6a 08                	push   $0x8
     452:	6a 00                	push   $0x0
     454:	50                   	push   %eax
     455:	e8 e6 06 00 00       	call   b40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     45a:	8b 44 24 20          	mov    0x20(%esp),%eax
  cmd->type = BACK;
     45e:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     464:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     467:	83 c4 18             	add    $0x18,%esp
     46a:	89 d8                	mov    %ebx,%eax
     46c:	5b                   	pop    %ebx
     46d:	c3                   	ret    
     46e:	66 90                	xchg   %ax,%ax

00000470 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     470:	55                   	push   %ebp
     471:	57                   	push   %edi
     472:	56                   	push   %esi
     473:	53                   	push   %ebx
     474:	83 ec 0c             	sub    $0xc,%esp
     477:	8b 74 24 20          	mov    0x20(%esp),%esi
     47b:	8b 5c 24 24          	mov    0x24(%esp),%ebx
     47f:	8b 7c 24 28          	mov    0x28(%esp),%edi
  char *s;
  int ret;
  
  s = *ps;
     483:	8b 2e                	mov    (%esi),%ebp
  while(s < es && strchr(whitespace, *s))
     485:	39 dd                	cmp    %ebx,%ebp
     487:	72 0e                	jb     497 <gettoken+0x27>
     489:	eb 25                	jmp    4b0 <gettoken+0x40>
     48b:	90                   	nop
     48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     490:	83 c5 01             	add    $0x1,%ebp
  while(s < es && strchr(whitespace, *s))
     493:	39 eb                	cmp    %ebp,%ebx
     495:	74 19                	je     4b0 <gettoken+0x40>
     497:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     49b:	83 ec 08             	sub    $0x8,%esp
     49e:	50                   	push   %eax
     49f:	68 f0 1b 00 00       	push   $0x1bf0
     4a4:	e8 b7 06 00 00       	call   b60 <strchr>
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	75 e0                	jne    490 <gettoken+0x20>
  if(q)
     4b0:	85 ff                	test   %edi,%edi
     4b2:	74 02                	je     4b6 <gettoken+0x46>
    *q = s;
     4b4:	89 2f                	mov    %ebp,(%edi)
  ret = *s;
     4b6:	0f be 45 00          	movsbl 0x0(%ebp),%eax
  switch(*s){
     4ba:	3c 29                	cmp    $0x29,%al
     4bc:	7f 5a                	jg     518 <gettoken+0xa8>
     4be:	3c 28                	cmp    $0x28,%al
     4c0:	0f 8d c6 00 00 00    	jge    58c <gettoken+0x11c>
     4c6:	31 ff                	xor    %edi,%edi
     4c8:	84 c0                	test   %al,%al
     4ca:	0f 85 e0 00 00 00    	jne    5b0 <gettoken+0x140>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4d0:	8b 54 24 2c          	mov    0x2c(%esp),%edx
     4d4:	85 d2                	test   %edx,%edx
     4d6:	74 06                	je     4de <gettoken+0x6e>
    *eq = s;
     4d8:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     4dc:	89 28                	mov    %ebp,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     4de:	39 eb                	cmp    %ebp,%ebx
     4e0:	77 0d                	ja     4ef <gettoken+0x7f>
     4e2:	eb 24                	jmp    508 <gettoken+0x98>
     4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     4e8:	83 c5 01             	add    $0x1,%ebp
  while(s < es && strchr(whitespace, *s))
     4eb:	39 eb                	cmp    %ebp,%ebx
     4ed:	74 19                	je     508 <gettoken+0x98>
     4ef:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     4f3:	83 ec 08             	sub    $0x8,%esp
     4f6:	50                   	push   %eax
     4f7:	68 f0 1b 00 00       	push   $0x1bf0
     4fc:	e8 5f 06 00 00       	call   b60 <strchr>
     501:	83 c4 10             	add    $0x10,%esp
     504:	85 c0                	test   %eax,%eax
     506:	75 e0                	jne    4e8 <gettoken+0x78>
  *ps = s;
     508:	89 2e                	mov    %ebp,(%esi)
  return ret;
}
     50a:	83 c4 0c             	add    $0xc,%esp
     50d:	89 f8                	mov    %edi,%eax
     50f:	5b                   	pop    %ebx
     510:	5e                   	pop    %esi
     511:	5f                   	pop    %edi
     512:	5d                   	pop    %ebp
     513:	c3                   	ret    
     514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     518:	3c 3e                	cmp    $0x3e,%al
     51a:	75 14                	jne    530 <gettoken+0xc0>
    if(*s == '>'){
     51c:	80 7d 01 3e          	cmpb   $0x3e,0x1(%ebp)
     520:	74 7e                	je     5a0 <gettoken+0x130>
    s++;
     522:	83 c5 01             	add    $0x1,%ebp
     525:	bf 3e 00 00 00       	mov    $0x3e,%edi
     52a:	eb a4                	jmp    4d0 <gettoken+0x60>
     52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     530:	7f 56                	jg     588 <gettoken+0x118>
     532:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     535:	80 f9 01             	cmp    $0x1,%cl
     538:	76 52                	jbe    58c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     53a:	39 eb                	cmp    %ebp,%ebx
     53c:	77 26                	ja     564 <gettoken+0xf4>
     53e:	eb 76                	jmp    5b6 <gettoken+0x146>
     540:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     544:	83 ec 08             	sub    $0x8,%esp
     547:	50                   	push   %eax
     548:	68 e8 1b 00 00       	push   $0x1be8
     54d:	e8 0e 06 00 00       	call   b60 <strchr>
     552:	83 c4 10             	add    $0x10,%esp
     555:	85 c0                	test   %eax,%eax
     557:	75 20                	jne    579 <gettoken+0x109>
      s++;
     559:	83 c5 01             	add    $0x1,%ebp
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     55c:	39 eb                	cmp    %ebp,%ebx
     55e:	74 56                	je     5b6 <gettoken+0x146>
     560:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     564:	83 ec 08             	sub    $0x8,%esp
     567:	50                   	push   %eax
     568:	68 f0 1b 00 00       	push   $0x1bf0
     56d:	e8 ee 05 00 00       	call   b60 <strchr>
     572:	83 c4 10             	add    $0x10,%esp
     575:	85 c0                	test   %eax,%eax
     577:	74 c7                	je     540 <gettoken+0xd0>
    ret = 'a';
     579:	bf 61 00 00 00       	mov    $0x61,%edi
     57e:	e9 4d ff ff ff       	jmp    4d0 <gettoken+0x60>
     583:	90                   	nop
     584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     588:	3c 7c                	cmp    $0x7c,%al
     58a:	75 ae                	jne    53a <gettoken+0xca>
  ret = *s;
     58c:	0f be f8             	movsbl %al,%edi
    s++;
     58f:	83 c5 01             	add    $0x1,%ebp
    break;
     592:	e9 39 ff ff ff       	jmp    4d0 <gettoken+0x60>
     597:	89 f6                	mov    %esi,%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      s++;
     5a0:	83 c5 02             	add    $0x2,%ebp
      ret = '+';
     5a3:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5a8:	e9 23 ff ff ff       	jmp    4d0 <gettoken+0x60>
     5ad:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     5b0:	3c 26                	cmp    $0x26,%al
     5b2:	75 86                	jne    53a <gettoken+0xca>
     5b4:	eb d6                	jmp    58c <gettoken+0x11c>
  if(eq)
     5b6:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     5ba:	bf 61 00 00 00       	mov    $0x61,%edi
     5bf:	85 c0                	test   %eax,%eax
     5c1:	0f 85 11 ff ff ff    	jne    4d8 <gettoken+0x68>
     5c7:	e9 3c ff ff ff       	jmp    508 <gettoken+0x98>
     5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005d0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5d0:	57                   	push   %edi
     5d1:	56                   	push   %esi
     5d2:	53                   	push   %ebx
     5d3:	8b 7c 24 10          	mov    0x10(%esp),%edi
     5d7:	8b 74 24 14          	mov    0x14(%esp),%esi
  char *s;
  
  s = *ps;
     5db:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5dd:	39 f3                	cmp    %esi,%ebx
     5df:	72 0e                	jb     5ef <peek+0x1f>
     5e1:	eb 24                	jmp    607 <peek+0x37>
     5e3:	90                   	nop
     5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     5e8:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     5eb:	39 de                	cmp    %ebx,%esi
     5ed:	74 18                	je     607 <peek+0x37>
     5ef:	0f be 03             	movsbl (%ebx),%eax
     5f2:	83 ec 08             	sub    $0x8,%esp
     5f5:	50                   	push   %eax
     5f6:	68 f0 1b 00 00       	push   $0x1bf0
     5fb:	e8 60 05 00 00       	call   b60 <strchr>
     600:	83 c4 10             	add    $0x10,%esp
     603:	85 c0                	test   %eax,%eax
     605:	75 e1                	jne    5e8 <peek+0x18>
  *ps = s;
     607:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     609:	0f be 13             	movsbl (%ebx),%edx
     60c:	31 c0                	xor    %eax,%eax
     60e:	84 d2                	test   %dl,%dl
     610:	74 18                	je     62a <peek+0x5a>
     612:	83 ec 08             	sub    $0x8,%esp
     615:	52                   	push   %edx
     616:	ff 74 24 24          	pushl  0x24(%esp)
     61a:	e8 41 05 00 00       	call   b60 <strchr>
     61f:	83 c4 10             	add    $0x10,%esp
     622:	85 c0                	test   %eax,%eax
     624:	0f 95 c0             	setne  %al
     627:	0f b6 c0             	movzbl %al,%eax
}
     62a:	5b                   	pop    %ebx
     62b:	5e                   	pop    %esi
     62c:	5f                   	pop    %edi
     62d:	c3                   	ret    
     62e:	66 90                	xchg   %ax,%ax

00000630 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     630:	55                   	push   %ebp
     631:	57                   	push   %edi
     632:	56                   	push   %esi
     633:	53                   	push   %ebx
     634:	83 ec 1c             	sub    $0x1c,%esp
     637:	8b 74 24 34          	mov    0x34(%esp),%esi
     63b:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     63f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     640:	8d 7c 24 08          	lea    0x8(%esp),%edi
  while(peek(ps, es, "<>")){
     644:	83 ec 04             	sub    $0x4,%esp
     647:	68 69 11 00 00       	push   $0x1169
     64c:	53                   	push   %ebx
     64d:	56                   	push   %esi
     64e:	e8 7d ff ff ff       	call   5d0 <peek>
     653:	83 c4 10             	add    $0x10,%esp
     656:	85 c0                	test   %eax,%eax
     658:	74 66                	je     6c0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     65a:	6a 00                	push   $0x0
     65c:	6a 00                	push   $0x0
     65e:	53                   	push   %ebx
     65f:	56                   	push   %esi
     660:	e8 0b fe ff ff       	call   470 <gettoken>
     665:	89 c5                	mov    %eax,%ebp
    if(gettoken(ps, es, &q, &eq) != 'a')
     667:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     66b:	50                   	push   %eax
     66c:	57                   	push   %edi
     66d:	53                   	push   %ebx
     66e:	56                   	push   %esi
     66f:	e8 fc fd ff ff       	call   470 <gettoken>
     674:	83 c4 20             	add    $0x20,%esp
     677:	83 f8 61             	cmp    $0x61,%eax
     67a:	75 50                	jne    6cc <parseredirs+0x9c>
      panic("missing file for redirection");
    switch(tok){
     67c:	83 fd 3c             	cmp    $0x3c,%ebp
     67f:	74 2f                	je     6b0 <parseredirs+0x80>
     681:	83 fd 3e             	cmp    $0x3e,%ebp
     684:	74 05                	je     68b <parseredirs+0x5b>
     686:	83 fd 2b             	cmp    $0x2b,%ebp
     689:	75 b9                	jne    644 <parseredirs+0x14>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     68b:	83 ec 0c             	sub    $0xc,%esp
     68e:	6a 01                	push   $0x1
     690:	68 01 02 00 00       	push   $0x201
     695:	ff 74 24 20          	pushl  0x20(%esp)
     699:	ff 74 24 20          	pushl  0x20(%esp)
     69d:	ff 74 24 4c          	pushl  0x4c(%esp)
     6a1:	e8 ca fc ff ff       	call   370 <redircmd>
     6a6:	89 44 24 50          	mov    %eax,0x50(%esp)
      break;
     6aa:	83 c4 20             	add    $0x20,%esp
     6ad:	eb 91                	jmp    640 <parseredirs+0x10>
     6af:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6b0:	83 ec 0c             	sub    $0xc,%esp
     6b3:	6a 00                	push   $0x0
     6b5:	6a 00                	push   $0x0
     6b7:	eb dc                	jmp    695 <parseredirs+0x65>
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6c0:	8b 44 24 30          	mov    0x30(%esp),%eax
     6c4:	83 c4 1c             	add    $0x1c,%esp
     6c7:	5b                   	pop    %ebx
     6c8:	5e                   	pop    %esi
     6c9:	5f                   	pop    %edi
     6ca:	5d                   	pop    %ebp
     6cb:	c3                   	ret    
      panic("missing file for redirection");
     6cc:	83 ec 0c             	sub    $0xc,%esp
     6cf:	68 4c 11 00 00       	push   $0x114c
     6d4:	e8 77 fa ff ff       	call   150 <panic>
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006e0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6e0:	55                   	push   %ebp
     6e1:	57                   	push   %edi
     6e2:	56                   	push   %esi
     6e3:	53                   	push   %ebx
     6e4:	83 ec 30             	sub    $0x30,%esp
     6e7:	8b 74 24 44          	mov    0x44(%esp),%esi
     6eb:	8b 7c 24 48          	mov    0x48(%esp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     6ef:	68 6c 11 00 00       	push   $0x116c
     6f4:	57                   	push   %edi
     6f5:	56                   	push   %esi
     6f6:	e8 d5 fe ff ff       	call   5d0 <peek>
     6fb:	83 c4 10             	add    $0x10,%esp
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 85 92 00 00 00    	jne    798 <parseexec+0xb8>
     706:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     708:	e8 33 fc ff ff       	call   340 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     70d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     710:	89 c5                	mov    %eax,%ebp
  ret = parseredirs(ret, ps, es);
     712:	57                   	push   %edi
     713:	56                   	push   %esi
     714:	50                   	push   %eax
     715:	e8 16 ff ff ff       	call   630 <parseredirs>
     71a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     71e:	83 c4 10             	add    $0x10,%esp
     721:	eb 1a                	jmp    73d <parseexec+0x5d>
     723:	90                   	nop
     724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     728:	83 ec 04             	sub    $0x4,%esp
     72b:	57                   	push   %edi
     72c:	56                   	push   %esi
     72d:	ff 74 24 18          	pushl  0x18(%esp)
     731:	e8 fa fe ff ff       	call   630 <parseredirs>
     736:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     73a:	83 c4 10             	add    $0x10,%esp
  while(!peek(ps, es, "|)&;")){
     73d:	83 ec 04             	sub    $0x4,%esp
     740:	68 83 11 00 00       	push   $0x1183
     745:	57                   	push   %edi
     746:	56                   	push   %esi
     747:	e8 84 fe ff ff       	call   5d0 <peek>
     74c:	83 c4 10             	add    $0x10,%esp
     74f:	85 c0                	test   %eax,%eax
     751:	75 65                	jne    7b8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     753:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     757:	50                   	push   %eax
     758:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     75c:	50                   	push   %eax
     75d:	57                   	push   %edi
     75e:	56                   	push   %esi
     75f:	e8 0c fd ff ff       	call   470 <gettoken>
     764:	83 c4 10             	add    $0x10,%esp
     767:	85 c0                	test   %eax,%eax
     769:	74 4d                	je     7b8 <parseexec+0xd8>
    if(tok != 'a')
     76b:	83 f8 61             	cmp    $0x61,%eax
     76e:	75 66                	jne    7d6 <parseexec+0xf6>
    cmd->argv[argc] = q;
     770:	8b 44 24 18          	mov    0x18(%esp),%eax
     774:	89 44 9d 04          	mov    %eax,0x4(%ebp,%ebx,4)
    cmd->eargv[argc] = eq;
     778:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     77c:	89 44 9d 2c          	mov    %eax,0x2c(%ebp,%ebx,4)
    argc++;
     780:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     783:	83 fb 0a             	cmp    $0xa,%ebx
     786:	75 a0                	jne    728 <parseexec+0x48>
      panic("too many args");
     788:	83 ec 0c             	sub    $0xc,%esp
     78b:	68 75 11 00 00       	push   $0x1175
     790:	e8 bb f9 ff ff       	call   150 <panic>
     795:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     798:	83 ec 08             	sub    $0x8,%esp
     79b:	57                   	push   %edi
     79c:	56                   	push   %esi
     79d:	e8 4e 01 00 00       	call   8f0 <parseblock>
     7a2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     7a6:	83 c4 10             	add    $0x10,%esp
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7a9:	8b 44 24 0c          	mov    0xc(%esp),%eax
     7ad:	83 c4 2c             	add    $0x2c,%esp
     7b0:	5b                   	pop    %ebx
     7b1:	5e                   	pop    %esi
     7b2:	5f                   	pop    %edi
     7b3:	5d                   	pop    %ebp
     7b4:	c3                   	ret    
     7b5:	8d 76 00             	lea    0x0(%esi),%esi
     7b8:	8d 44 9d 00          	lea    0x0(%ebp,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7bc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7c3:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7ca:	8b 44 24 0c          	mov    0xc(%esp),%eax
     7ce:	83 c4 2c             	add    $0x2c,%esp
     7d1:	5b                   	pop    %ebx
     7d2:	5e                   	pop    %esi
     7d3:	5f                   	pop    %edi
     7d4:	5d                   	pop    %ebp
     7d5:	c3                   	ret    
      panic("syntax");
     7d6:	83 ec 0c             	sub    $0xc,%esp
     7d9:	68 6e 11 00 00       	push   $0x116e
     7de:	e8 6d f9 ff ff       	call   150 <panic>
     7e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007f0 <parsepipe>:
{
     7f0:	57                   	push   %edi
     7f1:	56                   	push   %esi
     7f2:	53                   	push   %ebx
     7f3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     7f7:	8b 74 24 14          	mov    0x14(%esp),%esi
  cmd = parseexec(ps, es);
     7fb:	83 ec 08             	sub    $0x8,%esp
     7fe:	56                   	push   %esi
     7ff:	53                   	push   %ebx
     800:	e8 db fe ff ff       	call   6e0 <parseexec>
  if(peek(ps, es, "|")){
     805:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     808:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     80a:	68 88 11 00 00       	push   $0x1188
     80f:	56                   	push   %esi
     810:	53                   	push   %ebx
     811:	e8 ba fd ff ff       	call   5d0 <peek>
     816:	83 c4 10             	add    $0x10,%esp
     819:	85 c0                	test   %eax,%eax
     81b:	75 0b                	jne    828 <parsepipe+0x38>
}
     81d:	89 f8                	mov    %edi,%eax
     81f:	5b                   	pop    %ebx
     820:	5e                   	pop    %esi
     821:	5f                   	pop    %edi
     822:	c3                   	ret    
     823:	90                   	nop
     824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     828:	6a 00                	push   $0x0
     82a:	6a 00                	push   $0x0
     82c:	56                   	push   %esi
     82d:	53                   	push   %ebx
     82e:	e8 3d fc ff ff       	call   470 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     833:	58                   	pop    %eax
     834:	5a                   	pop    %edx
     835:	56                   	push   %esi
     836:	53                   	push   %ebx
     837:	e8 b4 ff ff ff       	call   7f0 <parsepipe>
     83c:	83 c4 10             	add    $0x10,%esp
     83f:	89 44 24 14          	mov    %eax,0x14(%esp)
     843:	89 7c 24 10          	mov    %edi,0x10(%esp)
}
     847:	5b                   	pop    %ebx
     848:	5e                   	pop    %esi
     849:	5f                   	pop    %edi
    cmd = pipecmd(cmd, parsepipe(ps, es));
     84a:	e9 71 fb ff ff       	jmp    3c0 <pipecmd>
     84f:	90                   	nop

00000850 <parseline>:
{
     850:	57                   	push   %edi
     851:	56                   	push   %esi
     852:	53                   	push   %ebx
     853:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     857:	8b 74 24 14          	mov    0x14(%esp),%esi
  cmd = parsepipe(ps, es);
     85b:	83 ec 08             	sub    $0x8,%esp
     85e:	56                   	push   %esi
     85f:	53                   	push   %ebx
     860:	e8 8b ff ff ff       	call   7f0 <parsepipe>
  while(peek(ps, es, "&")){
     865:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     868:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     86a:	eb 1c                	jmp    888 <parseline+0x38>
     86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     870:	6a 00                	push   $0x0
     872:	6a 00                	push   $0x0
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	e8 f5 fb ff ff       	call   470 <gettoken>
    cmd = backcmd(cmd);
     87b:	89 3c 24             	mov    %edi,(%esp)
     87e:	e8 bd fb ff ff       	call   440 <backcmd>
     883:	83 c4 10             	add    $0x10,%esp
     886:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     888:	83 ec 04             	sub    $0x4,%esp
     88b:	68 8a 11 00 00       	push   $0x118a
     890:	56                   	push   %esi
     891:	53                   	push   %ebx
     892:	e8 39 fd ff ff       	call   5d0 <peek>
     897:	83 c4 10             	add    $0x10,%esp
     89a:	85 c0                	test   %eax,%eax
     89c:	75 d2                	jne    870 <parseline+0x20>
  if(peek(ps, es, ";")){
     89e:	83 ec 04             	sub    $0x4,%esp
     8a1:	68 86 11 00 00       	push   $0x1186
     8a6:	56                   	push   %esi
     8a7:	53                   	push   %ebx
     8a8:	e8 23 fd ff ff       	call   5d0 <peek>
     8ad:	83 c4 10             	add    $0x10,%esp
     8b0:	85 c0                	test   %eax,%eax
     8b2:	75 0c                	jne    8c0 <parseline+0x70>
}
     8b4:	89 f8                	mov    %edi,%eax
     8b6:	5b                   	pop    %ebx
     8b7:	5e                   	pop    %esi
     8b8:	5f                   	pop    %edi
     8b9:	c3                   	ret    
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8c0:	6a 00                	push   $0x0
     8c2:	6a 00                	push   $0x0
     8c4:	56                   	push   %esi
     8c5:	53                   	push   %ebx
     8c6:	e8 a5 fb ff ff       	call   470 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8cb:	58                   	pop    %eax
     8cc:	5a                   	pop    %edx
     8cd:	56                   	push   %esi
     8ce:	53                   	push   %ebx
     8cf:	e8 7c ff ff ff       	call   850 <parseline>
     8d4:	83 c4 10             	add    $0x10,%esp
     8d7:	89 44 24 14          	mov    %eax,0x14(%esp)
     8db:	89 7c 24 10          	mov    %edi,0x10(%esp)
}
     8df:	5b                   	pop    %ebx
     8e0:	5e                   	pop    %esi
     8e1:	5f                   	pop    %edi
    cmd = listcmd(cmd, parseline(ps, es));
     8e2:	e9 19 fb ff ff       	jmp    400 <listcmd>
     8e7:	89 f6                	mov    %esi,%esi
     8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <parseblock>:
{
     8f0:	57                   	push   %edi
     8f1:	56                   	push   %esi
     8f2:	53                   	push   %ebx
     8f3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     8f7:	8b 74 24 14          	mov    0x14(%esp),%esi
  if(!peek(ps, es, "("))
     8fb:	83 ec 04             	sub    $0x4,%esp
     8fe:	68 6c 11 00 00       	push   $0x116c
     903:	56                   	push   %esi
     904:	53                   	push   %ebx
     905:	e8 c6 fc ff ff       	call   5d0 <peek>
     90a:	83 c4 10             	add    $0x10,%esp
     90d:	85 c0                	test   %eax,%eax
     90f:	74 49                	je     95a <parseblock+0x6a>
  gettoken(ps, es, 0, 0);
     911:	6a 00                	push   $0x0
     913:	6a 00                	push   $0x0
     915:	56                   	push   %esi
     916:	53                   	push   %ebx
     917:	e8 54 fb ff ff       	call   470 <gettoken>
  cmd = parseline(ps, es);
     91c:	58                   	pop    %eax
     91d:	5a                   	pop    %edx
     91e:	56                   	push   %esi
     91f:	53                   	push   %ebx
     920:	e8 2b ff ff ff       	call   850 <parseline>
  if(!peek(ps, es, ")"))
     925:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     928:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     92a:	68 a8 11 00 00       	push   $0x11a8
     92f:	56                   	push   %esi
     930:	53                   	push   %ebx
     931:	e8 9a fc ff ff       	call   5d0 <peek>
     936:	83 c4 10             	add    $0x10,%esp
     939:	85 c0                	test   %eax,%eax
     93b:	74 2a                	je     967 <parseblock+0x77>
  gettoken(ps, es, 0, 0);
     93d:	6a 00                	push   $0x0
     93f:	6a 00                	push   $0x0
     941:	56                   	push   %esi
     942:	53                   	push   %ebx
     943:	e8 28 fb ff ff       	call   470 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     948:	83 c4 0c             	add    $0xc,%esp
     94b:	56                   	push   %esi
     94c:	53                   	push   %ebx
     94d:	57                   	push   %edi
     94e:	e8 dd fc ff ff       	call   630 <parseredirs>
  return cmd;
     953:	83 c4 10             	add    $0x10,%esp
}
     956:	5b                   	pop    %ebx
     957:	5e                   	pop    %esi
     958:	5f                   	pop    %edi
     959:	c3                   	ret    
    panic("parseblock");
     95a:	83 ec 0c             	sub    $0xc,%esp
     95d:	68 8c 11 00 00       	push   $0x118c
     962:	e8 e9 f7 ff ff       	call   150 <panic>
    panic("syntax - missing )");
     967:	83 ec 0c             	sub    $0xc,%esp
     96a:	68 97 11 00 00       	push   $0x1197
     96f:	e8 dc f7 ff ff       	call   150 <panic>
     974:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     97a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000980 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     980:	53                   	push   %ebx
     981:	83 ec 08             	sub    $0x8,%esp
     984:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     988:	85 db                	test   %ebx,%ebx
     98a:	74 22                	je     9ae <nulterminate+0x2e>
    return 0;
  
  switch(cmd->type){
     98c:	83 3b 05             	cmpl   $0x5,(%ebx)
     98f:	77 1d                	ja     9ae <nulterminate+0x2e>
     991:	8b 03                	mov    (%ebx),%eax
     993:	ff 24 85 e8 11 00 00 	jmp    *0x11e8(,%eax,4)
     99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9a0:	83 ec 0c             	sub    $0xc,%esp
     9a3:	ff 73 04             	pushl  0x4(%ebx)
     9a6:	e8 d5 ff ff ff       	call   980 <nulterminate>
    break;
     9ab:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9ae:	83 c4 08             	add    $0x8,%esp
     9b1:	89 d8                	mov    %ebx,%eax
     9b3:	5b                   	pop    %ebx
     9b4:	c3                   	ret    
     9b5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9b8:	83 ec 0c             	sub    $0xc,%esp
     9bb:	ff 73 04             	pushl  0x4(%ebx)
     9be:	e8 bd ff ff ff       	call   980 <nulterminate>
    nulterminate(lcmd->right);
     9c3:	58                   	pop    %eax
     9c4:	ff 73 08             	pushl  0x8(%ebx)
     9c7:	e8 b4 ff ff ff       	call   980 <nulterminate>
    break;
     9cc:	83 c4 10             	add    $0x10,%esp
}
     9cf:	89 d8                	mov    %ebx,%eax
     9d1:	83 c4 08             	add    $0x8,%esp
     9d4:	5b                   	pop    %ebx
     9d5:	c3                   	ret    
     9d6:	8d 76 00             	lea    0x0(%esi),%esi
     9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     9e0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     9e3:	8d 43 08             	lea    0x8(%ebx),%eax
     9e6:	85 c9                	test   %ecx,%ecx
     9e8:	74 c4                	je     9ae <nulterminate+0x2e>
     9ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     9f0:	8b 50 24             	mov    0x24(%eax),%edx
     9f3:	83 c0 04             	add    $0x4,%eax
     9f6:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     9f9:	8b 50 fc             	mov    -0x4(%eax),%edx
     9fc:	85 d2                	test   %edx,%edx
     9fe:	75 f0                	jne    9f0 <nulterminate+0x70>
}
     a00:	83 c4 08             	add    $0x8,%esp
     a03:	89 d8                	mov    %ebx,%eax
     a05:	5b                   	pop    %ebx
     a06:	c3                   	ret    
     a07:	89 f6                	mov    %esi,%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	ff 73 04             	pushl  0x4(%ebx)
     a16:	e8 65 ff ff ff       	call   980 <nulterminate>
    *rcmd->efile = 0;
     a1b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a1e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a21:	c6 00 00             	movb   $0x0,(%eax)
}
     a24:	83 c4 08             	add    $0x8,%esp
     a27:	89 d8                	mov    %ebx,%eax
     a29:	5b                   	pop    %ebx
     a2a:	c3                   	ret    
     a2b:	90                   	nop
     a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a30 <parsecmd>:
{
     a30:	56                   	push   %esi
     a31:	53                   	push   %ebx
     a32:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     a35:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
     a39:	53                   	push   %ebx
     a3a:	e8 e1 00 00 00       	call   b20 <strlen>
  cmd = parseline(&s, es);
     a3f:	59                   	pop    %ecx
     a40:	5e                   	pop    %esi
  es = s + strlen(s);
     a41:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a43:	53                   	push   %ebx
     a44:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     a48:	50                   	push   %eax
     a49:	e8 02 fe ff ff       	call   850 <parseline>
  peek(&s, es, "");
     a4e:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(&s, es);
     a51:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a53:	68 31 11 00 00       	push   $0x1131
     a58:	53                   	push   %ebx
     a59:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     a5d:	50                   	push   %eax
     a5e:	e8 6d fb ff ff       	call   5d0 <peek>
  if(s != es){
     a63:	8b 44 24 20          	mov    0x20(%esp),%eax
     a67:	83 c4 10             	add    $0x10,%esp
     a6a:	39 c3                	cmp    %eax,%ebx
     a6c:	75 11                	jne    a7f <parsecmd+0x4f>
  nulterminate(cmd);
     a6e:	83 ec 0c             	sub    $0xc,%esp
     a71:	56                   	push   %esi
     a72:	e8 09 ff ff ff       	call   980 <nulterminate>
}
     a77:	83 c4 14             	add    $0x14,%esp
     a7a:	89 f0                	mov    %esi,%eax
     a7c:	5b                   	pop    %ebx
     a7d:	5e                   	pop    %esi
     a7e:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     a7f:	52                   	push   %edx
     a80:	50                   	push   %eax
     a81:	68 aa 11 00 00       	push   $0x11aa
     a86:	6a 02                	push   $0x2
     a88:	e8 73 03 00 00       	call   e00 <printf>
    panic("syntax");
     a8d:	c7 04 24 6e 11 00 00 	movl   $0x116e,(%esp)
     a94:	e8 b7 f6 ff ff       	call   150 <panic>
     a99:	66 90                	xchg   %ax,%ax
     a9b:	66 90                	xchg   %ax,%ax
     a9d:	66 90                	xchg   %ax,%ax
     a9f:	90                   	nop

00000aa0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     aa0:	53                   	push   %ebx
     aa1:	8b 44 24 08          	mov    0x8(%esp),%eax
     aa5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aa9:	89 c2                	mov    %eax,%edx
     aab:	90                   	nop
     aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ab0:	83 c1 01             	add    $0x1,%ecx
     ab3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ab7:	83 c2 01             	add    $0x1,%edx
     aba:	84 db                	test   %bl,%bl
     abc:	88 5a ff             	mov    %bl,-0x1(%edx)
     abf:	75 ef                	jne    ab0 <strcpy+0x10>
    ;
  return os;
}
     ac1:	5b                   	pop    %ebx
     ac2:	c3                   	ret    
     ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ad0:	56                   	push   %esi
     ad1:	53                   	push   %ebx
     ad2:	8b 54 24 0c          	mov    0xc(%esp),%edx
     ad6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
     ada:	0f b6 02             	movzbl (%edx),%eax
     add:	0f b6 19             	movzbl (%ecx),%ebx
     ae0:	84 c0                	test   %al,%al
     ae2:	75 1f                	jne    b03 <strcmp+0x33>
     ae4:	eb 2a                	jmp    b10 <strcmp+0x40>
     ae6:	8d 76 00             	lea    0x0(%esi),%esi
     ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     af0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     af3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     af6:	8d 71 01             	lea    0x1(%ecx),%esi
  while(*p && *p == *q)
     af9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     afd:	84 c0                	test   %al,%al
     aff:	74 0f                	je     b10 <strcmp+0x40>
     b01:	89 f1                	mov    %esi,%ecx
     b03:	38 d8                	cmp    %bl,%al
     b05:	74 e9                	je     af0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b07:	29 d8                	sub    %ebx,%eax
}
     b09:	5b                   	pop    %ebx
     b0a:	5e                   	pop    %esi
     b0b:	c3                   	ret    
     b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*p && *p == *q)
     b10:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b12:	29 d8                	sub    %ebx,%eax
}
     b14:	5b                   	pop    %ebx
     b15:	5e                   	pop    %esi
     b16:	c3                   	ret    
     b17:	89 f6                	mov    %esi,%esi
     b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b20 <strlen>:

uint
strlen(char *s)
{
     b20:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b24:	80 39 00             	cmpb   $0x0,(%ecx)
     b27:	74 14                	je     b3d <strlen+0x1d>
     b29:	31 d2                	xor    %edx,%edx
     b2b:	90                   	nop
     b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b30:	83 c2 01             	add    $0x1,%edx
     b33:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b37:	89 d0                	mov    %edx,%eax
     b39:	75 f5                	jne    b30 <strlen+0x10>
     b3b:	f3 c3                	repz ret 
     b3d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     b3f:	c3                   	ret    

00000b40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b40:	57                   	push   %edi
     b41:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b45:	8b 4c 24 10          	mov    0x10(%esp),%ecx
     b49:	8b 44 24 0c          	mov    0xc(%esp),%eax
     b4d:	89 d7                	mov    %edx,%edi
     b4f:	fc                   	cld    
     b50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b52:	89 d0                	mov    %edx,%eax
     b54:	5f                   	pop    %edi
     b55:	c3                   	ret    
     b56:	8d 76 00             	lea    0x0(%esi),%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b60 <strchr>:

char*
strchr(const char *s, char c)
{
     b60:	53                   	push   %ebx
     b61:	8b 44 24 08          	mov    0x8(%esp),%eax
     b65:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
     b69:	0f b6 10             	movzbl (%eax),%edx
     b6c:	84 d2                	test   %dl,%dl
     b6e:	74 1e                	je     b8e <strchr+0x2e>
    if(*s == c)
     b70:	38 d3                	cmp    %dl,%bl
     b72:	89 d9                	mov    %ebx,%ecx
     b74:	75 0e                	jne    b84 <strchr+0x24>
     b76:	eb 18                	jmp    b90 <strchr+0x30>
     b78:	90                   	nop
     b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b80:	38 ca                	cmp    %cl,%dl
     b82:	74 0c                	je     b90 <strchr+0x30>
  for(; *s; s++)
     b84:	83 c0 01             	add    $0x1,%eax
     b87:	0f b6 10             	movzbl (%eax),%edx
     b8a:	84 d2                	test   %dl,%dl
     b8c:	75 f2                	jne    b80 <strchr+0x20>
      return (char*) s;
  return 0;
     b8e:	31 c0                	xor    %eax,%eax
}
     b90:	5b                   	pop    %ebx
     b91:	c3                   	ret    
     b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ba0 <gets>:

char*
gets(char *buf, int max)
{
     ba0:	55                   	push   %ebp
     ba1:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ba2:	31 ff                	xor    %edi,%edi
{
     ba4:	56                   	push   %esi
     ba5:	53                   	push   %ebx
     ba6:	83 ec 1c             	sub    $0x1c,%esp
     ba9:	8b 74 24 30          	mov    0x30(%esp),%esi
    cc = read(0, &c, 1);
     bad:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
  for(i=0; i+1 < max; ){
     bb1:	eb 2c                	jmp    bdf <gets+0x3f>
     bb3:	90                   	nop
     bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     bb8:	83 ec 04             	sub    $0x4,%esp
     bbb:	6a 01                	push   $0x1
     bbd:	55                   	push   %ebp
     bbe:	6a 00                	push   $0x0
     bc0:	e8 14 01 00 00       	call   cd9 <read>
    if(cc < 1)
     bc5:	83 c4 10             	add    $0x10,%esp
     bc8:	85 c0                	test   %eax,%eax
     bca:	7e 1c                	jle    be8 <gets+0x48>
      break;
    buf[i++] = c;
     bcc:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
     bd1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
     bd3:	3c 0a                	cmp    $0xa,%al
    buf[i++] = c;
     bd5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
     bd9:	74 25                	je     c00 <gets+0x60>
     bdb:	3c 0d                	cmp    $0xd,%al
     bdd:	74 21                	je     c00 <gets+0x60>
  for(i=0; i+1 < max; ){
     bdf:	8d 5f 01             	lea    0x1(%edi),%ebx
     be2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
     be6:	7c d0                	jl     bb8 <gets+0x18>
      break;
  }
  buf[i] = '\0';
     be8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
     bec:	83 c4 1c             	add    $0x1c,%esp
     bef:	89 f0                	mov    %esi,%eax
     bf1:	5b                   	pop    %ebx
     bf2:	5e                   	pop    %esi
     bf3:	5f                   	pop    %edi
     bf4:	5d                   	pop    %ebp
     bf5:	c3                   	ret    
     bf6:	8d 76 00             	lea    0x0(%esi),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i+1 < max; ){
     c00:	89 df                	mov    %ebx,%edi
}
     c02:	89 f0                	mov    %esi,%eax
  buf[i] = '\0';
     c04:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
}
     c08:	83 c4 1c             	add    $0x1c,%esp
     c0b:	5b                   	pop    %ebx
     c0c:	5e                   	pop    %esi
     c0d:	5f                   	pop    %edi
     c0e:	5d                   	pop    %ebp
     c0f:	c3                   	ret    

00000c10 <stat>:

int
stat(char *n, struct stat_new *st)
{
     c10:	56                   	push   %esi
     c11:	53                   	push   %ebx
     c12:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c15:	6a 00                	push   $0x0
     c17:	ff 74 24 1c          	pushl  0x1c(%esp)
     c1b:	e8 e1 00 00 00       	call   d01 <open>
  if(fd < 0)
     c20:	83 c4 10             	add    $0x10,%esp
     c23:	85 c0                	test   %eax,%eax
     c25:	78 29                	js     c50 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c27:	83 ec 08             	sub    $0x8,%esp
     c2a:	89 c3                	mov    %eax,%ebx
     c2c:	ff 74 24 1c          	pushl  0x1c(%esp)
     c30:	50                   	push   %eax
     c31:	e8 e3 00 00 00       	call   d19 <fstat>
  close(fd);
     c36:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c39:	89 c6                	mov    %eax,%esi
  close(fd);
     c3b:	e8 a9 00 00 00       	call   ce9 <close>
  return r;
     c40:	83 c4 10             	add    $0x10,%esp
}
     c43:	83 c4 04             	add    $0x4,%esp
     c46:	89 f0                	mov    %esi,%eax
     c48:	5b                   	pop    %ebx
     c49:	5e                   	pop    %esi
     c4a:	c3                   	ret    
     c4b:	90                   	nop
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     c50:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c55:	eb ec                	jmp    c43 <stat+0x33>
     c57:	89 f6                	mov    %esi,%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c60 <atoi>:

int
atoi(const char *s)
{
     c60:	53                   	push   %ebx
     c61:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c65:	0f be 11             	movsbl (%ecx),%edx
     c68:	8d 42 d0             	lea    -0x30(%edx),%eax
     c6b:	3c 09                	cmp    $0x9,%al
     c6d:	b8 00 00 00 00       	mov    $0x0,%eax
     c72:	77 19                	ja     c8d <atoi+0x2d>
     c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     c78:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c7b:	83 c1 01             	add    $0x1,%ecx
     c7e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     c82:	0f be 11             	movsbl (%ecx),%edx
     c85:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c88:	80 fb 09             	cmp    $0x9,%bl
     c8b:	76 eb                	jbe    c78 <atoi+0x18>
  return n;
}
     c8d:	5b                   	pop    %ebx
     c8e:	c3                   	ret    
     c8f:	90                   	nop

00000c90 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     c90:	56                   	push   %esi
     c91:	53                   	push   %ebx
     c92:	8b 5c 24 14          	mov    0x14(%esp),%ebx
     c96:	8b 44 24 0c          	mov    0xc(%esp),%eax
     c9a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c9e:	85 db                	test   %ebx,%ebx
     ca0:	7e 14                	jle    cb6 <memmove+0x26>
     ca2:	31 d2                	xor    %edx,%edx
     ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     ca8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     caf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     cb2:	39 da                	cmp    %ebx,%edx
     cb4:	75 f2                	jne    ca8 <memmove+0x18>
  return vdst;
}
     cb6:	5b                   	pop    %ebx
     cb7:	5e                   	pop    %esi
     cb8:	c3                   	ret    

00000cb9 <fork>:
     cb9:	b8 01 00 00 00       	mov    $0x1,%eax
     cbe:	cd 40                	int    $0x40
     cc0:	c3                   	ret    

00000cc1 <exit>:
     cc1:	b8 02 00 00 00       	mov    $0x2,%eax
     cc6:	cd 40                	int    $0x40
     cc8:	c3                   	ret    

00000cc9 <wait>:
     cc9:	b8 03 00 00 00       	mov    $0x3,%eax
     cce:	cd 40                	int    $0x40
     cd0:	c3                   	ret    

00000cd1 <pipe>:
     cd1:	b8 04 00 00 00       	mov    $0x4,%eax
     cd6:	cd 40                	int    $0x40
     cd8:	c3                   	ret    

00000cd9 <read>:
     cd9:	b8 06 00 00 00       	mov    $0x6,%eax
     cde:	cd 40                	int    $0x40
     ce0:	c3                   	ret    

00000ce1 <write>:
     ce1:	b8 05 00 00 00       	mov    $0x5,%eax
     ce6:	cd 40                	int    $0x40
     ce8:	c3                   	ret    

00000ce9 <close>:
     ce9:	b8 07 00 00 00       	mov    $0x7,%eax
     cee:	cd 40                	int    $0x40
     cf0:	c3                   	ret    

00000cf1 <kill>:
     cf1:	b8 08 00 00 00       	mov    $0x8,%eax
     cf6:	cd 40                	int    $0x40
     cf8:	c3                   	ret    

00000cf9 <exec>:
     cf9:	b8 09 00 00 00       	mov    $0x9,%eax
     cfe:	cd 40                	int    $0x40
     d00:	c3                   	ret    

00000d01 <open>:
     d01:	b8 0a 00 00 00       	mov    $0xa,%eax
     d06:	cd 40                	int    $0x40
     d08:	c3                   	ret    

00000d09 <mknod>:
     d09:	b8 0b 00 00 00       	mov    $0xb,%eax
     d0e:	cd 40                	int    $0x40
     d10:	c3                   	ret    

00000d11 <unlink>:
     d11:	b8 0c 00 00 00       	mov    $0xc,%eax
     d16:	cd 40                	int    $0x40
     d18:	c3                   	ret    

00000d19 <fstat>:
     d19:	b8 0d 00 00 00       	mov    $0xd,%eax
     d1e:	cd 40                	int    $0x40
     d20:	c3                   	ret    

00000d21 <link>:
     d21:	b8 0e 00 00 00       	mov    $0xe,%eax
     d26:	cd 40                	int    $0x40
     d28:	c3                   	ret    

00000d29 <mkdir>:
     d29:	b8 0f 00 00 00       	mov    $0xf,%eax
     d2e:	cd 40                	int    $0x40
     d30:	c3                   	ret    

00000d31 <chdir>:
     d31:	b8 10 00 00 00       	mov    $0x10,%eax
     d36:	cd 40                	int    $0x40
     d38:	c3                   	ret    

00000d39 <dup>:
     d39:	b8 11 00 00 00       	mov    $0x11,%eax
     d3e:	cd 40                	int    $0x40
     d40:	c3                   	ret    

00000d41 <getpid>:
     d41:	b8 12 00 00 00       	mov    $0x12,%eax
     d46:	cd 40                	int    $0x40
     d48:	c3                   	ret    

00000d49 <sbrk>:
     d49:	b8 13 00 00 00       	mov    $0x13,%eax
     d4e:	cd 40                	int    $0x40
     d50:	c3                   	ret    

00000d51 <sleep>:
     d51:	b8 14 00 00 00       	mov    $0x14,%eax
     d56:	cd 40                	int    $0x40
     d58:	c3                   	ret    
     d59:	66 90                	xchg   %ax,%ax
     d5b:	66 90                	xchg   %ax,%ax
     d5d:	66 90                	xchg   %ax,%ax
     d5f:	90                   	nop

00000d60 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d60:	55                   	push   %ebp
     d61:	57                   	push   %edi
     d62:	89 c7                	mov    %eax,%edi
     d64:	56                   	push   %esi
     d65:	53                   	push   %ebx
     d66:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d69:	8b 5c 24 50          	mov    0x50(%esp),%ebx
     d6d:	85 db                	test   %ebx,%ebx
     d6f:	74 7f                	je     df0 <printint+0x90>
     d71:	89 d0                	mov    %edx,%eax
     d73:	c1 e8 1f             	shr    $0x1f,%eax
     d76:	84 c0                	test   %al,%al
     d78:	74 76                	je     df0 <printint+0x90>
    neg = 1;
    x = -xx;
     d7a:	89 d0                	mov    %edx,%eax
    neg = 1;
     d7c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     d83:	00 
    x = -xx;
     d84:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
     d86:	31 ed                	xor    %ebp,%ebp
     d88:	8d 74 24 1f          	lea    0x1f(%esp),%esi
     d8c:	eb 04                	jmp    d92 <printint+0x32>
     d8e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
     d90:	89 dd                	mov    %ebx,%ebp
     d92:	31 d2                	xor    %edx,%edx
     d94:	8d 5d 01             	lea    0x1(%ebp),%ebx
     d97:	f7 f1                	div    %ecx
     d99:	0f b6 92 08 12 00 00 	movzbl 0x1208(%edx),%edx
  }while((x /= base) != 0);
     da0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     da2:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
     da5:	75 e9                	jne    d90 <printint+0x30>
  if(neg)
     da7:	8b 44 24 0c          	mov    0xc(%esp),%eax
     dab:	85 c0                	test   %eax,%eax
     dad:	74 08                	je     db7 <printint+0x57>
    buf[i++] = '-';
     daf:	c6 44 1c 20 2d       	movb   $0x2d,0x20(%esp,%ebx,1)
     db4:	8d 5d 02             	lea    0x2(%ebp),%ebx

  while(--i >= 0)
     db7:	83 eb 01             	sub    $0x1,%ebx
     dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dc0:	0f b6 44 1c 20       	movzbl 0x20(%esp,%ebx,1),%eax
  write(fd, &c, 1);
     dc5:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
     dc8:	83 eb 01             	sub    $0x1,%ebx
     dcb:	88 44 24 23          	mov    %al,0x23(%esp)
  write(fd, &c, 1);
     dcf:	6a 01                	push   $0x1
     dd1:	56                   	push   %esi
     dd2:	57                   	push   %edi
     dd3:	e8 09 ff ff ff       	call   ce1 <write>
  while(--i >= 0)
     dd8:	83 c4 10             	add    $0x10,%esp
     ddb:	83 fb ff             	cmp    $0xffffffff,%ebx
     dde:	75 e0                	jne    dc0 <printint+0x60>
    putc(fd, buf[i]);
}
     de0:	83 c4 3c             	add    $0x3c,%esp
     de3:	5b                   	pop    %ebx
     de4:	5e                   	pop    %esi
     de5:	5f                   	pop    %edi
     de6:	5d                   	pop    %ebp
     de7:	c3                   	ret    
     de8:	90                   	nop
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = xx;
     df0:	89 d0                	mov    %edx,%eax
  neg = 0;
     df2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     df9:	00 
     dfa:	eb 8a                	jmp    d86 <printint+0x26>
     dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e00:	55                   	push   %ebp
     e01:	57                   	push   %edi
     e02:	56                   	push   %esi
     e03:	53                   	push   %ebx
     e04:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e07:	8b 74 24 44          	mov    0x44(%esp),%esi
     e0b:	8d 44 24 48          	lea    0x48(%esp),%eax
{
     e0f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  for(i = 0; fmt[i]; i++){
     e13:	89 44 24 0c          	mov    %eax,0xc(%esp)
     e17:	0f b6 1e             	movzbl (%esi),%ebx
     e1a:	83 c6 01             	add    $0x1,%esi
     e1d:	84 db                	test   %bl,%bl
     e1f:	0f 84 ad 00 00 00    	je     ed2 <printf+0xd2>
     e25:	31 ed                	xor    %ebp,%ebp
     e27:	eb 32                	jmp    e5b <printf+0x5b>
     e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e30:	83 f8 25             	cmp    $0x25,%eax
     e33:	0f 84 a7 00 00 00    	je     ee0 <printf+0xe0>
     e39:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
  write(fd, &c, 1);
     e3d:	83 ec 04             	sub    $0x4,%esp
     e40:	6a 01                	push   $0x1
     e42:	8d 44 24 22          	lea    0x22(%esp),%eax
     e46:	50                   	push   %eax
     e47:	57                   	push   %edi
     e48:	e8 94 fe ff ff       	call   ce1 <write>
     e4d:	83 c4 10             	add    $0x10,%esp
     e50:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     e53:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e57:	84 db                	test   %bl,%bl
     e59:	74 77                	je     ed2 <printf+0xd2>
    if(state == 0){
     e5b:	85 ed                	test   %ebp,%ebp
    c = fmt[i] & 0xff;
     e5d:	0f be cb             	movsbl %bl,%ecx
     e60:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e63:	74 cb                	je     e30 <printf+0x30>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e65:	83 fd 25             	cmp    $0x25,%ebp
     e68:	75 e6                	jne    e50 <printf+0x50>
      if(c == 'd'){
     e6a:	83 f8 64             	cmp    $0x64,%eax
     e6d:	0f 84 0d 01 00 00    	je     f80 <printf+0x180>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e73:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e79:	83 f9 70             	cmp    $0x70,%ecx
     e7c:	74 72                	je     ef0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e7e:	83 f8 73             	cmp    $0x73,%eax
     e81:	0f 84 99 00 00 00    	je     f20 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e87:	83 f8 63             	cmp    $0x63,%eax
     e8a:	0f 84 ff 00 00 00    	je     f8f <printf+0x18f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     e90:	83 f8 25             	cmp    $0x25,%eax
     e93:	0f 84 cf 00 00 00    	je     f68 <printf+0x168>
     e99:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
  write(fd, &c, 1);
     e9e:	83 ec 04             	sub    $0x4,%esp
     ea1:	6a 01                	push   $0x1
     ea3:	8d 44 24 27          	lea    0x27(%esp),%eax
     ea7:	50                   	push   %eax
     ea8:	57                   	push   %edi
     ea9:	e8 33 fe ff ff       	call   ce1 <write>
     eae:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
     eb2:	83 c4 0c             	add    $0xc,%esp
     eb5:	6a 01                	push   $0x1
     eb7:	8d 44 24 26          	lea    0x26(%esp),%eax
     ebb:	50                   	push   %eax
     ebc:	57                   	push   %edi
     ebd:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     ec0:	31 ed                	xor    %ebp,%ebp
  write(fd, &c, 1);
     ec2:	e8 1a fe ff ff       	call   ce1 <write>
  for(i = 0; fmt[i]; i++){
     ec7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     ecb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     ece:	84 db                	test   %bl,%bl
     ed0:	75 89                	jne    e5b <printf+0x5b>
    }
  }
}
     ed2:	83 c4 2c             	add    $0x2c,%esp
     ed5:	5b                   	pop    %ebx
     ed6:	5e                   	pop    %esi
     ed7:	5f                   	pop    %edi
     ed8:	5d                   	pop    %ebp
     ed9:	c3                   	ret    
     eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     ee0:	bd 25 00 00 00       	mov    $0x25,%ebp
     ee5:	e9 66 ff ff ff       	jmp    e50 <printf+0x50>
     eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     ef0:	83 ec 0c             	sub    $0xc,%esp
     ef3:	b9 10 00 00 00       	mov    $0x10,%ecx
     ef8:	6a 00                	push   $0x0
     efa:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
     efe:	89 f8                	mov    %edi,%eax
     f00:	8b 13                	mov    (%ebx),%edx
     f02:	e8 59 fe ff ff       	call   d60 <printint>
        ap++;
     f07:	89 d8                	mov    %ebx,%eax
      state = 0;
     f09:	31 ed                	xor    %ebp,%ebp
        ap++;
     f0b:	83 c0 04             	add    $0x4,%eax
     f0e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     f12:	83 c4 10             	add    $0x10,%esp
     f15:	e9 36 ff ff ff       	jmp    e50 <printf+0x50>
     f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
     f20:	8b 44 24 0c          	mov    0xc(%esp),%eax
     f24:	8b 28                	mov    (%eax),%ebp
        ap++;
     f26:	83 c0 04             	add    $0x4,%eax
     f29:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
     f2d:	85 ed                	test   %ebp,%ebp
     f2f:	74 7d                	je     fae <printf+0x1ae>
        while(*s != 0){
     f31:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
     f35:	84 c0                	test   %al,%al
     f37:	74 25                	je     f5e <printf+0x15e>
     f39:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
     f3d:	8d 76 00             	lea    0x0(%esi),%esi
     f40:	88 44 24 1b          	mov    %al,0x1b(%esp)
  write(fd, &c, 1);
     f44:	83 ec 04             	sub    $0x4,%esp
          s++;
     f47:	83 c5 01             	add    $0x1,%ebp
  write(fd, &c, 1);
     f4a:	6a 01                	push   $0x1
     f4c:	53                   	push   %ebx
     f4d:	57                   	push   %edi
     f4e:	e8 8e fd ff ff       	call   ce1 <write>
        while(*s != 0){
     f53:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
     f57:	83 c4 10             	add    $0x10,%esp
     f5a:	84 c0                	test   %al,%al
     f5c:	75 e2                	jne    f40 <printf+0x140>
      state = 0;
     f5e:	31 ed                	xor    %ebp,%ebp
     f60:	e9 eb fe ff ff       	jmp    e50 <printf+0x50>
     f65:	8d 76 00             	lea    0x0(%esi),%esi
     f68:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
  write(fd, &c, 1);
     f6c:	83 ec 04             	sub    $0x4,%esp
     f6f:	6a 01                	push   $0x1
     f71:	8d 44 24 25          	lea    0x25(%esp),%eax
     f75:	e9 41 ff ff ff       	jmp    ebb <printf+0xbb>
     f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f88:	6a 01                	push   $0x1
     f8a:	e9 6b ff ff ff       	jmp    efa <printf+0xfa>
        putc(fd, *ap);
     f8f:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  write(fd, &c, 1);
     f93:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     f96:	8b 03                	mov    (%ebx),%eax
     f98:	88 44 24 20          	mov    %al,0x20(%esp)
  write(fd, &c, 1);
     f9c:	6a 01                	push   $0x1
     f9e:	8d 44 24 24          	lea    0x24(%esp),%eax
     fa2:	50                   	push   %eax
     fa3:	57                   	push   %edi
     fa4:	e8 38 fd ff ff       	call   ce1 <write>
     fa9:	e9 59 ff ff ff       	jmp    f07 <printf+0x107>
        while(*s != 0){
     fae:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
     fb3:	bd 00 12 00 00       	mov    $0x1200,%ebp
     fb8:	e9 7c ff ff ff       	jmp    f39 <printf+0x139>
     fbd:	66 90                	xchg   %ax,%ax
     fbf:	90                   	nop

00000fc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fc0:	57                   	push   %edi
     fc1:	56                   	push   %esi
     fc2:	53                   	push   %ebx
     fc3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc7:	a1 64 1c 00 00       	mov    0x1c64,%eax
  bp = (Header*) ap - 1;
     fcc:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fcf:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd1:	39 c8                	cmp    %ecx,%eax
     fd3:	73 13                	jae    fe8 <free+0x28>
     fd5:	8d 76 00             	lea    0x0(%esi),%esi
     fd8:	39 d1                	cmp    %edx,%ecx
     fda:	72 14                	jb     ff0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fdc:	39 d0                	cmp    %edx,%eax
     fde:	73 10                	jae    ff0 <free+0x30>
{
     fe0:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fe2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe4:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fe6:	72 f0                	jb     fd8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe8:	39 d0                	cmp    %edx,%eax
     fea:	72 f4                	jb     fe0 <free+0x20>
     fec:	39 d1                	cmp    %edx,%ecx
     fee:	73 f0                	jae    fe0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ff0:	8b 73 fc             	mov    -0x4(%ebx),%esi
     ff3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     ff6:	39 fa                	cmp    %edi,%edx
     ff8:	74 18                	je     1012 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     ffa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     ffd:	8b 50 04             	mov    0x4(%eax),%edx
    1000:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1003:	39 f1                	cmp    %esi,%ecx
    1005:	74 22                	je     1029 <free+0x69>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1007:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1009:	a3 64 1c 00 00       	mov    %eax,0x1c64
}
    100e:	5b                   	pop    %ebx
    100f:	5e                   	pop    %esi
    1010:	5f                   	pop    %edi
    1011:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
    1012:	03 72 04             	add    0x4(%edx),%esi
    1015:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1018:	8b 10                	mov    (%eax),%edx
    101a:	8b 12                	mov    (%edx),%edx
    101c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    101f:	8b 50 04             	mov    0x4(%eax),%edx
    1022:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1025:	39 f1                	cmp    %esi,%ecx
    1027:	75 de                	jne    1007 <free+0x47>
    p->s.size += bp->s.size;
    1029:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    102c:	a3 64 1c 00 00       	mov    %eax,0x1c64
    p->s.size += bp->s.size;
    1031:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1034:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1037:	89 10                	mov    %edx,(%eax)
}
    1039:	5b                   	pop    %ebx
    103a:	5e                   	pop    %esi
    103b:	5f                   	pop    %edi
    103c:	c3                   	ret    
    103d:	8d 76 00             	lea    0x0(%esi),%esi

00001040 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1040:	57                   	push   %edi
    1041:	56                   	push   %esi
    1042:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1043:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
    1047:	8b 15 64 1c 00 00    	mov    0x1c64,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    104d:	8d 78 07             	lea    0x7(%eax),%edi
    1050:	c1 ef 03             	shr    $0x3,%edi
    1053:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1056:	85 d2                	test   %edx,%edx
    1058:	0f 84 90 00 00 00    	je     10ee <malloc+0xae>
    105e:	8b 02                	mov    (%edx),%eax
    1060:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1063:	39 cf                	cmp    %ecx,%edi
    1065:	76 61                	jbe    10c8 <malloc+0x88>
    1067:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    106d:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1072:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1075:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    107c:	eb 0b                	jmp    1089 <malloc+0x49>
    107e:	66 90                	xchg   %ax,%ax
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1080:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1082:	8b 48 04             	mov    0x4(%eax),%ecx
    1085:	39 cf                	cmp    %ecx,%edi
    1087:	76 3f                	jbe    10c8 <malloc+0x88>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
    1089:	39 05 64 1c 00 00    	cmp    %eax,0x1c64
    108f:	89 c2                	mov    %eax,%edx
    1091:	75 ed                	jne    1080 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1093:	83 ec 0c             	sub    $0xc,%esp
    1096:	56                   	push   %esi
    1097:	e8 ad fc ff ff       	call   d49 <sbrk>
  if(p == (char*) -1)
    109c:	83 c4 10             	add    $0x10,%esp
    109f:	83 f8 ff             	cmp    $0xffffffff,%eax
    10a2:	74 1c                	je     10c0 <malloc+0x80>
  hp->s.size = nu;
    10a4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    10a7:	83 ec 0c             	sub    $0xc,%esp
    10aa:	83 c0 08             	add    $0x8,%eax
    10ad:	50                   	push   %eax
    10ae:	e8 0d ff ff ff       	call   fc0 <free>
  return freep;
    10b3:	8b 15 64 1c 00 00    	mov    0x1c64,%edx
      if((p = morecore(nunits)) == 0)
    10b9:	83 c4 10             	add    $0x10,%esp
    10bc:	85 d2                	test   %edx,%edx
    10be:	75 c0                	jne    1080 <malloc+0x40>
        return 0;
    10c0:	31 c0                	xor    %eax,%eax
    10c2:	eb 1c                	jmp    10e0 <malloc+0xa0>
    10c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    10c8:	39 cf                	cmp    %ecx,%edi
    10ca:	74 1c                	je     10e8 <malloc+0xa8>
        p->s.size -= nunits;
    10cc:	29 f9                	sub    %edi,%ecx
    10ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    10d7:	89 15 64 1c 00 00    	mov    %edx,0x1c64
      return (void*) (p + 1);
    10dd:	83 c0 08             	add    $0x8,%eax
  }
}
    10e0:	5b                   	pop    %ebx
    10e1:	5e                   	pop    %esi
    10e2:	5f                   	pop    %edi
    10e3:	c3                   	ret    
    10e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    10e8:	8b 08                	mov    (%eax),%ecx
    10ea:	89 0a                	mov    %ecx,(%edx)
    10ec:	eb e9                	jmp    10d7 <malloc+0x97>
    base.s.ptr = freep = prevp = &base;
    10ee:	c7 05 64 1c 00 00 68 	movl   $0x1c68,0x1c64
    10f5:	1c 00 00 
    10f8:	c7 05 68 1c 00 00 68 	movl   $0x1c68,0x1c68
    10ff:	1c 00 00 
    base.s.size = 0;
    1102:	b8 68 1c 00 00       	mov    $0x1c68,%eax
    1107:	c7 05 6c 1c 00 00 00 	movl   $0x0,0x1c6c
    110e:	00 00 00 
    1111:	e9 51 ff ff ff       	jmp    1067 <malloc+0x27>

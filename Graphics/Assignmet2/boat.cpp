
#include <iostream>
#include <math.h>
#include <cstdlib>
#include <GL/glut.h>
#include <stdlib.h>
 
using namespace std;
 
int WINDOW_WIDTH = 640, WINDOW_HEIGHT = 480;
 
/* GLUT callback Handlers */
 
void SetOrthoForFont()
{
	glMatrixMode(GL_PROJECTION);
	glPushMatrix();
	glLoadIdentity();
	gluOrtho2D(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT);
	glScalef(1, -1, 1);
	glTranslatef(0, -WINDOW_HEIGHT, 0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}
 
void ResetPerspectiveProjection()
{
	glMatrixMode(GL_PROJECTION);
	glPopMatrix();
	glMatrixMode(GL_MODELVIEW);
}
 
void RenderSpacedBitmapString(
							  int x,
							  int y,
							  int spacing,
							  void *font,
							  char *string)
{
	char *c;
	int x1=x;
	for (c=string; *c != '\0'; c++) {
		glRasterPos2i(x1,y);
		glutBitmapCharacter(font, *c);
		x1 = x1 + glutBitmapWidth(font,*c) + spacing;
	}
}
 
void DrawAxes()
{
	//To prevent the view from disturbed on repaint
	//this push matrix call stores the current matrix state
	//and restores it once we are done with the arrow rendering
	glPushMatrix();
		glColor3f(0,0,1);
		glPushMatrix();
			glTranslatef(0,0, 0.8f);
			glutSolidCone(0.0325,0.2, 4,1);
			//Draw label
			glTranslatef(0,0.0625,0.225f);
			RenderSpacedBitmapString(0,0,0,GLUT_BITMAP_HELVETICA_10, "Z");
		glPopMatrix();
		glutSolidCone(0.0225,1, 4,1);
 
		glColor3f(1,0,0);
		glRotatef(90,0,1,0);
		glPushMatrix();
			glTranslatef(0,0,0.8f);
			glutSolidCone(0.0325,0.2, 4,1);
			//Draw label
			glTranslatef(0,0.0625,0.225f);
			RenderSpacedBitmapString(0,0,0,GLUT_BITMAP_HELVETICA_10, "X");
		glPopMatrix();
		glutSolidCone(0.0225,1, 4,1);
 
		glColor3f(0,1,0);
		glRotatef(90,-1,0,0);
		glPushMatrix();
			glTranslatef(0,0, 0.8f);
			glutSolidCone(0.0325,0.2, 4,1);
			//Draw label
			glTranslatef(0,0.0625,0.225f);
			RenderSpacedBitmapString(0,0,0,GLUT_BITMAP_HELVETICA_10, "Y");
		glPopMatrix();
		glutSolidCone(0.0225,1, 4,1);
	glPopMatrix();
}
void DrawGrid(int GRID_SIZE)
{
	glBegin(GL_LINES);
	glColor3f(0.75f, 0.75f, 0.75f);
	for(int i=-GRID_SIZE;i<=GRID_SIZE;i++)
	{
		glVertex3f((float)i,0,(float)-GRID_SIZE);
		glVertex3f((float)i,0,(float)GRID_SIZE);
 
		glVertex3f((float)-GRID_SIZE,0,(float)i);
		glVertex3f((float)GRID_SIZE,0,(float)i);
	}
	glEnd();
}
 
void OnReshape(int nw, int nh) {
	glViewport(0,0,nw, nh);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60, (GLfloat)nw / (GLfloat)nh, 0.1f, 100.0f);
	glMatrixMode(GL_MODELVIEW);
}
 
int oldX = 0, oldY = 0, rX = 15, rY = 0, state = 0, dist = -10;
 
float mx = 0;
float my = 0;
float mz = 0;
float direction = 0;
float speed = 0;
 
static void display(void)
{
 
    const double t = glutGet(GLUT_ELAPSED_TIME) / 1000.0;
    const double ztm = t*+0.1;
    float radians = direction * 3.141592653 / 180;
    float xPos = sin(radians) * speed;
    float zPos = cos(radians) * speed;
    float dmx = xPos*ztm;
    float dmz = zPos*ztm;
    float nmx = dmx+xPos;
    float nmz = dmz+zPos;
 
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(-dmx,(-5+dmz)/4,dist-dmz);
	glRotatef(rX,1,0,0);
	glRotatef(rY,0,1,0);
 
	DrawAxes();
	DrawGrid(1000);
 
	glEnable(GL_LIGHTING);
 
    glColor3f(1,0,0);
 
    glPushMatrix();
    glPushMatrix();
        glScaled(1,0.5,1);
        glTranslated(mx,my,mz);
        glRotatef(direction,0,1,0);
        glutSolidCube(1);
    glPushMatrix();
        glScaled(1,1,2);
        glTranslated(0,0,-2.25);
        glutSolidCube(1);
    glPopMatrix();
    glPushMatrix();
        glScaled(1,1,2);
        glTranslated(0,0,2.25);
        glutSolidCube(1);
    glPopMatrix();
    glPushMatrix();
        glScaled(2,1,2);
        glTranslated(0,0,-1.25);
        glutSolidCube(1);
    glPopMatrix();
    glPushMatrix();
        glScaled(2,1,2);
        glTranslated(0,0,1.25);
        glutSolidCube(1);
    glPopMatrix();
    glPushMatrix();
        glScaled(3,1,3);
        glTranslated(0,0,0);
        glutSolidCube(1);
    glPopMatrix();
    glPopMatrix();
    glPopMatrix();
 
    float markerz = -3, markerorigin = 0;
    for (markerz;markerz<=3;markerz++) {
    glPushMatrix();
        glScaled(1.0,20.0,1.0);
        glTranslated(5,0,markerorigin+markerz*3);
        glRotated(ztm*90,0,1,0);
        glutSolidCube(1);
    glPopMatrix();
 
    glPushMatrix();
        glScaled(1.0,20.0,1.0);
        glTranslated(-5,0,markerorigin+markerz*3);
        glRotated(ztm*90,0,1,0);
        glutSolidCube(1);
    glPopMatrix();
    }
 
    glDisable(GL_LIGHTING);
 
    SetOrthoForFont();
	ResetPerspectiveProjection();
    glutSwapBuffers();
}
 
static void key(unsigned char key, int x, int y)
{
    if (key=='b')
    {
    //mx=mx+xPos;
    //mz=mz+zPos;
    } else if(key=='p') {
    direction=direction+.2;
    } else if (key=='o') {
    direction=direction-.2;
    } else if (key=='l') {
    direction=direction+2;
    } else if (key=='k') {
    direction=direction-2;
    } else if (key=='m') {
    speed=speed+.2;
    } else if (key=='n') {
    speed=speed-.2;
    } else if (key=='q') {
    mx=mx+1;
    } else if (key=='w') {
    mx=mx-1;
    } else {
    speed=0;
    }
 
    glutPostRedisplay();
}
 
void Mouse(int button, int s, int x, int y)
{
	if (s == GLUT_DOWN)
	{
		oldX = x;
		oldY = y;
	}
 
	if(button == GLUT_MIDDLE_BUTTON)
		state = 0;
	else
		state = 1;
}
 
void Motion(int x, int y)
{
	if (state == 0)
		dist *= (1 + (y - oldY)/60.0f);
	else
	{
		rY += (x - oldX)/5.0f;
		rX += (y - oldY)/5.0f;
	}
	oldX = x;
	oldY = y;
 
	glutPostRedisplay();
}
 
static void idle(void)
{
    glutPostRedisplay();
}
 
const GLfloat light_ambient[]  = { 0.0f, 0.0f, 0.0f, 1.0f };
const GLfloat light_diffuse[]  = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat light_position[] = { 2.0f, 5.0f, 5.0f, 0.0f };
 
const GLfloat mat_ambient[]    = { 0.7f, 0.7f, 0.7f, 1.0f };
const GLfloat mat_diffuse[]    = { 0.8f, 0.8f, 0.8f, 1.0f };
const GLfloat mat_specular[]   = { 1.0f, 1.0f, 1.0f, 1.0f };
const GLfloat high_shininess[] = { 100.0f };
 
/* Program entry point */
 
int main(int argc, char *argv[])
{
    glutInit(&amp;argc, argv);
    glutInitWindowSize(WINDOW_WIDTH,WINDOW_HEIGHT);
    glutInitWindowPosition(10,10);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
 
    glutCreateWindow("GLUT Shapes");
 
 
    glutDisplayFunc(display);
    glutIdleFunc(idle);
    glutReshapeFunc(OnReshape);
    glutMouseFunc(Mouse);
	glutMotionFunc(Motion);
	glutKeyboardFunc(key);
 
    glClearColor(0,0,0,1);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
 
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
 
    glEnable(GL_LIGHT0);
    glEnable(GL_NORMALIZE);
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_LIGHTING);
 
    glLightfv(GL_LIGHT0, GL_AMBIENT,  light_ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE,  light_diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_specular);
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
 
    glMaterialfv(GL_FRONT, GL_AMBIENT,   mat_ambient);
    glMaterialfv(GL_FRONT, GL_DIFFUSE,   mat_diffuse);
    glMaterialfv(GL_FRONT, GL_SPECULAR,  mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, high_shininess);
 
    glutMainLoop();
 
    return EXIT_SUCCESS;
}

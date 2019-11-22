#include <stdio.h> 
#include <stdlib.h>

struct node{
	struct node* left;
	struct node* right;
	int key;
	int h;
};

int max(int a,int b)
{
	return a>b?a:b;
}

int height(struct node* a)
{
	if(a==NULL)
		return 0;
	else 
		return a->h;
}

struct node* clock(struct node* root) 
{
	struct node* child=root->left;
	struct node* subtree=root->left->right;

	root->left=subtree;
	child->right=root;


	root->h=max(height(root->left),height(root->right))+1;
	child->h=max(height(child->left),height(child->right))+1;


	return child;
}


struct node* aclock(struct node* root) 
{
	struct node* child=root->right;
	struct node* subtree=root->right->left;

	root->right=subtree;
	child->left=root;

	root->h=max(height(root->left),height(root->right))+1;
	child->h=max(height(child->left),height(child->right))+1;

	return child;
}


void print(struct node* root)
{
	if(root==NULL)
		return;

	print(root->left);

	printf("val::%d heigh:%d\n",root->key,height(root));

	print(root->right);

}


//insert
struct node* insert(struct node* root,int t)
{

	if(root==NULL)
	{
		struct node* newnode=(struct node*)malloc(sizeof(struct node));
		newnode->right=NULL;
		newnode->left=NULL;
		newnode->key=t;
		newnode->h=1;
		return root=newnode;
	}


	if(root->key >= t)
		root->left=insert(root->left,t);
	
	else if(root->key < t)
		root->right=insert(root->right,t);

	// printf("check root:%d\n",root->key);
	// print(root->left);
	// print(root->right);

	// printf("\n");

	if(height(root->left) > height(root->right) + 1)
		{

			if(height(root->left->left) < height(root->left->right))
				root->left=aclock(root->left);

				root=clock(root);
		}

	else if(height(root->right) > height(root->left) + 1)
		{
			if(height(root->right->right) < height(root->right->left))
				root->right=clock(root->right);

				root=aclock(root);
		}

	root->h=max(height(root->left),height(root->right))+1;
	// printf("height::%d\n",root->h);
	
	return root;

}

struct node* delnode(struct node* root,struct node* head)
{
	if(root->left==NULL)
	{
		head->key=root->key;
	
	
		if(root->right!=NULL)
			return root->right;
		else
			return NULL;
	}

	root->left=delnode(root->left,head);

	if(height(root->left) > height(root->right) + 1)
		{

			if(height(root->left->left) < height(root->left->right))
				root->left=aclock(root->left);

				root=clock(root);
		}

	else if(height(root->right) > height(root->left) + 1)
		{
			if(height(root->right->right) < height(root->right->left))
				root->right=clock(root->right);

				root=aclock(root);
		}

	root->h=max(height(root->left),height(root->right))+1;
	// printf("height::%d\n",root->h);
	


	return root;

}

struct node* del(struct node* root,int val)
{
	if(root==NULL)
		{printf("Nothing to delete\n");return root;}
 
	if(root->key > val)
		root->left=del(root->left,val);
	else if(root->key < val)
		root->right=del(root->right,val);
	
	else
	{
		printf("here\n");
		if(root->left==NULL&&root->right==NULL)
			return root=NULL;
		
		else if(root->left==NULL)
			root=root->right;

		else if(root->right==NULL)
			root=root->left;
		else
			root=delnode(root,root);

	}



	if(height(root->left) > height(root->right) + 1)
		{

			if(height(root->left->left) < height(root->left->right))
				root->left=aclock(root->left);

				root=clock(root);
		}

	else if(height(root->right) > height(root->left) + 1)
		{
			if(height(root->right->right) < height(root->right->left))
				root->right=clock(root->right);

				root=aclock(root);
		}

	root->h=max(height(root->left),height(root->right))+1;
	// printf("height::%d\n",root->h);
	
	return root;

}


//search

int main()
{
struct node* head = NULL;


	int t=0;
	while(t!=-1)
	{
		scanf("%d",&t);
		
		if(t==-1)
			break;

		head=insert(head,t);
	
		print(head);

	}

	t=0;
	while(t!=-1)
	{
		scanf("%d",&t);
		
		if(t==-1)
			break;

		head=del(head,t);
	
		print(head);

	}



	return 0;
}

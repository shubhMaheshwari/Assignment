#include "BPlusTree.cpp"

#define Ie(a, b) if (a == b)

using namespace std;

int main(int argc, char *argv[])
{
	node *root;
	root = (node *)malloc(sizeof(node));
	root->isleaf = 1;
	root->nextleaf = NULL;

	char *temp = argv[1];
	ifstream fin(temp);
	// ofstream fout("out.txt");
	root = insert(-1000000007, root);
	root = balance_root(root);

	int c = 0;
	while (1)
	{
		Ie(c, 1000) break;
		string a;
		int b;
		fin >> a >> b;
		c++;
		Ie(a[0], 'I')
		{
			root = insert(b, root);
			root = balance_root(root); // see if root needs balancing
		}
		Ie(a[0], 'F')
		{
			node *ans = find(b, root);
			if (ans != NULL)
				cout << "YES" << endl;
			else
				cout << "NO" << endl;
		}
		Ie(a[0], 'R')
		{
			int c;
			fin >> c;
			int ans = range(b, c, root);
			cout << ans << endl;
		}
		Ie(a[0], 'C')
		{
			int ans = range(b, b, root);
			cout << ans << endl;
		}

		if (fin.eof())
			break;
	}
}
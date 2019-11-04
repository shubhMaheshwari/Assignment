#include <bits/stdc++.h>

#define Il(a, b) if (a < b)
#define Ig(a, b) if (a > b)
#define Ile(a, b) if (a <= b)
#define Ige(a, b) if (a >= b)
#define Ie(a, b) if (a == b)
#define EIl(a, b) else if (a < b)
#define EIg(a, b) else if (a > b)
#define EIle(a, b) else if (a <= b)
#define EIge(a, b) else if (a >= b)
#define EIe(a, b) else if (a == b)
#define E else
#define Wl(a, b) while (a < b)
#define Wle(a, b) while (a <= b)
#define Wg(a, b) while (a > b)
#define Wge(a, b) while (a >= b)
#define We(a, b) while (a == b)
#define Wne(a, b) while (a != b)
#define pb push_back
#define rs resize
#define p(a, b) a->b

using namespace std;
typedef long long int lli;

lli treeparam = 2;

typedef struct node
{
  bool isleaf;
  vector<lli> keys;
  vector<struct node *> pointers;
  struct node *nextleaf;
} node;

node *balance_root(node *root) // breaking of root at end if necessary, two children
{
  Ile(root->keys.size(), treeparam) return root;

  node *temp = new node;

  node *newroot = new node;
  newroot->isleaf = 0;
  newroot->nextleaf = NULL;

  Ie(root->isleaf, 1) // while breaking if root is a leaf, splitting will be different as no keys will be removed from a leaf.
  {
    p(temp, isleaf) = 1;
    p(temp, nextleaf) = root->nextleaf;
    p(root, nextleaf) = temp;

    for (lli i = treeparam / 2; i < root->keys.size(); i += 1)
      temp->keys.pb(root->keys[i]);

    Wl(temp->pointers.size(), temp->keys.size() + 1)
        temp->pointers.pb(NULL);

    p(root, keys).rs(treeparam / 2);
    p(root, pointers).rs(root->keys.size() + 1);

    p(newroot, keys).pb(temp->keys[0]);
    p(newroot, pointers).pb(root);
    p(newroot, pointers).pb(temp);
  }
  E // splittign a normal node as a root, central key up and two children.
  {
    p(temp, isleaf) = 0;
    p(temp, nextleaf) = NULL;

    for (lli i = treeparam / 2 + 1; i < root->keys.size(); i += 1)
      temp->keys.pb(root->keys[i]);

    for (lli i = treeparam / 2 + 1; i < root->pointers.size(); i += 1)
      temp->pointers.pb(root->pointers[i]);

    p(newroot, keys).pb(root->keys[treeparam / 2]);
    p(root, keys).rs(treeparam / 2);
    p(root, pointers).rs(root->keys.size() + 1);

    p(newroot, pointers).pb(root);
    p(newroot, pointers).pb(temp);
  }

  return newroot;
}

node *insert_key_pointer(node *root, lli val, node *poi)
{
  vector<lli> newkeys;
  vector<node *> newpointers;

  lli i = 0;
  for (i = 0; i < root->keys.size(); i += 1)
  {
    Il(root->keys[i], val)
        newkeys.pb(root->keys[i]);
    else break;
  }

  lli j = 0;
  Wne(newpointers.size(), newkeys.size() + 1)
  {
    newpointers.pb(root->pointers[j]);
    j += 1;
  }

  newkeys.pb(val);
  newpointers.pb(poi);

  Wl(i, root->keys.size())
  {
    newkeys.pb(root->keys[i]);
    newpointers.pb(root->pointers[i + 1]);
    i += 1;
  }

  p(root, keys).clear();
  p(root, keys) = newkeys;

  p(root, pointers).clear();
  p(root, pointers) = newpointers;

  return root;
}

node *balance(node *root)
{

  vector<node *> pointers = root->pointers;

  node *tobebalan = NULL;

  for (lli i = 0; i < pointers.size(); i += 1)
  {
    Ig(pointers[i]->keys.size(), treeparam)
    {
      tobebalan = pointers[i];
      break;
    }
  }

  Ie(tobebalan, NULL) return root;

  node *temp = new node;
  p(temp, isleaf) = tobebalan->isleaf;
  p(temp, nextleaf) = NULL;
  p(temp, keys).clear();

  vector<lli> oldkeys = tobebalan->keys;
  vector<node *> oldpointers = tobebalan->pointers;

  Ie(tobebalan->isleaf, 1)
  {
    for (lli i = treeparam / 2; i < oldkeys.size(); i += 1)
    {
      temp->keys.pb(oldkeys[i]);
    }

    Wl(temp->pointers.size(), temp->keys.size() + 1)
        temp->pointers.pb(NULL);

    p(temp, nextleaf) = tobebalan->nextleaf;
    p(tobebalan, nextleaf) = temp;

    p(tobebalan, keys).rs(treeparam / 2);
    p(tobebalan, pointers).rs(treeparam / 2 + 1);

    root = insert_key_pointer(root, temp->keys[0], temp);
  }

  E
  {

    for (lli i = treeparam / 2 + 1; i < oldkeys.size(); i += 1)
      temp->keys.pb(oldkeys[i]);

    tobebalan->keys.rs(treeparam / 2);

    for (lli i = treeparam / 2 + 1; i < oldpointers.size(); i += 1)
      p(temp, pointers).pb(oldpointers[i]);

    p(tobebalan, pointers).rs(tobebalan->keys.size() + 1);

    root = insert_key_pointer(root, oldkeys[treeparam / 2], temp);
  }

  return root;
}

node *insert(lli val, node *root)
{
  Ie(root->isleaf, 1) // if leaf insert and return
  {

    root->keys.pb(val);
    sort(root->keys.begin(), root->keys.end());
    Wl(root->pointers.size(), root->keys.size() + 1)
        root->pointers.pb(NULL);

    return root;
  }

  for (lli i = 0; i < root->keys.size(); i += 1) // going to right child
  {
    Il(val, root->keys[i])
    {
      insert(val, root->pointers[i]);
      break;
    }
  }

  Ige(val, p(root, keys[root->keys.size() - 1])) // else go to right most pointer.
  {
    insert(val, p(root, pointers[root->pointers.size() - 1]));
  }
  // while recursing back check if the intermediate nodes satisfy the  B+ tree criteria .

  root = balance(root);

  return root;
}

node *find(lli val, node *root)
{
  Ie(root->isleaf, 1)
  {
    for (lli i = 0; i < root->keys.size(); i += 1)
      Ie(root->keys[i], val) return root;

    return NULL;
  }

  vector<node *> pointers = root->pointers;
  vector<lli> keys = root->keys;

  for (lli i = 0; i < keys.size(); i += 1)
  {
    Il(val, keys[i])
    {
      return find(val, pointers[i]);
      break;
    }
  }
  Ige(val, keys[keys.size() - 1]) return find(val, pointers[pointers.size() - 1]);

  return NULL;
}

lli range(lli a, lli b, node *root)
{

  node *temp = root;
  lli fans = 0;
  We(temp->isleaf, 0)
      temp = temp->pointers[0];

  Wne(temp, NULL)
  {
    lli las = temp->keys[temp->keys.size() - 1];
    lli fir = temp->keys[0];

    Il(las, a)
    {
      temp = temp->nextleaf;
      continue;
    }
    EIg(fir, b) break;
    else if (fir >= a && las <= b)
    {
      fans += temp->keys.size();
      temp = temp->nextleaf;
    }
    else
    {
      for (lli i = 0; i < temp->keys.size(); i += 1)
        if (temp->keys[i] >= a && temp->keys[i] <= b)
          fans += 1;
      temp = temp->nextleaf;
    }
  }
  return fans;
}

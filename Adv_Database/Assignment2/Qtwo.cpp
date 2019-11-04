#include "LinearHashing.cpp"

using namespace std;

unsigned long hashFunction(unsigned long value, const int &key)
{
    return (key & ((1 << (value + 1)) - 1));
}

int main(int argc, char *argv[])
{
    string filename = argv[1];
    int M = atoi(argv[2]);
    int B = atoi(argv[3]);

    printf("M:%d\n",M );

    ifstream inputFile;
    inputFile.open(filename);
    int num;

    Hash<int> h(B / 4, hashFunction);
    while (inputFile >> num)
    {
        if (!h.Find(num))
        {
            cout << num << endl;
            h.Insert(num);
        }
    }
    return 0;
}
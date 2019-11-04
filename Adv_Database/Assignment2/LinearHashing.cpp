#ifndef __LHASHING__
#define __LHASHING__

#include <bits/stdc++.h>

using namespace std;

template <typename T>
class Block
{
	int capacity;
	vector<T> data;
	Block *next;

  public:
	Block(int capacity) : capacity(capacity), data(), next(nullptr) {}

	bool isOverflow() const
	{
		if (next != nullptr)
		{
			return true;
		}
		return false;
	}

	bool Find(const T &key) const
	{
		for (T possibleKey : data)
		{
			if (possibleKey == key)
			{
				return true;
			}
		}
		if (next != nullptr)
		{
			return next->Find(key);
		}
		return false;
	}

	bool Insert(const T &key)
	{
		if (data.size() < capacity)
		{
			data.push_back(key);
			return false;
		}
		if (next == nullptr)
		{
			next = new Block<T>(capacity);
		}
		next->Insert(key);
		return true;
	}

	bool Empty() const
	{
		return data.empty();
	}

	unsigned long getHash(function<unsigned long(const T &)> HF) const
	{
		return HF(data[0]);
	}

#define RT pair<Block<T> *, Block<T> *>

	RT Split(function<unsigned long(const T &)> HF)
	{
		RT splited;

		if (next != nullptr)
		{
			splited = next->Split(HF);
			delete next;
			next = nullptr;
		}
		else
		{
			splited = RT(new Block<T>(capacity), new Block<T>(capacity));
		}

		for (T key : data)
		{
			unsigned long hash = HF(key);
			if (splited.first->data.empty() && !splited.second->data.empty())
			{
				if (hash == HF(splited.second->data[0]))
					splited.second->Insert(key);
				else
					splited.first->Insert(key);
			}
			else if (splited.first->data.empty() && splited.second->data.empty())
			{
				splited.first->Insert(key);
			}
			else
			{
				if (hash != HF(splited.first->data[0]))
					splited.second->Insert(key);
				else
					splited.first->Insert(key);
			}
		}
		return splited;
	}
};

template <typename T>
class Hash
{
	int capacity;
	vector<Block<T> *> blocks;
	int current, currentHash;
	const function<unsigned long(unsigned long, const T &)> HF;

  public:
	Hash(unsigned long capacity, function<unsigned long(unsigned long, const T &)> HF) : capacity(capacity), blocks({new Block<T>(capacity), new Block<T>(capacity)}),
																						 current(0), currentHash(0), HF(HF) {}

	void Insert(const T &key)
	{
		unsigned long hash = HF(currentHash, key);
		if (hash < current)
			hash = HF(currentHash + 1, key);
		bool overFlow = blocks[hash]->Insert(key);

		auto splitLambda = [this](const T &key) {
			return HF(currentHash + 1, key);
		};

		if (overFlow)
		{
			pair<Block<T> *, Block<T> *> splited = blocks[current]->Split(splitLambda);
			if ((!splited.first->Empty() && splited.first->getHash(splitLambda) != current) ||
				(!splited.second->Empty() && splited.second->getHash(splitLambda) == current))
				std::swap(splited.first, splited.second);

			delete blocks[current];
			blocks[current] = splited.first;
			blocks.push_back(splited.second);
			current++;

			if (0.75 * blocks.size() == current)
			{
				current = 0;
				currentHash++;
			}
		}
	}

	bool Find(const T &key) const
	{
		unsigned long hash = HF(currentHash, key);
		if (hash < current)
		{
			hash = HF(currentHash + 1, key);
		}
		return blocks[hash]->Find(key);
	}
};

#endif
#include "rb.h"
using ptr = RedBlackTree::ptr;

RedBlackTree::RedBlackTree() {}

const ptr RedBlackTree::getRoot() const
{
	return root;
}

ptr RedBlackTree::insert(int data)
{
	ptr newnodePtr = new node(data);
	if (!root)
	{
		root = newnodePtr;
		root->color = 0; // set root color as black
		return newnodePtr;
	}
	insert(root, newnodePtr);
	return newnodePtr;
}

// auxiliary function to perform RBT insertion of a node
// you may assume start is not nullptr
void RedBlackTree::insert(ptr start, ptr newnodePtr)
{
	// choose direction
	ptr y = NULL;
	ptr x = root;
	while (x != NULL)
	{
		y = x;
		if (newnodePtr->data > x->data)
			x = x->right;
		else
			x = x->left;
	}
	newnodePtr->parent = y;
	if (y == NULL)
		root = newnodePtr;
	else if (y->data > newnodePtr->data)
		y->left = newnodePtr;
	else
		y->right = newnodePtr;
	newnodePtr->color = 1;
	newnodePtr->left = NULL;
	newnodePtr->right = NULL;
	fixup(newnodePtr);
	// recurse down the tree
}

// Credits to Adrian Schneider
void RedBlackTree::printRBT(ptr start, const std::string &prefix, bool isLeftChild) const
{
	if (!start)
		return;

	std::cout << prefix;
	std::cout << (isLeftChild ? "|--" : "|__");
	// print the value of the node
	std::cout << start->data << "(" << start->color << ")" << std::endl;
	// enter the next tree level - left and right branch
	printRBT(start->left, prefix + (isLeftChild ? "│   " : "    "), true);
	printRBT(start->right, prefix + (isLeftChild ? "│   " : "    "), false);
}

// Function performing right rotation
// of the passed node
void RedBlackTree::rightrotate(ptr loc)
{
	ptr x = loc->left;
	loc->left = x->right;
	if (x->right != NULL)
		x->right->parent = loc;
	x->parent = loc->parent;
	if (loc->parent == NULL)
		root = x;
	else if (loc->parent->left == loc)
		loc->parent->left = x;
	else
		loc->parent->right = x;

	x->right = loc;
	loc->parent = x;
}

// Function performing left rotation
// of the passed node
void RedBlackTree::leftrotate(ptr loc)
{
	ptr y = loc->right;
	loc->right = y->left;
	if (y->left != NULL)
		y->left->parent = loc;
	y->parent = loc->parent;
	if (loc->parent == NULL)
		root = y;
	else if (loc == loc->parent->left)
		loc->parent->left = y;
	else
		loc->parent->right = y;
	y->left = loc;
	loc->parent = y;
}

// This function fixes violations
// caused by RBT insertion
void RedBlackTree::fixup(ptr loc)
{
	while (loc->parent!=NULL && loc->parent->color == 1)
	{
		if (loc->parent->parent != NULL)
		{
			if (loc->parent == loc->parent->parent->left)//to find uncle we ahe to check for parent 
			{
				ptr uncle = loc->parent->parent->right;
				if (uncle!=NULL&&uncle->color == 1)//case 1: uncle is red then od only recoloring and initialise z to ite grandparent
				{
					uncle->color = 0;
					loc->parent->color = 0;
					loc->parent->parent->color = 1;
					loc = loc->parent->parent;
				}
				else
                {
                    if (loc == loc->parent->right)    // Case 2: loc is right child
                    {
                        loc = loc->parent;
                        leftrotate(loc);             // Left rotate at parent
                    }
                    // Case 3: loc is left child
                    loc->parent->color = 0;          // Parent becomes black
                    loc->parent->parent->color = 1;  // Grandparent becomes red
                    rightrotate(loc->parent->parent); // Right rotate at grandparent
                }
			}
			else
			{
				ptr uncle = loc->parent->parent->left;
				if (uncle!=NULL && uncle->color == 1)
				{
					uncle->color = 0;
					loc->parent->color = 0;
					loc->parent->parent->color = 1;
					loc = loc->parent->parent;
				}
				else
                {
                    if (loc == loc->parent->left)     // Case 2: loc is left child
                    {
                        loc = loc->parent;
                        rightrotate(loc);            // Right rotate at parent
                    }
                    // Case 3: loc is right child
                    loc->parent->color = 0;          // Parent becomes black
                    loc->parent->parent->color = 1;  // Grandparent becomes red
                    leftrotate(loc->parent->parent);  // Left rotate at grandparent
                }
			}
		}
		else break;
	}
	root->color = 0;
}

// Function to print inorder traversal
// of the fixated tree
void RedBlackTree::inorder(ptr start) const
{
	if (!start)
		return;

	inorder(start->left);
	std::cout << start->data << " ";
	inorder(start->right);
}

// driver code
int main()
{
	int n;
	std ::cin >> n;
	assert(n < 10000 && n >= 0);
	int a[10000];
	RedBlackTree tree;

	for (int i = 0; i < n; i++)
	{
		std::cin >> a[i];

		// allocating memory to the node and initializing:
		// 1. color as red
		// 2. parent, left and right pointers as NULL
		// 3. data as i-th value in the array

		// calling function that performs rbt insertion of
		// this newly created node
		auto newnodePtr = tree.insert(a[i]);

		// calling function to preserve properties of rb
		// tree
		tree.fixup(newnodePtr);
	}
	tree.printRBT(tree.getRoot());

	return 0;
}

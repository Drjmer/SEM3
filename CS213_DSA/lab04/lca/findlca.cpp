#include "tree.h"

// Function which returns lca node of given nodes 'a' and 'b'
TreeNode* ans(TreeNode* root,int n1,int n2){
  if(root==NULL) return root;

  if(root->key==n1||root->key==n2) return root;

  TreeNode* left=ans(root->left,n1,n2);
  TreeNode* right=ans(root->right,n1,n2);

  if(left!= NULL&&right!=NULL) return root;
  else if(left!=NULL&&right==NULL) return left;
  else if(left==NULL&&right!=NULL) return right;

  else return NULL;
}
TreeNode* TREE::findlca(TreeNode* a, TreeNode* b) {
    
  // dummy return
  if(a==NULL||b==NULL) return NULL;
  return ans(root,a->key,b->key);
}
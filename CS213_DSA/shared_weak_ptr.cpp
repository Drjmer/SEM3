#include<bits/stdc++.h>
using namespace std;
class Node
{
public:
    Node(int value) : value(value) { std ::cout << " Node " << value << " created ." << std ::endl; }
    // Functions to set/ get the next node / weak ref to previous node / shared ref to previous node
    void setNext(std ::shared_ptr<Node> next) { nextNode = next; }
    void setWeakPrev(std ::shared_ptr<Node> next) { prevWeakNode = next; }
    void setPrev(std ::shared_ptr<Node> next) { prevNode = next; }
    std ::shared_ptr<Node> getNext() const { return nextNode; }
    std ::shared_ptr<Node> getPrev() const { return prevNode; }
    std ::shared_ptr<Node> getWeakPrev() const { return prevWeakNode.lock(); }
    // Function to display the value of the node
    void display() const { std ::cout << " Node value : " << value << std ::endl; }
    ~Node(){cout<<"Destruc"<<endl;}
private:
    int value;
    std ::shared_ptr<Node> nextNode;
    std ::shared_ptr<Node> prevNode;
    std ::weak_ptr<Node> prevWeakNode;
};
void print_list(std ::weak_ptr<Node> current)
{
    for (int i = 0; i < 5; ++i)
    {
        auto current_ref = current.lock();
        if (current_ref)
        {
            current_ref->display();
            current = current_ref->getNext();
        }
        else
        {
            std ::cout << " Next node is nullptr ." << std ::endl;
            break;
        }
    }
}

//creting doubly linked list
std ::weak_ptr<Node> shared_test()
{
    auto node1 = std ::make_shared<Node>(1);
    auto node2 = std ::make_shared<Node>(2);
    auto node3 = std ::make_shared<Node>(3);
    // Create a circular reference
    node1 -> setNext(node2);
    node2 -> setNext(node3);
    node2 -> setPrev(node1); // shared pointer pointing to previous node is causing a reference cycle
    node3 -> setPrev(node2);
    cout<<node1.use_count()<<endl; //2-->number of references as both are shared pointer 
    return node1;
}
std ::weak_ptr<Node> weak_test()
{
    auto node1 = std ::make_shared<Node>(1);
    auto node2 = std ::make_shared<Node>(2);
    auto node3 = std ::make_shared<Node>(3);
    node1 -> setNext(node2);
    node2 -> setNext(node3);
    node2 -> setWeakPrev(node1); // weak pointer pointing to previous node breaks cyclic reference counting
    node3 -> setWeakPrev(node2);
    cout<<node1.use_count()<<endl; //1
    return node1;
}
int main()
{
    std ::cout << " Testing shared pointer :" << std ::endl;
    auto current = shared_test();
    print_list(current);
    std ::cout << " Testing weak pointer :" << std ::endl;
    auto current1 = weak_test();
    print_list(current1);
    return 0;
}
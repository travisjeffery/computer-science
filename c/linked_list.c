#include <stdlib.h>
#include <stdbool.h>

typedef struct node {
  void *next;
  void *prev;
  int val;
} node;

node *head = NULL;
node *curr = NULL;

node *create_list(int val) {
  node *ptr = (node *)calloc(1, sizeof(node));
  
  if (NULL == ptr)
    return NULL;
  
  ptr->val = val;
  ptr->next = NULL;
  ptr->prev = NULL;
  
  head = curr = ptr;
  
  return head;
}

node *add_to_list(int val, bool add_to_end) {
  if (NULL == head)
    return create_list(val);
  
  node *ptr = (node *)calloc(1, sizeof(node));
  
  if (NULL == ptr)
    return NULL;
  
  ptr->val = val;
  ptr->next = NULL;
  ptr->prev = NULL;
  
  if (add_to_end) {
    curr->next = ptr;
    ptr->prev = curr;    
  } else {
    ptr->next = head;
    head->prev = ptr;
    head = ptr;    
  }
  
  return ptr;
}

node *search_list(int val, node **prev) {
  node *ptr = head;
  node *tmp = NULL;
  bool found = false;
  
  while (ptr != NULL) {
    if (ptr->val == val) {
      found = true;
      break;
    }
    
    tmp = ptr;
    ptr = ptr->next;      
  }
  
  if (found == true) {
    if (prev) 
      *prev = tmp;
    return ptr;
  }
  
  return NULL;
}

void delete_item(int val) {
  node *prev = NULL;
  node *ptr = search_list(val, &prev);
  
  if (ptr == NULL)
    return;
  
  if (prev != NULL) {
    node *next = ptr->next;
    prev->next = next;
    next->prev = prev;    
  }
    
  if (ptr == curr)
    curr = prev;
  else 
    head = ptr->next;  
  
  free(ptr);
  ptr = NULL;
}

void print_list() {
  node *ptr = head;
  
  while (ptr->next) {
    printf("%d\n", ptr->val);
    ptr = ptr->next;
  }
}

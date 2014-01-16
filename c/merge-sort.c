void topdownmerge(int a[], int ibegin, int imiddle, int iend, int b[]) {
  int i0 = ibegin, i1 = imiddle;  
  for (int j = ibegin; j < iend; j++) {
    if (i0 < imiddle && (i1 >= iend || a[i0] <= a[i1]))
      b[j] = a[i0++];
    else
      b[j] = a[i1++];
  }
}

void copyarray(int b[], int ibegin, int iend, int a[]) {
  for (int k = ibegin; k < iend; k++)
    a[k] = b[k];
}

void topdownsplitmerge(int a[], int ibegin, int iend, int b[]) {
  if (iend - ibegin < 2)
    return;
  int imiddle = (iend + ibegin) / 2;
  topdownsplitmerge(a, ibegin, imiddle, b);
  topdownsplitmerge(a, imiddle, iend, b);
  topdownmerge(a, ibegin, imiddle, iend, b);
  copyarray(b, ibegin, iend, a);  
}

void topdownmergesort(int a[], int b[], int n) {
  topdownsplitmerge(a, 0, n, b);
}
#ifndef INCLUDED_SIGN
#define INCLUDED_SIGN

template <typename T>
int sign(T val) {
  return (T(0) < val) - (val < T(0));
}

#endif

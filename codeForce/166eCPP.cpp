#include <iostream>
#define ll long long
#define MOD_NUM ((long long) 1000000007)

using namespace std;

int main() {
  int n;
  cin >> n;
  if (n <= 1) {
    cout << 0 << endl;
    return 0;
  } 
  ll c = 3, nds = 0;
  for (int i = 3; i <= n; i++) {
    c %= MOD_NUM;
    nds %= MOD_NUM;
    nds = (c - nds);
    c *= 3;
  }
  if (nds > c)
    c += MOD_NUM;
  cout << (c-nds) % MOD_NUM << endl;
  return 0;
}
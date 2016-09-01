/*
 * =====================================================================================
 *
 *       Filename:  main.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  08/22/2016 00:25:14
 *       Compiler:  g++
 *
 *         Author:  Sabastian (liuxueyang.github.io), read3valprintloop@gmail.com
 *
 * =====================================================================================
 */
#include <bits/stdc++.h>
using namespace std;
#define _ ios_base::sync_with_stdio(0);cin.tie(0);
#define rep(i, a, n) for (int i = a; i < n; ++i)
#define per(i, a, n) for (int i = n-1; i >= a; --i)
#define pb push_back
#define mp make_pair
#define all(x) (x).begin(),(x).end()
#define fi first
#define se second
#define SZ(x) ((int)(x).size())
typedef vector<int> VI;
typedef map<int,int> MI;
typedef long long ll;
typedef pair<int,int> PII;
const ll MOD=1000000007;
int a[3010],b[3010],n;
vector<PII> c;

int main ( void )
{
#ifndef  ONLINE_JUDGE
  freopen("input.txt", "r", stdin);
#endif     /* -----  ONLINE_JUDGE  ----- */

  while(cin>>n){
    memset(a,0,sizeof(a));
    memset(b,0,sizeof(b));
    c.clear();
    rep(i,0,n){
      cin>>a[i];
      b[i]=a[i];
    }
    sort(b,b+n);

    rep(i,0,n){
      if(b[i]!=a[i]){
        rep(j,i,n){
          if(b[i]==a[j]){
            swap(a[j],a[i]);
            c.push_back(mp(i,j));
            break;
          }
        }
      }
    }
    int len=SZ(c);
    cout<<len<<endl;
    rep(i,0,len){
      cout<<c[i].first<<' '<<c[i].second<<endl;
    }

  }

  return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */


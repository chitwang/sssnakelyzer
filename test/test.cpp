#include <bits/stdc++.h>
using namespace std;

// int main()
// {
//     // std::cout<<"Hello World";
//     vector<int> v = {1,2,3,4};
//     for(auto it = v.begin();it!= v.end();++it){
//         if(*it == 2){
//             v.insert(it, 6);
//             break;
//         }
//     }
//     for(auto it:v) cout<<it<<" ";
//     return 0;
// }
int main() {
    std::vector<int> v = {1, 2, 3, 4};
    std::vector<int> new_v;

    for(auto it = v.begin(); it != v.end(); ++it) {
        if(*it == 2 || *it == 3 || *it == 4) {
            new_v.push_back(6);
        }
        new_v.push_back(*it);
    }

    v = new_v;  // Copy new_v back to v

    for(auto it : v) {
        std::cout << it << " ";
    }

    // return 0;
}
#include <iostream>
#include <Eigen/Core>
using namespace std;

int main(){
    int N_q = 10;
    int d = 3;
    Eigen::MatrixXd query_point = Eigen::MatrixXd::Random(N_q, d);
    cout << query_point <<endl;

    cout << query_point.cwiseAbs() <<endl;

    cout << query_point.cwiseAbs().maxCoeff() <<endl;

    cout << 2.0*(query_point.cwiseAbs().maxCoeff() < 1) - 1.0 <<endl;
    return 0;
}

//g++ -std=c++11 -I /usr/include/eigen3/ test_EigenFunction.cpp -o test

#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;

int main(int argc, char** argv )
{
    Mat image;
    image = imread("../car.jpg", IMREAD_COLOR);

    if ( !image.data )
    {
        std::cout << "No image data \n";
        return -1;
    }

    namedWindow("Display Image", WINDOW_AUTOSIZE );
    imshow("Display Image", image);

    waitKey(0);
    return 0;
}

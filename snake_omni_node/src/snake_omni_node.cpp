#include <snake_omni/snake_omni.hpp>

int main(int argc, char** argv) {

    ros::init(argc, argv, "snake_omni_node");
    ros::NodeHandle nh;

    snake_omni snakeOmni(nh);

    ros::Rate r(100);

    while(nh.ok()) {

        snakeOmni.control();
        r.sleep();
        ros::spinOnce();
    }

    //ros::spin();

    return 0;
}
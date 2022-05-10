#include <snake_omni/snake_omni.hpp>

snake_omni::snake_omni(ros::NodeHandle& nh) : nh(nh) {
    //subscriber
    sub_omni_pose = nh.subscribe("/Geomagic/pose", 10, &snake_omni::omniPoseCallback, this);
    //teleop = nh.subscribe("/Geomagic/button", 10, $snake_omni::omniButtonCallback, this)

            //publisher
    pub_snake_bend = nh.advertise<std_msgs::Float32>("/motor_bend/move_jp", 10);
    pub_snake_roll = nh.advertise<std_msgs::Float32>("/motor_roll/move_jp", 10);

}

snake_omni::~snake_omni() {}

void snake_omni::omniPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {

    //std::cout << "omni callback" << std::endl; 
    omni_pose = msg->pose;

}

/*
void snake_omni::omniButtonCallback(const std_msgs::Float64MultiArray::ConstPtr& msg) {

   buttons.data[1] = msg.data[1;
   buttons.data[2] = msg.data[2];

}

*/
void snake_omni::control() {
    while(buttons.data[1] == 1){
        float bend = omni_pose.position.x*0.002;
        float roll = (omni_pose.position.y+40)*-0.00075;

        limitOutput(bend, roll);

        std_msgs::Float32 bend_msg, roll_msg;
        bend_msg.data = bend;
        roll_msg.data = roll;

        //pub_snake_bend.publish(bend_msg);
        pub_snake_roll.publish(roll_msg);

    }
}

void snake_omni::limitOutput(float& x, float& y) {

    if(x>0.1) x = 0.1;
    else if(x<-0.1) x = -0.1;

    if(y>0.03) y =0.03;
    else if(y<-0.03) y = -0.03;
    

}
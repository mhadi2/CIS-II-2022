#include <ros/ros.h>

#include <geometry_msgs/PoseStamped.h>
#include <std_msgs/Float32.h>

class snake_omni {

private:

    ros::NodeHandle nh;

    ros::Subscriber sub_omni_pose;
   // ros::Subcriber teleop;
    ros::Publisher pub_snake_roll;
    ros::Publisher pub_snake_bend;

    geometry_msgs::Pose omni_pose;
   // geomagic_control::DeviceButtonEvent buttons;
   std_msgs::Float64MultiArray buttons;

public:

    snake_omni( ros::NodeHandle& nh);
    ~snake_omni();

    void omniPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
    //void omniBUttonCallback( const geomagic_control::DeviceButtonEvent::ConstPtr& msg)
    void limitOutput(float& x, float& y);
    void control();



};

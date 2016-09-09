/* This code is a modfication of code provided in ROS tutorial 
"Using urdf with robot_state_publisher" at
http://wiki.ros.org/urdf/Tutorials/Using%20urdf%20with%20robot_state_publisher#Launch_File

Modified by Anna Safonov (anna.safonov@uoit.net) to fit Yeti Clarm arm

06-Jul-2016

*/


#include <string>
#include <ros/ros.h>
#include <sensor_msgs/JointState.h>
#include <tf/transform_broadcaster.h>

int main(int argc, char** argv) {
    ros::init(argc, argv, "state_publisher");
    ros::NodeHandle n;
    ros::Publisher joint_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
    tf::TransformBroadcaster broadcaster;
    ros::Rate loop_rate(30);

    const double degree = M_PI/180;

    // robot state
    double inc= 0.005;
    double angle= 0,base = 0, rvrs = 0, gripper = 0, tip = 0;

    // message declarations
    geometry_msgs::TransformStamped odom_trans;
    sensor_msgs::JointState joint_state;
    odom_trans.header.frame_id = "odom";
    odom_trans.child_frame_id = "base_link";

while (ros::ok()) {
        //update joint_state
        joint_state.header.stamp = ros::Time::now();

        joint_state.name.resize(11);
        joint_state.position.resize(11);

        joint_state.name[0] ="shoulder_pan_joint";
        joint_state.position[0] = base;

        joint_state.name[1] ="shoulder_pitch_joint";
        joint_state.position[1] = rvrs;

        joint_state.name[2] ="elbow_pitch_joint";
        joint_state.position[2] = rvrs;

        joint_state.name[3] ="elbow_roll_joint";
        joint_state.position[3] = base;

	    joint_state.name[4] ="wrist_pitch_joint";
        joint_state.position[4] = base;

	    joint_state.name[5] ="wrist_roll_joint";
        joint_state.position[5] = base;

	    joint_state.name[6] ="gripper_base_joint";
        joint_state.position[6] = gripper;

	    joint_state.name[7] ="gripper_joint";
        joint_state.position[7] = tip;

	    joint_state.name[8] ="gripper2_joint";
        joint_state.position[8] = tip;


        // update transform
        // with 0 translation and rotation, the arm and the odom overlap axis
        //arm is static
        odom_trans.header.stamp = ros::Time::now();
        odom_trans.transform.translation.x = 0.0;
        odom_trans.transform.translation.y = 0.0;
        odom_trans.transform.translation.z = 0.0;
        odom_trans.transform.rotation = tf::createQuaternionMsgFromYaw(angle);

        //send the joint state and transform
        joint_pub.publish(joint_state);
        broadcaster.sendTransform(odom_trans);

        // Create new robot state
        base += inc;
        if (base < -1.5 || base > 1.5) inc*= -1;

        //elbow_pitch and shoulder_pitch need a separate variable 
        //bcz they have opposite restrictions on their movement 
        //(gear mechanism for shoulder & bracket specifics for elbow)
        rvrs -= inc;
        if (rvrs < -1.5 || rvrs > 1.5) inc*= -1;

        gripper += inc;
        if (gripper < 0 || gripper > 1) inc*= -1;
		
        //angle += degree/4; this is used to make the object move in a certain way wrt odom

        // This will adjust as needed per iteration
        loop_rate.sleep();
    }


    return 0;
}

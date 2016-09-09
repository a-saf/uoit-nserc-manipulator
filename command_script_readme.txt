To run urdf in Gazebo: 
uncomment world link, uncomment inertial tag for base_link

roslaunch gazebo_ros empty_world.launch

in a separate terminal: 
rosrun gazebo_ros spawn_model -file catkin_ws/src/clarm_description/urdf/clarm.urdf -urdf -x 0 -y 0 -z 0 -model clarm



To run urdf in Rviz with GUI: 
comment out world link - but works fine with it, so not necessary
roslaunch urdf_tutorial display.launch model:=catkin_ws/src/clarm_description/urdf/clarm.urdf gui:=True



To run urdf in Moveit: 
comment out inertial tag for base_link

roslaunch clarm_moveit_config demo.launch



To run Robot_state_publisher for urdf in Rviz:
roslaunch clarm_state_publisher clarm_state_publisher.launch
rosrun rviz rviz
Add Robot model and TF 

check tf: rosrun tf view_frames
			evince frames.pdf


To run ArbotiX Control package:

sudo chmod 777 /dev/ttyUSB0

arbotix_terminal
ls //check that all servos are recognized

In a new terminal:
roslaunch clarm_arbotix_control clarm_arbotix.launch

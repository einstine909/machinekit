from PIL.ImImagePlugin import MODE
from PIL.ImageChops import offset
from wx import TOOL_BOTTOM
cdef extern from "posemath.h":
	struct PmCartesian:
		double x, y, z

cdef extern from "emcpos.h":
	struct EmcPose:
		PmCartesian tran
		double a, b, c, u, v, w

cdef from "cannon_position.hh"
	struct CANNON_POSITION:
		double x, y, z, a, b, c, u, v, w
		
cdef extern from "emctool.h":
	struct CANON_TOOL_TABLE:
		int toolno, orientation
		EmcPose offset
		double diameter, frontangle, backangle
     	
cdef extern from "emc_nml.hh":
	cdef cppclass EMC_TRAJ_LINEAR_MOVE:
		EMC_TRAJ_LINEAR_MOVE()
		double vel, ini_maxvel, acc
		EmcPose end
		int type, feed_mode, indexrotery
		
	cdef cppclass EMC_TRAJ_RIGID_TAP:
		EMC_TRAJ_RIGID_TAP()
		EmcPose pos
		double vel, ini_maxvel, acc
		
	cdef cppclass EMC_TRAJ_PROBE:
		EMC_TRAJ_PROBE()
		EmcPose pos
		int type
		double vel, ini_maxvel, acc
		unsigned char probe_type
		
	cdef cppclass EMC_TRAJ_SET_TERM_COND:
		EMC_TRAJ_SET_TERM_COND()
		int cond
		double tolerance
		
	cdef cppclass EMC_TRAJ_SET_SPINDLESYNC:
		EMC_TRAJ_SET_SPINDLESYNC()
		double feed_per_revolution
		bool velocity_mode
		
	cdef cppclass EMC_TRAJ_CIRCULAR_MOVE:
		EMC_TRAJ_CIRCULAR_MOVE()
		EmcPose end
		PM_CARTESIAN center, normal
		int turn, type, feed_mode
		double vel, ini_maxvel, acc

	cdef cppclass EMC_TRAJ_DELAY:
		EMC_TRAJ_DELAY()
		double delay
		
	cdef cppclass EMC_SPINDLE_ON:
		EMC_SPINDLE_ON()
		double speed, factor, xoffset

	cdef cppclass EMC_SPINDLE_SPEED:
		EMC_SPINDLE_SPEED()
		double speed, factor, xoffset

	cdef cppclass EMC_SPINDLE_OFF:
		EMC_SPINDLE_OFF()

	cdef cppclass EMC_SPINDLE_ORIENT:
		EMC_SPINDLE_ORIENT()
		double orientation
		int mode

	cdef cppclass EMC_SPINDLE_WAIT_ORIENT_COMPLETE:
		EMC_SPINDLE_WAIT_ORIENT_COMPLETE()
		double timeout
		
	cdef cppclass EMC_TOOL_SET_OFFSET:
		EMC_TOOL_SET_OFFSET()
		int pocket, toolno, orientation
		EmcPose offset
		double diameter, frontangle, backangle
		
	cdef cppclass EMC_TRAJ_SET_OFFSET:
		EMC_TRAJ_SET_OFFSET()
		EmcPose offset

	cdef cppclass EMC_TOOL_LOAD:
		EMC_TOOL_LOAD()
		
	cdef cppclass EMC_TOOL_PREPARE:
		EMC_TOOL_PREPARE()
		int pocket, tool
		
	cdef cppclass EMC_TOOL_SET_NUMBER:
		EMC_TOOL_SET_NUMBER()
		int tool
		
	cdef cppclass EMC_TRAJ_SET_FO_ENABLE:
		EMC_TRAJ_SET_FO_ENABLE()
		unsigned char mode
		
	cdef cppclass EMC_MOTION_ADAPTIVE:
		EMC_MOTION_ADAPTIVE()
		unsigned char status
		
	cdef cppclass EMC_TRAJ_SET_SO_ENABLE:
		EMC_TRAJ_SET_SO_ENABLE()
		unsigned char mode
	
	cdef cppclass EMC_TRAJ_SET_FH_ENABLE:
		EMC_TRAJ_SET_FH_ENABLE()
		unsigned char mode
		
	cdef cppclass EMC_COOLANT_FLOOD_OFF:
		EMC_COOLANT_FLOOD_OFF()
		
	cdef cppclass EMC_COOLANT_FLOOD_ON:
		EMC_COOLANT_FLOOD_ON()
		
	cdef cppclass EMC_OPERATOR_DISPLAY:
		EMC_OPERATOR_DISPLAY()
		int id
		char display[LINELEN]
		
	cdef cppclass EMC_COOLANT_MIST_OFF:
		EMC_COOLANT_MIST_OFF()
		
	cdef cppclass EMC_COOLANT_MIST_ON:
		EMC_COOLANT_MIST_ON()
		
	cdef cppclass EMC_TRAJ_CLEAR_PROBE_TRIPPED_FLAG:
		EMC_TRAJ_CLEAR_PROBE_TRIPPED_FLAG()
		
	cdef cppclass EMC_TASK_PLAN_PAUSE:
		EMC_TASK_PLAN_PAUSE()
		
	cdef cppclass EMC_TASK_PLAN_OPTIONAL_STOP:
		EMC_TASK_PLAN_OPTIONAL_STOP()
		
	cdef cppclass EMC_TASK_PLAN_END:
		EMC_TASK_PLAN_END()
		
	cdef cppclass EMC_OPERATOR_ERROR:
		EMC_OPERATOR_ERROR()
		int id
		char error[LINELEN]
	
	cdef cppclass EMC_MOTION_SET_DOUT:
		EMC_MOTION_SET_DOUT()
		unsigned char index, start, end, now
		 
	cdef cppclass EMC_MOTION_SET_AOUT:
		EMC_MOTION_SET_AOUT()
		unsigned char index, now
		double start, end
		
	cdef cppclass EMC_AUX_INPUT_WAIT:
		EMC_AUX_INPUT_WAIT()
		int index, input_type, wait_type
		double timeout
		
	cdef cppclass EMC_EXEC_PLUGIN_CALL:
		EMC_EXEC_PLUGIN_CALL()
		int len
		char call[900]
		
	cdef cppclass EMC_IO_PLUGIN_CALL:
		EMC_IO_PLUGIN_CALL()
		int len
		char call[900]

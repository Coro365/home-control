require 'serialport'

def instance()
	@serial_port = File.read("./serial_port")
	@serial_bps = 9600
	
	begin
		sp = SerialPort.new(@serial_port,@serial_bps)
	rescue Exception => e
		print("Error: \n1. USB is not connected\n2. Wrong file(serial_port)\n")
		exit(3)
	end
	
	return sp

end

def serialSend(sp,commend)
	sp.write(commend)

end
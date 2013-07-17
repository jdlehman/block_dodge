GCpauseBut = gideros.class(Bitmap);
 
function GCpauseBut:init()
	
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self);
end
 
function GCpauseBut:addAllListeners(sprite)
	local numChild = sprite:getNumChildren();
	if numChild ~= 0 then
		for i = 1, numChild do
			local child = sprite:getChildAt(i)
			local subNumChild = child:getNumChildren();
			if subNumChild ~= 0 then
				if child.addListeners then
					child:addListeners();
				end
				self:addAllListeners(child);
			else
				if child.addListeners then
					child:addListeners();
				end
			end
		end
	else
		if sprite.addListeners then
			sprite:addListeners();
		end
	end
end
 
function GCpauseBut:removeAllListeners(sprite)
	local numChild = sprite:getNumChildren();
	if numChild ~= 0 then
		for i = 1, numChild do
			local child = sprite:getChildAt(i)
			local subNumChild = child:getNumChildren();
			if subNumChild ~= 0 then
				if child.removeListeners then
					child:removeListeners();
				end
				self:removeAllListeners(child);
			else
				if child.removeListeners then
					child:removeListeners();
				end
			end
		end
	else
		if sprite.removeListeners then
			sprite:removeListeners();
		end
	end
end
 
function GCpauseBut:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		if self.paused then
			print("unpause")
			self.paused = false;
			self:addAllListeners(stage);
		else
			print("pause")
			self.paused = true;
			self:removeAllListeners(stage);
		end
		event:stopPropagation();
	end
end
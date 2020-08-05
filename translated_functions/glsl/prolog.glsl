
struct Object{
	int type;
    int int1;
    float float1;
    bool bool1;    
};
    


    Object new(){
        Object self;
    	self.type = 0;
        return self;
    }
    
    Object new(int int1){
    	Object self;
        self.int1 = int1;
        self.type = 1;
        return self;
    }
    Object new(float float1){
    	Object new;
        new.float1 = float1;
        new.type = 1;
        return new;
    }
    Object new(bool bool1){
    	Object self;
        self.bool1 = bool1;
        self.type = 2;
        return self;
    }

bool var(Object self){
	return self.type == 0;
}
bool nonvar(Object self){
	return !var(self);
}

main = print ((1::Object) + (2::Object))

data Object = Int

class Python a where
    (+) :: a -> a -> a

instance Python Object where
	(+) a b = (a::Object) + (b::Object)

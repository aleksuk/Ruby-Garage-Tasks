class Fubric

    def initialize(*args)
        @@keys = args
    end

    def new(*values)

        return Class.new do

            def initialize(keys, *values)
                @@param = []

                keys.each do |key|
                    @@param << key

                    singleton_class.class_eval do
                        attr_accessor key
                    end
                end

                @@param.each_index do |index|
                    self[index] = values[0][index]
                end
            end

            def [](key)
                self.method(get_method_name(key, false)).call
            end

            def []=(key, value)
                self.method(get_method_name(key, true)).call value
            end

            private

            def get_method_name(key, isAssignment)
                method_name = if key.is_a?(Fixnum)
                    @@param[key].to_s
                elsif key.is_a?(Symbol)
                    key.to_s
                elsif key.is_a?(String)
                    key
                end

                method_name = (isAssignment) ? (method_name + '=').to_sym : method_name.to_sym
            end

        end.new(@@keys, values)
    end
end

temp_obj = Fubric.new(:a, :b)
result = temp_obj.new(1, 2)

p result.a
p result[0]
p result[:a]
p result['a']

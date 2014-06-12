class Fabric

    def initialize(*args)
        @@keys = args
    end

    def self.new(*keys, &block)
        Class.new do

            @@keys = keys

            def initialize(*values)
                @param = []

                @@keys.each do |key|
                    @param << key

                    singleton_class.class_eval do
                        attr_accessor key
                    end
                end

                values.each_index do |index|
                    self[index] = values[index]
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
                    @param[key].to_s
                elsif key.is_a?(Symbol)
                    key.to_s
                elsif key.is_a?(String)
                    key
                end

                method_name = (isAssignment) ? (method_name + '=').to_sym : method_name.to_sym
            end

            public block.call if block
        end
    end
end

new_type = Fabric.new(:a, :b) do
    def hello_a
        "hello #{a}"
    end
end

new_obj = new_type.new(1, 2)
p new_obj.a
p new_obj[0]
p new_obj[1]
p new_obj[:a] = 5
p new_obj['a']
p new_obj.hello_a

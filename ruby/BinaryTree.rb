module BinaryTree
  class Node
    attr_accessor :left, :right, :data

    def initialize left=nil, right=nil, data
      @left = left
      @right = right
      @data = data
    end

    def to_s
      "#{@data}"
    end
  end

  class BinarySearchTree
    attr_accessor :root

    def initialize root=nil
      @root = root
    end

    def add data
      node = Node.new data

      if @root.nil?
        @root = node
      else
        current = @root

        while true
          if data < current.data
            if current.left.nil?
              current.left = node
              break
            else
              current = current.left
            end
          elsif data > current.data
            if current.right.nil?
              current.right = node
              break
            else
              current = current.right
            end
          else
            break
          end
        end
      end
    end

    def contains data
      found = false
      current = @root

      while not found and current
        if data < current.data
          current = current.left
        elsif data > current.data
          current = current.right
        else
          found = true
        end
      end

      found
    end

    def remove data
      found = false
      parent = null
      current = @root

      while not found and not current.nil?
        if data < current.data
          parent = current
          current = current.left
        elsif data > current.data
          parent = current
          current = current.right
        else
          found = true
        end
      end

      if found
        child_count = (!current.left.nil? ? 1 : 0) + (!current.right.nil? ? 1 : 0)

        if current.eql? @root
          case child_count
          when 0
            @root = nil
          when 1
            @root = current.right.nil? ? current.left : current.right
          when 2
            replacement = @root.left
            until replacement.right.nil?
              replacement_parent = replacement
              replacement = replacement.right
            end

            if !replacement_parent.nil?
              replacement_parent.right = replacement.left
              replacement.right = @root.right
              replacement.left = @root.left
            else
              replacement.right = @root.right
            end

            @root = replacement
          end
        else
          case child_count
          when 0
            if current.data < parent.data
              parent.left = nil
            else
              parent.right = nil
            end
          when 1
            if current.data < parent.data
              parent.left = current.left.nil? ? current.right : current.left
            else
              parent.right = current.left.nil? ? current.right : current.left
            end
          when 2
            replacement = current.left
            replacement_parent = current
            while !replacement.right.nil?
              replacement_parent = replacement
              replacement = replacement.right
            end
            replacement_parent.right = replacement.left
            replacement.right = current.right
            replacement.left = current.left
            if current.data < parent.data
              parent.left = replacement
            else
              parent.right = replacement
            end
          end
        end
      end
    end

    def size
      length = 1
      self.traverse @root, Proc.new {length += 1}
      length
    end

    def to_a
      result = []
      self.traverse @root, Proc.new {|node| result << node}
      result
    end

    def to_s
      self.to_a.to_s
    end

    def traverse node, b
      in_order = Proc.new do |node|
        if !node.left.nil?
          in_order.call node.left
        end

        b.call node

        if !node.right.nil?
          in_order.call node.right
        end
      end

      return if root.nil?
      in_order.call node
    end
  end
end
require "pry"

# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value, next_node = nil)
    @data = value
    @next = next_node
  end
end


# Defines the singly linked list
class LinkedList
    def initialize
      @head = nil # keep the head private. Not accessible outside this class
    end

    # method to add a new node with the specific data value in the linked list
    # insert the new node at the beginning of the linked list
    # Time Complexity: O(1), since insertion at the head doesn't require traversal of the linked list
    # Space Complexity O(1), space required will always be the size of 1 node
    def add_first(value)
      new_node = Node.new(value, @head)
      @head = new_node
    end

    # method to find if the linked list contains a node with specified value
    # returns true if found, false otherwise
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor)
    def search(value)
      cursor = @head
      while cursor
        return true if cursor.data == value
        cursor = cursor.next
      end
      return false
    end

    # method to return the max value in the linked list
    # returns the data value and not the node
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor), and 1 int (max)
    def find_max
      return nil if !@head
      cursor = @head
      max = cursor.data
      while cursor
        if cursor.data > max
          max = cursor.data
        end
        cursor = cursor.next
      end
      return max
    end

    # method to return the min value in the linked list
    # returns the data value and not the node
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor), and 1 int (min)
    def find_min
      return nil if !@head
      cursor = @head
      min = cursor.data
      while cursor
        if cursor.data < min
          min = cursor.data
        end
        cursor = cursor.next
      end
      return min
    end


    # method that returns the length of the singly linked list
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor), and 1 int (length)
    def length
      length = 0
      if !@head
        return length
      else
        cursor = @head
        while cursor
          length += 1
          cursor = cursor.next
        end
      end
      return length
    end

    # method that returns the value at a given index in the linked list
    # index count starts at 0
    # returns nil if there are fewer nodes in the linked list than the index value
   # Time Complexity:  O(n) where n is the index at which to retrieve the value
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor)
    def get_at_index(index)
      return nil unless @head
      return nil if index < 0
      cursor = @head
      index.times do
        return nil unless cursor.next
        cursor = cursor.next
      end
      return cursor.data
    end

    # method to print all the values in the linked list
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor)
    def visit
      cursor = @head
      while cursor
        puts cursor.data
      end
    end

    # method to delete the first node found with specified value
   # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor)
    def delete(value)
      return nil if !@head
      if @head.data == value
        @head = @head.next 
        return nil
      end 
      cursor = @head
      while cursor.next && cursor.next.data != value
        cursor = cursor.next
      end
        cursor.next = cursor.next.next if cursor.next
    end

    # method to reverse the singly linked list
    # note: the nodes should be moved and not just the values in the nodes
    # Time Complexity: O(n) , n for traversing length of list
    # Space Complexity: O(1)
    def reverse
      prev = nil
      cursor = @head
      while cursor do
          temp = cursor.next
          cursor.next = prev 
          prev = cursor
          cursor = temp   
      end
      @head = prev
    end

    ## Advanced Exercises
    # returns the value at the middle element in the singly linked list
    # Time Complexity:  O(n)
    # Space Complexity O(1), both length and get_at_idex are also O(1)
    def find_middle_value
      middle_index = self.length/2
      return get_at_index(middle_index)
    end

    # find the nth node from the end and return its value
    # assume indexing starts at 0 while counting to n
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor), and 2 int (index, list_length)
    def find_nth_from_end(n)
      list_length = self.length
      return nil if n > list_length - 1 || n < 0
      index = 1
      cursor = @head
      until (list_length - index) == n || !cursor.next
        index +=1
        cursor = cursor.next
      end
      return cursor.data
    end

    # checks if the linked list has a cycle. A cycle exists if any node in the
    # linked list links to a node already visited.
    # returns true if a cycle is found, false otherwise.
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1) size of 2 nodes (slow_p and fast_p)
    # slow/fast pointer approach adapted from https://www.geeksforgeeks.org/detect-loop-in-a-linked-list/
    def has_cycle
      slow_p = @head 
      fast_p = @head 
      while slow_p && fast_p && fast_p.next
        slow_p = slow_p.next
        fast_p = fast_p.next.next
        return true if slow_p == fast_p
      end
      return false
    end


    # Additional Exercises 
    # returns the value in the first node
    # returns nil if the list is empty
    # Time Complexity: O(1), not dependent on length
    # Space Complexity O(1), no new variables created
    def get_first
      return @head ? @head.data : nil
    end

    # method that inserts a given value as a new last node in the linked list
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 2 nodes (cursor, and new_node)
    def add_last(value)
      new_node = Node.new(value)
      if !@head
        @head = new_node
      else
        cursor = @head
        while cursor.next
          cursor = cursor.next
        end
        cursor.next = new_node
      end
    end

    # method that returns the value of the last node in the linked list
    # returns nil if the linked list is empty
    # Time Complexity: O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 1 node (cursor)
    def get_last
      return nil unless @head
      cursor = @head
      while cursor.next
        cursor = cursor.next
      end
    return cursor.data
    end

    # method to insert a new node with specific data value, assuming the linked
    # list is sorted in ascending order
    # Time Complexity:  O(n) where n is the length of the linked list
    # Space Complexity O(1),  space required will always be the size of 2 nodes (cursor, and new_node)
    def insert_ascending(value)
      new_node = Node.new(value)
      cursor = @head
      until !cursor.next || cursor.next.data >= value
        cursor = cursor.next
      end
      new_node.next = cursor.next
      cursor.next = new_node
    end

    # Helper method for tests
    # Creates a cycle in the linked list for testing purposes
    # Assumes the linked list has at least one node
    def create_cycle
      return if @head == nil # don't do anything if the linked list is empty

      # navigate to last node
      cursor = @head
      while cursor.next != nil
          cursor = cursor.next
      end

      cursor.next = @head # make the last node link to first node
    end
end

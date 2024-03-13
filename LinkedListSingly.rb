#Linked list object, element in a linked list. I copied this from my midterm.
#Do not delete the first item in a linked list, I don't know what garbage collection will do with the rest...
#Class by Henry Fleischer
class LinkedListNode
    def initialize(indata, inNextItem)
        @data = indata
        @nextItem = inNextItem
    end

    attr_accessor :data
    attr_accessor :nextItem
    #Returns data contained in item
    #Leftover from original assignment
    def printData
        puts @data
    end

    #Returns the next item
    # def nextItem
    #   @nextItem
    # end

    #Returns the whole list after this item
    def getList
        if @nextItem.nil?
            "Data: #{@data}"
        else
            "Data: #{@data}, next item: \n#{@nextItem.getList}"
        end
    end

    #Returns this item's information
    def to_s
        "#{@data}"
    end

    #Add an item to the end of the list
    def AddLast(data)
        if @nextItem.nil?
            newItem = LinkedListNode.new(data, nil)
            @nextItem = newItem
        else
            @nextItem.AddLast(data)
        end
    end

    #Add an item to the start of the list
    def AddFirst(data)
        currentItem = LinkedListNode.new(@data, @nextItem)
        newItem = LinkedListNode.new(data, currentItem)
        @data = data
        @nextItem = currentItem
    end

    #Remove an item from the end of the list
    def RemoveLast(previous)
        if @nextItem.nil? #Check if we're at the end of the list
            if previous.nil? #Check if we're also at the start of the list. If we are, we can't delete the current item.
                return false
            end
            previous.nextItem = nil
        else
            @nextItem.RemoveLast(self)
        end
        true
    end

    #Remove an item from the start of the list
    def RemoveFirst
        if @nextItem.nil?
            return false
        else
            @data = @nextItem.data
            @nextItem = @nextItem.nextItem
            true
        end
    end

    #Removes all items in a list after the current one, starting with the last one, then clears the current item's data and next item.
    def Clear
        listLong = true
        while listLong == true
            listLong = self.RemoveLast(nil)
        end
        @data = nil
    end

    #Returns true if the list contains the provided object.
    def Contains(item)
        if @nextItem.nil?
            return false
        else
            if @data == item
                return true
            end
        end
        @nextItem.Contains(item)
    end

    #Returns the number of items in the list, after and including the current one
    def Count
        self.CountInside + 1
    end

    #Returns the number of items in the list, after but not including the current one
    def CountInside
        count = 1
        if @nextItem.nil?
            return 0
        else
            count += @nextItem.CountInside
            return count
        end
    end

    #Gets the item at the specified location
    def GetItemAt (index)
        if index == 0
            return self
        elsif nextItem.nil?
            puts "Error, index out of range!"
            return nil
        elsif true
            @nextItem.GetItemAt(index - 1)
        end
    end
    #Returns the last item in the list
    def GetLast
        if @nextItem.nil?
            return self
        else
            return self.nextItem.GetLast
        end
    end

    #Adds an item after a specific location
    def AddAfter(index, data)
        if self.Count < index   #If trying to add an item after the end of the list, add it to the end of the list instead.
            AddLast(data)
        elsif index <= 0
            AddFirst(data)
        else
            #Add item to the middle of the list.
            mainItemLocal = GetItemAt(index)
            offsetItemLocal = mainItemLocal.nextItem
            newItem = LinkedListNode.new(data,offsetItemLocal)
            #offsetItemLocal.prevItem = newItem
            mainItemLocal.nextItem = newItem
        end
    end
    def RemoveItem (data, prevItem)
        #puts "A"
        if self.data == data
            prevItem.nextItem = nextItem
        elsif !nextItem.nil?
            nextItem.RemoveItem(data,self)
        end
    end
    def RemoveAtIndex(index, prevItem)
        if index == 0
            prevItem.nextItem = nextItem
        else
            @head.nextItem.RemoveAtIndex(index - 1, @head)
        end
    end
end


class LinkedList
    def initialize (data)
        @tail = LinkedListNode.new("End of list",nil)
        @head = LinkedListNode.new(data,@tail)
    end
    attr_accessor :head
    attr_accessor :tail
    def Count
        @head.Count
    end
    def Add(data)
        @head.AddLast(data)
        @tail = @head.GetLast
    end
    def Display
        puts @head.getList()
    end
    def FindAt(index)
        @head.GetItemAt(index)
    end
    def RemoveItem (dataIn)
        if @head.data == dataIn
            #puts "Removed first item, for some reason. Why?"
            @head = @head.nextItem
        else
            #puts "Called next"
            @head.nextItem.RemoveItem(dataIn,@head)
        end
    end
    def RemoveAtIndex   (index)
        if index == 0
            @head = @head.nextItem
        else
            @head.nextItem.RemoveAtIndex(index - 1, @head)
        end
    end
    def Clear
        @head.Clear()
    end
end

if __FILE__ == $0

ll = LinkedList.new("Test")
10.times{
    ll.Add(Random.rand(100..999))
}
ll.head.AddAfter(3,"This is a test item")
ll.head.AddAfter(3,"A")
ll.RemoveItem("A")
ll.RemoveAtIndex(1)
ll.Display()
end

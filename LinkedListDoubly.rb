#Doubly linked list
#Copied from mid-term as-is
#Class by Henry Fleischer
class LinkedListDoubly
    def initialize(indata, inNextItem = nil, inPrevItem = nil)
        @data = indata
        @nextItem = inNextItem
        @prevItem = inPrevItem
    end

    attr_accessor :data
    attr_accessor :nextItem
    attr_accessor :prevItem

    #Print this item's information
    def to_s
        "#{@data}"
    end

    #Returns the whole list after this item
    def getList
        if @nextItem.nil?
            "Data: #{@data}"
        else
            "Data: #{@data}, prev data: #{@prevItem} next item: \n#{@nextItem.getList}"
        end
    end

        #Returns a number of items after the current one
    def getSome numItems
        if @nextItem.nil? || numItems <= 0
            "Data: #{@data}"
        else
            "Data: #{@data}, prev data: #{@prevItem} next item: \n#{@nextItem.getSome(numItems - 1)}"
        end
    end

    #Add an item to the end of the list
    def AddLast(data)
        if @nextItem.nil?
            newItem = LinkedListDoubly.new(data, nil, self)
            @nextItem = newItem
        else
            @nextItem.AddLast(data)
        end
    end

    #Add an item to the start of the list
    def AddFirst(data)
        currentItem = nil

        currentItem = LinkedListDoubly.new(@data, @nextItem)
        @nextItem.prevItem = currentItem
        newItem = LinkedListDoubly.new(data, currentItem)
        currentItem.prevItem = newItem
        @data = data
        @nextItem = currentItem
    end

    #Remove an item from the end of the list
    def RemoveLast
        if @nextItem.nil? #Check if we're at the end of the list
            if self.prevItem.nil? #Check if we're also at the start of the list. If we are, we can't delete the current item.
                return false
            end
            self.prevItem.nextItem = nil  #We're removing the connection between this item and the previous one, which is why this looks so strange. We can't set self to nil from inside of self. self should get picked up by garbage collection eventually, assuming it's not being referenced elsewhere.
            self.prevItem = nil
        else
            @nextItem.RemoveLast()
        end
        true
    end
    #Remove an item from the start of the list
    def RemoveFirst
        if @nextItem.nil?
            return false
        else
            #Set own item's properties
            @data = @nextItem.data
            @nextItem = @nextItem.nextItem
            @prevItem = nil
            #Finish removing item from list
            # @nextItem.prevItem = self
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

    #Returns true if the list contains the provided object. Use on first item in list.
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

    #Adds an item before a specific location
    def AddBefore(index, data)
        if index <= 0
            AddFirst(data)
        else
            #Add item to the middle of the list.
            mainItemLocal = GetItemAt(index)
            offsetItemLocal = mainItemLocal.prevItem
            if offsetItemLocal.nil?
                AddFirst(data)
            end
            newItem = LinkedListDoubly.new(data,mainItemLocal,offsetItemLocal)
            offsetItemLocal.nextItem = newItem
            mainItemLocal.prevItem = newItem
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
            newItem = LinkedListDoubly.new(data,offsetItemLocal,mainItemLocal)
            offsetItemLocal.prevItem = newItem
            mainItemLocal.nextItem = newItem
        end
    end


    #Finds the first instance of an item containing the specified object
    def Find(item, index = 0)
        #First, check if current item is what we're looking for
        if self.data == item
            return index
        end
        #If it's not, check the next item
        if !@nextItem.nil?
        @nextItem.Find(item, index + 1)
        # else
        #     nil
        end
    end
end

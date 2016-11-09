require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

files = {:merchants => "../data/merchants.csv",
        :items => "../data/items.csv",
        :invoices => "../data/invoices.csv",
        :invoice_items => "../data/invoice_items.csv",
        :transactions => "../data/transactions.csv",
        :customers => "../data/customers.csv"}

engine = SalesEngine.from_csv(files)
analyst = SalesAnalyst.new(engine)

Shoes.app do
    background "#FFFFFF"
    stack(margin: 15) do
        @project_title = banner
        @project_title.text = "Black Thursday - Project Visualization"
        @project_by = para
        @project_by.text = "by David Knorr and Laszlo Balogh (1610BE)"
    end
    
    stack(margin: 15) do
        flow do
            para "Folder for data source (CSV) files: "
            @data_folder = edit_line
            @path = "../data"
            @data_folder.text = @path
            @file_list = `ls #{@path}`.split("\n")
            @data_folder.change {
                @path = @data_folder.text
                @file_list = `ls #{@path}`.split("\n")

                @merchant_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("merchant")}
                @merchant_repo_list.choose(@initial_selection)
                
                @item_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("item")}
                @item_repo_list.choose(@initial_selection)
                
                @invoice_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("invoice")}
                @invoice_repo_list.choose(@initial_selection)

                @invoice_item_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("invoice_item")}
                @invoice_item_repo_list.choose(@initial_selection)

                @transaction_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("transaction")}
                @transaction_repo_list.choose(@initial_selection)

                @customer_repo_list.items = @file_list                
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("customer")}
                @customer_repo_list.choose(@initial_selection)
            }
        end
        flow do
            stack(margin: 5, width: 0.16) do
                para "Merchant repo:"
                @merchant_repo_list = list_box
                @merchant_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("merchant")}
                @merchant_repo_list.choose(@initial_selection)
                @merchant_repo_info = para
                @merchant_repo_info.text = se.merchants_count
            end
            stack(margin: 5, width: 0.16) do
                para "Item repo:"
                @item_repo_list = list_box
                @item_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("item")}
                @item_repo_list.choose(@initial_selection)
                @item_repo_info = para
            end
            stack(margin: 5, width: 0.16) do
                para "Invoice repo:"
                @invoice_repo_list = list_box
                @invoice_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("invoice")}
                @invoice_repo_list.choose(@initial_selection)
                @invoice_repo_info = para
            end
            stack(margin: 5, width: 0.16) do
                para "Invoice Item repo:"
                @invoice_item_repo_list = list_box
                @invoice_item_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("invoice_item")}
                @invoice_item_repo_list.choose(@initial_selection)
                @invoice_item_repo_info = para
            end
            stack(margin: 5, width: 0.16) do
                para "Transaction repo:"
                @transaction_repo_list = list_box
                @transaction_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("transaction")}
                @transaction_repo_list.choose(@initial_selection)
                @transaction_repo_info = para
            end
            stack(margin: 5, width: 0.16) do
                para "Customer repo:"
                @customer_repo_list = list_box
                @customer_repo_list.items = @file_list
                @initial_selection = @file_list.find {|list_item| list_item.start_with?("customer")}
                @customer_repo_list.choose(@initial_selection)
                @customer_repo_info = para
            end
        end
        @load_sales_engine_button = button "Update Sales Engine"
        @load_sales_engine_button.style width: 0.99
        @load_sales_engine_button.click{
            # @merchant_repo_info.text = "#{@path}/#{@merchant_repo_list.text}"
            # @item_repo_info.text = "#{@path}/#{@item_repo_list.text}"
            @invoice_repo_info.text = "#{@path}/#{@invoice_repo_list.text}"
            @invoice_item_repo_info.text = "#{@path}/#{@invoice_item_repo_list.text}"
            @transaction_repo_info.text = "#{@path}/#{@transaction_repo_list.text}"
            @customer_repo_info.text = "#{@path}/#{@customer_repo_list.text}"


            files = {:merchants => "#{@path}/#{@merchant_repo_list.text}",
                         :items => "#{@path}/#{@item_repo_list.text}",
                         :invoices => "#{@path}/#{@invoice_repo_list.text}",
                         :invoice_items => "#{@path}/#{@invoice_item_repo_list.text}",
                         :transactions => "#{@path}/#{@transaction_repo_list.text}",
                         :customers =>  "#{@path}/#{@customer_repo_list.text}"}
            # # @merchant_repo_info.text = "#{@path}/#{@merchant_repo_list.text}"
            
            # # begin
            #     # catch 
                @se.from_csv(files)
            @merchant_repo_info.text = files[:transactions].class
            @items_repo_info.text = se.merchants_count


        }
        stack margin: 0.1 do
            title "Progress example"
            @p = progress width: 0.5
            @p.fraction = (0.5 % 100) / 100.0
        end
        #  animate do |i|
        #    @p.fraction = (i % 100) / 100.0
        #  end
    end

    # stack(margin: 15) do
        @turing_logo = image
    #            @turing_logo.height = 200
    #            @turing_logo.width = 200
    #            @turing_logo.path = "https://d3c5s1hmka2e2b.cloudfront.net/uploads/topic/image/182/Turing---Logo-Black.png"
        @turing_logo.path = "http://railsgirls.com/images/losangeles/turing-school.jpg"
    # end
    
end


    #     flow(margin: 15) do
    #         para "Number of words loaded into dictionary: "
    #         word_count = complete_me.count
    #         @word_count_label = para
    #         @word_count_label.text = word_count
    #     end
        
    #     flow(margin: 15) do
    #         @button_full_dictionary = button "Load entire dictionary"
    #         @button_full_dictionary.click {
    #             @dictionary_status.text = "Loading..."
    #             dictionary = File.read("/usr/share/dict/words")
    #             complete_me.populate(dictionary)
    #             word_count = complete_me.count
    #             @word_count_label.text = word_count
    #             @suggestion_list.items = []
    #             if @input_box.text != ""
    #                 @suggestion_list.items = complete_me.suggest(@input_box.text)
    #             end
    #             @dictionary_status.text = "Loading complete."
    #         }
            
    #         @button_small_dictionary = button "Load small dictionary"
    #         @button_small_dictionary.click {
    #             @dictionary_status.text = "Loading..."
    #             dictionary = File.read("../test/small_dictionary.txt")
    #             complete_me.populate(dictionary)
    #             word_count = complete_me.count
    #             @word_count_label.text = word_count
    #             @suggestion_list.items = []
    #             if @input_box.text != ""
    #                 @suggestion_list.items = complete_me.suggest(@input_box.text)
    #             end
    #             @dictionary_status.text = "Loading complete."
    #         }
            
    #         @button_empty_dictionary = button "Empty dictionary"
    #         @button_empty_dictionary.click {
    #             complete_me = CompleteMe.new
    #             word_count = complete_me.count
    #             @word_count_label.text = word_count
    #             @suggestion_list.items = []
    #             if @input_box.text != ""
    #                 @suggestion_list.items = complete_me.suggest(@input_box.text)
    #             end
    #             @dictionary_status.text = "Emptying complete."
    #         }
            
    #         @dictionary_status = para
    #     end

    #     flow(margin: 15) do
    #         para "Add a word: "
    #         @insert_box = edit_line
    #         @button_insert = button "Insert word into dictionary"
    #         @button_insert.click {
    #             complete_me.insert(@insert_box.text)
    #             word_count = complete_me.count
    #             @word_count_label.text = word_count
    #             @insert_box.text = ""
    #             @suggestion_list.items = []
    #             if @input_box.text != ""
    #                 @suggestion_list.items = complete_me.suggest(@input_box.text)
    #             end
    #         }
    #     end

    #     flow(margin: 15) do
    #         para "Start typing: "
    #         @input_box = edit_line
    #         @input_box.change {
    #             @suggestion_list.items = []
    #             if @input_box.text != ""
    #                 @suggestion_list.items = complete_me.suggest(@input_box.text)
    #             end
    #         }
    #     end

    #     flow(margin: 15) do
    #         para "Pick a suggestion: "
    #         @suggestion_list = list_box
    #         @button_select = button "SELECT"
    #         @button_select.click {
    #             complete_me.select(@input_box.text, @suggestion_list.text)
    #         }
    #     end
        
    # end

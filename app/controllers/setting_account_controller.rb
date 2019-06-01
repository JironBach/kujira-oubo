class SettingAccountController < ApplicationController
  def init(account_array)
    if @accountArray.nil?
      accountArray = [Account.new]
    end
    @accountArray = account_array
    @sidebar_collapse  = "nonsidebar-collapse"
    cookies["sidebar-collapse"] = "sidebar-collapse"

    @loginAccountObj = session["loginAccountObj"]
  	@message = params["message"]
  	@onePageLimit = session["one_page_limit"]
  	@mode = params["mode"]
  	@searchName = params["searchName"]
  	@searchPosition = params["searchPosition"].to_i
  	@searchGroup = params["searchGroup"].to_i
  	@searchStore = params["searchStore"].to_i
  	@searchCerStatus = params["searchCerStatus"]

  	@maxNum = 0;
    if (account_array.length > 0)
      @maxNum = account_array.length
    end
  	if @onePageLimit.blank?
  		@onePageLimit = "20";
  	end
  	@oneLimit = @onePageLimit.to_i #Integer107.parseIfNoDigit(onePageLimit,0);
  	@pageNumStr = params["page_num"]
  	if @pageNumStr.blank?
  		@pageNumStr = "1"
  	end
  	@pageNum = @pageNumStr.to_i #Integer.parseInt(pageNumStr);
  	@maxPageCnt = ((@maxNum + (@oneLimit - 1)) / @oneLimit);

  	@startPageNum = 1
  	@endPageNum = 5

  	if @pageNum < 6
  		@startPageNum = 1
  		if @maxPageCnt < 6
  			@endPageNum = @maxPageCnt;
  		else
  			@endPageNum = 5
  		end
  	else
  		if ((@pageNum + 2) < @maxPageCnt)
  			@startPageNum = @pageNum - 2;
  			@endPageNum = @pageNum + 2;
  		else
  			@startPageNum = @maxPageCnt - 4;
  			@endPageNum = @maxPageCnt;
  		end
  	end

  	@startNum = ((@pageNum -1 ) * @onePageLimit.to_i) + 1; #０件でも１件〜となってしまうため修正要
  	@endNum   =  @startNum - 1  + account_array.length;

  	@prefEnableFlg = (@pageNum < 2) ? false : true;
  	@highPrefEnableFlg = (@pageNum < 6) ? false : true;
  	@nextEnableFlg = (@pageNum < @maxPageCnt) ? true : false;
  	@highNextEnableFlg = (@pageNum < (@maxPageCnt - 4)) ? true : false;

  	@highPreNum = @pageNum - 5;
  	if (@highPreNum < 1)
  		@highPreNum = 1;
  	end
  	@preNum = @pageNum - 1;
  	if (@preNum < 1)
  		@preNum = 1;
  	end
  	@highNextNum = @pageNum + 5;
  	if (@highNextNum > @maxPageCnt)
  		@highNextNum = @maxPageCnt;
  	end
  	@nextNum = @pageNum + 1;
  	if (@nextNum > @maxPageCnt)
  		@nextNum = @maxPageCnt;
  	end

   #ss = loginAccountObj['fullname'];
   #pict = ss.slice(0, 1);

   #GroupStrGetter groupStrGetter = GroupStrGetter.getInstance();
   #StoreStrGetter storeStrGetter = StoreStrGetter.getInstance();
   #StatusStrGetter statusStrGetter = StatusStrGetter.getInstance();
   #AuthStrGetter authStrGetter = AuthStrGetter.getInstance();
   @groupObjArray = SGroup.where(delete_flg: 0).where.not(name: nil).all #groupStrGetter.getGroupObjArray();
   @storeObjArray = Store.where(delete_flg: 0).where.not(company_name: nil).all #storeStrGetter.getStoreObjArray();
  end

  def show
    accounts = Account.all
    init(accounts)
    @accountArray  = accounts
    render 'show'
  end

  def post
    @message = "";
    @onePageLimit = params["one_page_limit"]
    if @onePageLimit.blank?
      @onePageLimit = session["one_page_limit"]
    else
      @onePageLimit = "20"
    end
    session["one_page_limit"] = @onePageLimit

    @fromWhich = params["fromWhich"]
    @mode = params["mode"]
    @searchName = params["searchName"]
    @searchPosition = params["searchPosition"].blank? ? 0 : params["searchPosition"].to_i
    @searchGroup = params["searchGroup"].blank? ? 0 : params["searchGroup"].to_i
    @searchStore = params["searchStore"].blank? ? 0 : params["searchStore"].to_i
    @searchCerStatus = params["searchCerStatus"]
    @searchName = "" if @searchName.blank?
    @searchStore = "" if @searchStore.blank?
    @searchCerStatus = "-1" if @searchCerStatus.blank?
    if "search" == @mode
      logger.debug "debug:account_search=#{params.inspect}"
      logger.debug "debug:search_posision=#{@searchPosition} & #{@searchGroup}"
      logger.debug "debug:Account=#{Account.where(position: @searchPosition, s_group: @searchGroup).first.inspect}"
      if (@searchPosition == -1) && (@searchGroup == -1) && (@searchStore == -1)
        init(Account.all)
      else
        init(Account.where(position: @searchPosition, s_group: @searchGroup, store: @searchStore).all)
      end
      @mode = "search";
      render 'show'
    else
      init(Account.all)
      @mode = "";
      render 'show'
    end
    @searchStatus = params["searchStatus"]
    @searchStatus = "" if @searchStatus.blank?
  end
end

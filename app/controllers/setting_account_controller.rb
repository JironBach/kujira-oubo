class SettingAccountController < ApplicationController
  def show
    render 'show'
  end

  def post
    message = "";
    onePageLimit = params["one_page_limit"]
    if onePageLimit.blank?
      onePageLimit = session["one_page_limit"]
    else
      onePageLimit = "20"
    end
    session["one_page_limit"] = onePageLimit

    RestRequest restReq = new RestRequest(request.getPathInfo());
    String pageNumStr = restReq.getParam(1);
    int pageNum
    if pageNumStr.nil?
      pageNum = Integer.parseInt(pageNumStr)
    else
      pageNum = 1
    end
    String fromWhich = (String)request.getParameter("fromWhich");
    AccountObject[] accountArray = null;
    String mode = (String)request.getParameter("mode");
    String searchName = request.getParameter("searchName");
    String searchPosition = request.getParameter("searchPosition");
    String searchGroup = request.getParameter("searchGroup");
    String searchStore = request.getParameter("searchStore");
    String searchCerStatus = request.getParameter("searchCerStatus");
    if(searchName == null)
    searchName = "";
    if(searchPosition == null)
    searchPosition = "";
    if(searchGroup == null)
    searchGroup = "";
    if(searchStore == null)
    searchStore = "";
    if(searchCerStatus == null)
    searchCerStatus = "-1";

    if("search".equals(mode))
      AccountObject searchItem = new AccountObject(searchName,Integer107.parseInt(searchPosition),Integer107.parseInt(searchGroup),Integer107.parseInt(searchStore),Integer107.parseInt(searchCerStatus));	//検索要素をAccountObjectに入れる
      accountArray = SearchAccount.searchAccount(searchItem,pageNum-1,Integer.parseInt(onePageLimit));
      mode = "search";
    else
      accountArray = ReadAccount.readAccount(pageNum-1,Integer.parseInt(onePageLimit));
      mode = "";
    end
    String searchStatus;
    searchStatus = request.getParameter("searchStatus");
    if(searchStatus == null)
      searchStatus = ""
    end
  end
end

$(document).ready(function () {
    initSavedFilters()
    $(document).on("click keyup", "#nps-search-input", function (event) {
        handleSearchInput()
    });
    $(".icon-close1").on("click", function(){
        $("#nps-search-input").val("")
        handleSearchInput()
        clearFilters()
    })
});

const initSavedFilters= () => {
    const lsSearchText = sessionStorage.getItem("_search") || ''
    _search = lsSearchText 
    $("#nps-search-input").val(lsSearchText)
    if(lsSearchText) {
        handleSearchInput()
    }
}

const clearFilters = () => {
    filteredProducts = products
    sessionStorage.removeItem("_search")
    renderFilteredCollection()
  }

const handleSearchInput = () => {
    _search = $("#nps-search-input").val()?.toLowerCase()
    if(_search !== "") {
        $(".nps-icon__close").removeClass('hidden')
        $(".nps-icon__search").addClass('hidden')
    } else {
        $(".nps-icon__close").addClass('hidden')
        $(".nps-icon__search").removeClass('hidden')
    }
    filterData()
}

const filterData = () => {
    sessionStorage.setItem("_search", _search === null ? '' : _search)
    filteredProducts = collectionData.map((obj) => {
        let includesAll
        const IncludeTitle = obj.title?.toLowerCase().includes(_search)
        const IncludeCity = obj.metafields.location?.city.toLowerCase().includes(_search)
        const IncludeState = obj.metafields.location?.state.toLowerCase().includes(_search)
        const isNonProfit = obj.template_suffix.includes("non-profit")
        includesAll = isNonProfit && (IncludeTitle || IncludeCity || IncludeState)
        return includesAll ? obj : null
    }).filter(Boolean)
    renderFilteredCollection()
  }

const renderFilteredCollection = () => {
    let filteredProductsDom = ''
    filteredProductsDom = filteredProducts.map((item) => { 
        return `
            <div class="search-items">
                <div class="nps-search-item">    
                    <div class="nps-search-img">  
                    <a href="${ item?.url }"><img src="${ item?.image?.src }"></a>
                    </div>
                    <div class="nps-search-desc">
                        <div class="nps-search-texts">
                            <span class="nps-city-state">${ item.metafields.location?.city }, ${ item.metafields.location?.state }</span>
                            <a href="${item?.url}"><h2>${ item?.title }</h2></a>
                            <p>${item?.description}</p> 
                            <a href="${item?.url}" class="button button--secondary">View</a>
                        </div>
                    </div>
                </div>
            </div> 
        ` 
    }).join('');
    $(".nps-search-items-group").html(filteredProductsDom)
}

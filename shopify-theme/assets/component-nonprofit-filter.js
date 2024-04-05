$(document).ready(function () {
  initSavedFilters()
  // Event delegation for all filters and actions
  $(document).on("click change keyup", ".ssap-filter-remove, #ssap-species, #ssap-breed, #ssap-age, #ssap-gender, #ssap-search-input, #ssap-sort, .ssap-img--control:not(.active)", function (event) {
    const $this = $(this)
    const eventType = event.type
    if (eventType === "click" && $this.hasClass("ssap-filter-remove")) {
      handleRemoveFilter($this)
    } else if (eventType === "click" && $this.hasClass("ssap-img--control")) {
      handleImageControl($this)
    } else if (eventType === "change") {
      handleChangeFilter($this)
    } else if ((eventType === "keyup" || eventType === "change") && $this.attr("id") === "ssap-search-input") {
      handleSearchInput($this)
    } 
  });
});

const handleRemoveFilter = ($element) => {
  $element.removeClass("active")
  if($element.hasClass('clear-all')) {
    clearFilters()
    return
  }
  let target = $element.closest('.filter-wrap').find("select")
  if($element.closest('.filter-wrap').hasClass('input-field--wrap')) target = $("#ssap-search-input")
  else target.val(target.find("option:first").val())
  const id = target.attr("id")
  switch (id) {
    case "ssap-species":
      _species = ""
      _breed = ""
      $("#ssap-breed").parent().find(".ssap-filter-remove").removeClass("active")
      initBreed()
      break;
    case "ssap-breed":
      _breed = ""
      break;
    case "ssap-age":
      _age = ""
      break;
    case "ssap-gender":
      _gender = ""
      break;
    case "ssap-search-input":
      $("#ssap-search-input").val('');
      _search = ''
      break;
    case "ssap-sort":
      _sort = ""
      break;
    default:
      console.log("Invalid!");
  }
  filterData()
}

const handleChangeFilter = ($element) => {
  const btnTar = $element.closest('.filter-wrap').find(".ssap-filter-remove")
  const id = $element.attr("id")

  if($element.val() == 'default_option') {
    btnTar.removeClass('active')
  } else {
    btnTar.addClass('active')
  }
  switch (id) {
    case "ssap-species":
      const value = $element.val()
      if($element.val() == 'default_option') {
        _species = ''
      } else {
        updateBreedList(value)
        _species = value
      }
      break;
    case "ssap-breed":
      if($element.val() == 'default_option') {
        _breed = ''
      } else {
        _breed = $element.val()
      }
      break;
    case "ssap-age":
      if($element.val() == 'default_option') {
        _age = ''
      }else {
        _age = $element.val()
      }
      break;
    case "ssap-gender":
      if($element.val() == 'default_option') {
        _gender = ''
      } else {
        _gender = $element.val()
      }
      break;
    case "ssap-sort":
      if($element.val() == 'default_option') {
        $element.closest(".filter-wrap").find(".ssap-filter-remove").removeClass("active")
        _sort = ''
      } else {
        $element.closest(".filter-wrap").find(".ssap-filter-remove").addClass("active")
        _sort = $element.val()
      }
      break;
    case "ssap-search-input":
      handleSearchInput($element)
      break;
    default:
      console.log("Invalid!")
  }
  filterData()
}

const handleSearchInput = ($element) => {
  const value = $element.val()
  const btnTar = $element.closest(".filter-wrap").find(".ssap-filter-remove")
  if (value == '') btnTar.removeClass("active")
  else btnTar.addClass("active")
  _search = $("#ssap-search-input").val().toLowerCase()
  filterData()
}

const handleImageControl = ($element) => {
  $element.parent().find('.ssap-img--control').removeClass('active')
  $element.addClass('active')
  if($element.hasClass('ssap-image--show')) {
    $(".ssap-non-profit-page-collection").removeClass('hide-image')
  } else {
    $(".ssap-non-profit-page-collection").addClass('hide-image')
  }
}

const filterData = () => {
  const filterTags = [_species, _breed, _age, _gender].filter(Boolean)
  // Session Storage for saving filtered items
  sessionStorage.setItem("_species", _species === null ? '' : _species)
  sessionStorage.setItem("_breed", _breed === null ? '' : _breed)
  sessionStorage.setItem("_age", _age === null ? '' : _age)
  sessionStorage.setItem("_gender", _gender === null ? '' : _gender)
  sessionStorage.setItem("_search", _search === null ? '' : _search)
  sessionStorage.setItem("_sort", _sort === null ? '' : _sort)

  filteredProducts = products.map((obj) => {
    const objTags = obj.tags.map(item => item.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/-$/, '').replace(/^-/, ''))
    let includesAll
    if(_search) {
      const IncludeTitle = obj.title?.toLowerCase().includes(_search)
      const IncludeCity = obj.locatoin_city?.toLowerCase().includes(_search)
      const IncludeState = obj.locatoin_state?.toLowerCase().includes(_search)
      includesAll = filterTags.every((val) => objTags.includes(val.toLowerCase())) && (IncludeTitle || IncludeCity || IncludeState)
    } else {
      includesAll = filterTags.every((val) => objTags.includes(val.toLowerCase()))
    }
    return includesAll ? obj : null
  }).filter(Boolean)

  if(_sort) {
    switch (_sort) {
      case "newest":
        filteredProducts.sort((a, b) => a.create_at_seconds - b.create_at_seconds)
        break;
      case "oldest":
        filteredProducts.sort((a, b) => b.create_at_seconds - a.create_at_seconds)
        break;
      case "most":
        filteredProducts.sort((a, b) => b.donation_amount - a.donation_amount) 
        break;
      case "least":
        filteredProducts.sort((a, b) => a.donation_amount - b.donation_amount)
        break;
      case "a-z":
        filteredProducts.sort((a, b) => {
          if (a.title < b.title) return -1;
        })
        break;
      case "z-a":
        filteredProducts.sort((a, b) => {
          if (b.title < a.title) return -1;
        })
        break;
      default:
        console.log("Invalid!");
    }
  }
  renderFilteredProducts()
}

const enableClearFilters = () => {
  _search = $("#ssap-search-input").val()
  if(_species || _breed || _age || _gender || _sort || _search) {
    $(".ssap-filter-remove.clear-all").addClass("active")
  } else {// if(!_species && !_breed && !_age && !_gender && !_sort && !Boolean($("#ssap-search-input").val())) {
    $(".ssap-filter-remove.clear-all").removeClass("active")
  }
}

const clearFilters = () => {
  $(".ssap-filter-remove").removeClass('active')
  _species = ""
  _breed = ""
  _age = ""
  _gender = ""
  _sort = ""
  const element = $(".ssap-non-profit-page-filters").find('select')
  element.val(element.find("option:first").val())
  initBreed()
  $("#ssap-search-input").val("")
  filteredProducts = products
  sessionStorage.removeItem("_species")
  sessionStorage.removeItem("_breed")
  sessionStorage.removeItem("_age")
  sessionStorage.removeItem("_gender")
  sessionStorage.removeItem("_search")
  sessionStorage.removeItem("_sort")
  renderFilteredProducts()
}

const initBreed = () => {
  $("#ssap-breed").html(
    `<select class="ssap-non-profit-page-select" id="ssap-breed"><option selected="selected" value="default_option">All</option></select>`
  )
}

const initSavedFilters= () => {
  const lsSpecies = sessionStorage.getItem("_species") || ''
  const lsBreed = sessionStorage.getItem("_breed") || ''
  const lsAge = sessionStorage.getItem("_age") || ''
  const lsGender = sessionStorage.getItem("_gender") || ''
  const lsSearchText = sessionStorage.getItem("_search") || ''
  const lsSort = sessionStorage.getItem("_sort") || ''

  _species = lsSpecies
  _breed = lsBreed
  _age = lsAge
  _gender = lsGender
  _search = lsSearchText
  _sort = lsSort

  if(_species) $("#ssap-species").val(_species).trigger("change").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")
  if(_breed) $("#ssap-breed").val(_breed).trigger("change").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")
  if(_age) $("#ssap-age").val(_age).trigger("change").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")
  if(_gender) $("#ssap-gender").val(_gender).trigger("change").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")
  if(_search) $("#ssap-search-input").val(_search).trigger("keyup").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")
  if(_sort) $("#ssap-sort").val(_sort).trigger("change").closest('.filter-wrap').find(".ssap-filter-remove").addClass("active")

  if(lsSpecies || lsBreed || lsAge || lsGender || lsSearchText || lsSort) {
    filterData()
  }
}

const renderFilteredProducts = () => {
  enableClearFilters()
  let filteredProductsDom = ''
  if(filteredProducts.length == 0) {
    filteredProductsDom = `<div class="nonprofit-no--result">No campaigns for this filter</div>`
  } else {
    filteredProductsDom = filteredProducts.map((item) => { 
      return `
        <div class="collection--col">
          <a href="${item.url}" class="collection-col--donat">
            <div class="col-donat--img">
              <h3>${item.title}</h3>
              <img src="${item.images[0]}">
            </div>
              <div class="col-donate--price">
                <p>${item.donation_goal}</p>
                <p>DONATIONS NEEDED</p>
              </div> 
            <div class="coll--main">
              <button>Donate Now</button>
              <p class="coll-value--persent">${ item.donation_percent }% Donation completed</p>
              <div class="coll-valueline">
                <span style="--value:${ item.donation_percent }%;"></span>
              </div>
              <div class="coll-desc">${item.short_description}</div>
              <span class="coll-loc"><svg width="10" height="17" viewBox="0 0 10 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3.42857 9.86607C3.79762 9.95536 4.17857 10 4.57143 10C4.96429 10 5.34524 9.95536 5.71429 9.86607V15.7143C5.71429 15.869 5.65774 16.003 5.54464 16.1161C5.43155 16.2292 5.29762 16.2857 5.14286 16.2857H4C3.84524 16.2857 3.71131 16.2292 3.59821 16.1161C3.48512 16.003 3.42857 15.869 3.42857 15.7143V9.86607ZM1.33929 1.625C2.23214 0.732142 3.30952 0.285713 4.57143 0.285713C5.83333 0.285713 6.91071 0.732142 7.80357 1.625C8.69643 2.51786 9.14286 3.59524 9.14286 4.85714C9.14286 6.11905 8.69643 7.19643 7.80357 8.08929C6.91071 8.98214 5.83333 9.42857 4.57143 9.42857C3.30952 9.42857 2.23214 8.98214 1.33929 8.08929C0.446429 7.19643 0 6.11905 0 4.85714C0 3.59524 0.446429 2.51786 1.33929 1.625ZM4.57143 2.28571C4.65476 2.28571 4.72321 2.25893 4.77679 2.20536C4.83036 2.15178 4.85714 2.08333 4.85714 2C4.85714 1.91667 4.83036 1.84821 4.77679 1.79464C4.72321 1.74107 4.65476 1.71428 4.57143 1.71428C3.70238 1.71428 2.96131 2.02083 2.34821 2.63393C1.73512 3.24702 1.42857 3.98809 1.42857 4.85714C1.42857 4.94048 1.45536 5.00893 1.50893 5.0625C1.5625 5.11607 1.63095 5.14286 1.71429 5.14286C1.79762 5.14286 1.86607 5.11607 1.91964 5.0625C1.97321 5.00893 2 4.94048 2 4.85714C2 4.14881 2.25 3.54464 2.75 3.04464C3.25595 2.53869 3.8631 2.28571 4.57143 2.28571Z" fill="#FE5671"/></svg>${ item.locatoin_city }, ${ item.locatoin_state }</span>
            </div>
          </a>
        </div>
      ` 
    }).join('');
  }
  $(".ssap-non-profit-page-collection").html(filteredProductsDom)
}

const updateBreedList = (species)  => {
  var options = ``;
  if (species == "cat") {
    options = `
      <option selected="selected" value="default_option">All</option><option value="abyssinian">Abyssinian</option><option value="american-curl">American Curl</option><option value="american-shorthair">American Shorthair</option><option value="american-wirehair">American Wirehair</option><option value="angora">Angora</option><option value="applehead-siamese">Applehead Siamese</option><option value="balinese">Balinese</option><option value="bengal">Bengal</option><option value="birman">Birman</option><option value="bobtail">Bobtail</option><option value="bombay">Bombay</option><option value="brazilian-shorthair">Brazilian Shorthair</option><option value="british-shorthair">British Shorthair</option><option value="burmese">Burmese</option><option value="burmilla">Burmilla</option><option value="calico">Calico</option><option value="canadian-hairless">Canadian Hairless</option><option value="chanillytiffany">Chanilly/Tiffany</option><option value="chartreux">Chartreux</option><option value="chausie">Chausie</option><option value="chinchilla">Chinchilla</option><option value="colorpoint-shorthair">Colorpoint Shorthair</option><option value="cornish-rex">Cornish Rex</option><option value="cymric">Cymric</option><option value="devon-rex">Devon Rex</option><option value="dilute-calico">Dilute Calico</option><option value="dilute-tortoiseshell">Dilute Tortoiseshell</option><option value="domestic-long-hair">Domestic Long Hair</option><option value="domestic-medium-hair">Domestic Medium Hair</option><option value="domestic-short-hair">Domestic Short Hair</option><option value="egyptian-mau">Egyptian Mau</option><option value="european-burmese">European Burmese</option><option value="european-shorthair">European Shorthair</option><option value="exotic-shorthair">Exotic Shorthair</option><option value="extratoes-cat-hemingway-polydactyl">Extra-Toes Cat (Hemingway Polydactyl)</option><option value="german-rex">German Rex</option><option value="havana">Havana</option><option value="himalayan">Himalayan</option><option value="japanese-bobtail">Japanese Bobtail</option><option value="javanese">Javanese</option><option value="korat">Korat</option><option value="laperm">LaPerm</option><option value="maine-coon">Maine Coon</option><option value="malayan">Malayan</option><option value="manx">Manx</option><option value="mixed">Mixed</option><option value="munchkin">Munchkin</option><option value="mutt">Mutt</option><option value="nebelung">Nebelung</option><option value="norwegian-forest-cat">Norwegian Forest Cat</option><option value="ocicat">Ocicat</option><option value="oriental-long-hair">Oriental Long Hair</option><option value="oriental-short-hair">Oriental Short Hair</option><option value="oriental-tabby">Oriental Tabby</option><option value="persian">Persian</option><option value="pixiebob">Pixie-Bob</option><option value="ragamuffin">Ragamuffin</option><option value="ragdoll">Ragdoll</option><option value="rex">Rex</option><option value="russian-blue">Russian Blue</option><option value="savannah">Savannah</option><option value="scottish-fold">Scottish Fold</option><option value="selkirk-rex">Selkirk Rex</option><option value="siamese">Siamese</option><option value="siberian">Siberian</option><option value="singapura">Singapura</option><option value="snowshoe">Snowshoe</option><option value="somali">Somali</option><option value="sphynx-hairless-cat">Sphynx (hairless cat)</option><option value="tabby">Tabby</option><option value="tiffany">Tiffany</option><option value="tiger">Tiger</option><option value="tonkinese">Tonkinese</option><option value="torbie">Torbie</option><option value="tortoiseshell">Tortoiseshell</option><option value="turkish-angora">Turkish Angora</option><option value="turkish-van">Turkish Van</option><option value="tuxedo">Tuxedo</option><option value="unknown-cat">Unknown</option>
    `;
  } else if (species == "dog") {
    options = `
      <option selected="selected" value="default_option">All</option><option value="affenpinscher">Affenpinscher</option><option value="afghan-hound">Afghan Hound</option><option value="airedale-terrier">Airedale Terrier</option><option value="akbash">Akbash</option><option value="akita">Akita</option><option value="alaskan-klee-kai">Alaskan Klee Kai</option><option value="alaskan-malamute">Alaskan Malamute</option><option value="american-bulldog">American Bulldog</option><option value="american-eskimo-dog">American Eskimo Dog</option><option value="american-foxhound">American Foxhound</option><option value="american-hairless-terrier">American Hairless Terrier</option><option value="american-pit-bull-terrier">American Pit Bull Terrier</option><option value="american-staffordshire-terrier">American Staffordshire Terrier</option><option value="american-water-spaniel">American Water Spaniel</option><option value="anatolian-karabash-dog">Anatolian Karabash Dog</option><option value="anatolian-shepherd">Anatolian Shepherd</option><option value="appenzell-mountain-dog">Appenzell Mountain Dog</option><option value="argentinian-mastiff">Argentinian Mastiff</option><option value="australian-cattle-dogblue-heeler">Australian Cattle Dog/Blue Heeler</option><option value="australian-kelpie">Australian Kelpie</option><option value="australian-shepherd">Australian Shepherd</option><option value="australian-terrier">Australian Terrier</option><option value="basenji">Basenji</option><option value="basset-griffon-vendeen">Basset Griffon Vendeen</option><option value="basset-hound">Basset Hound</option><option value="beagle">Beagle</option><option value="bearded-collie">Bearded Collie</option><option value="beauceron">Beauceron</option><option value="bedlington-terrier">Bedlington Terrier</option><option value="belgian-griffon">Belgian Griffon</option><option value="belgian-shepherd-dog-sheepdog">Belgian Shepherd Dog Sheepdog</option><option value="belgian-shepherd-laekenois">Belgian Shepherd Laekenois</option><option value="belgian-shepherd-malinois">Belgian Shepherd Malinois</option><option value="belgian-shepherd-tervuren">Belgian Shepherd Tervuren</option><option value="bernese-mountain-dog">Bernese Mountain Dog</option><option value="bichon-frise">Bichon Frise</option><option value="biewer">Biewer</option><option value="black-and-tan-coonhound">Black and Tan Coonhound</option><option value="black-labrador-retriever">Black Labrador Retriever</option><option value="black-mouth-cur">Black Mouth Cur</option><option value="black-russian-terrier">Black Russian Terrier</option><option value="bloodhound">Bloodhound</option><option value="blue-lacy">Blue Lacy</option><option value="bluetick-coonhound">Bluetick Coonhound</option><option value="bobtail">Bobtail</option><option value="boerboel-mastiff">Boerboel Mastiff</option><option value="bolognese">Bolognese</option><option value="bordeaux">Bordeaux</option><option value="border-collie">Border Collie</option><option value="border-terrier">Border Terrier</option><option value="borzoi">Borzoi</option><option value="boston-terrier">Boston Terrier</option><option value="bouvier-des-flandres">Bouvier des Flandres</option><option value="boxer">Boxer</option><option value="boykin-spaniel">Boykin Spaniel</option><option value="brazilian-mastiff">Brazilian Mastiff</option><option value="briard">Briard</option><option value="brittany">Brittany</option><option value="brussels-griffon">Brussels Griffon</option><option value="bull-terrier">Bull Terrier</option><option value="bulldog">Bulldog</option><option value="bullmastiff">Bullmastiff</option><option value="cairn-terrier">Cairn Terrier</option><option value="canaan-dog">Canaan Dog</option><option value="cane-corso-mastiff">Cane Corso Mastiff</option><option value="cardigan-welsh-corgi">Cardigan Welsh Corgi</option><option value="carolina-dog">Carolina Dog</option><option value="catahoula-leopard-dog">Catahoula Leopard Dog</option><option value="cattle-dog">Cattle Dog</option><option value="caucasian-sheepdog-caucasian-ovtcharka">Caucasian Sheepdog (Caucasian Ovtcharka)</option><option value="cavalier-king-charles-spaniel">Cavalier King Charles Spaniel</option><option value="chesapeake-bay-retriever">Chesapeake Bay Retriever</option><option value="chihuahua">Chihuahua</option><option value="chinese-crestedhairless">Chinese Crested-Hairless</option><option value="chinese-crestedpowder-puff">Chinese Crested-Powder Puff</option><option value="chinese-foo-dog">Chinese Foo Dog</option><option value="chinese-sharpei">Chinese Shar-Pei</option><option value="chinook">Chinook</option><option value="chocolate-labrador-retriever">Chocolate Labrador Retriever</option><option value="chow-chow">Chow Chow</option><option value="cirneco-delletna">Cirneco dellEtna</option><option value="clumber-spaniel">Clumber Spaniel</option><option value="cockapoo">Cockapoo</option><option value="cocker-spaniel">Cocker Spaniel</option><option value="collie">Collie</option><option value="coonhound">Coonhound</option><option value="corgi">Corgi</option><option value="coton-de-tulear">Coton de Tulear</option><option value="curlycoated-retriever">Curly-Coated Retriever</option><option value="dachshund">Dachshund</option><option value="dalmatian">Dalmatian</option><option value="dandie-dinmont-terrier">Dandie Dinmont Terrier</option><option value="danish-broholmer">Danish Broholmer</option><option value="deerhound">Deerhound</option><option value="doberman-pinscher">Doberman Pinscher</option><option value="dogo-argentino">Dogo Argentino</option><option value="dogue-de-bordeaux">Dogue de Bordeaux</option><option value="dutch-shepherd">Dutch Shepherd</option><option value="elkhound">Elkhound</option><option value="english-bulldog">English Bulldog</option><option value="english-cocker-spaniel">English Cocker Spaniel</option><option value="english-coonhound">English Coonhound</option><option value="english-foxhound">English Foxhound</option><option value="english-mastiff">English Mastiff</option><option value="english-pointer">English Pointer</option><option value="english-setter">English Setter</option><option value="english-sheepdog">English Sheepdog</option><option value="english-shepherd">English Shepherd</option><option value="english-springer-spaniel">English Springer Spaniel</option><option value="english-toy-spaniel">English Toy Spaniel</option><option value="entlebucher">Entlebucher</option><option value="eskimo-dog">Eskimo Dog</option><option value="eskimo-spitz">Eskimo Spitz</option><option value="eurasier">Eurasier</option><option value="feist">Feist</option><option value="field-spaniel">Field Spaniel</option><option value="fila-brasileiro">Fila Brasileiro</option><option value="finnish-lapphund">Finnish Lapphund</option><option value="finnish-spitz">Finnish Spitz</option><option value="flatcoated-retriever">Flat-coated Retriever</option><option value="fox-terrier">Fox Terrier</option><option value="foxhound">Foxhound</option><option value="french-brittany">French Brittany</option><option value="french-bulldog">French Bulldog</option><option value="french-mastiff">French Mastiff</option><option value="galgo-spanish-greyhound">Galgo Spanish Greyhound</option><option value="german-pinscher">German Pinscher</option><option value="german-shepherd-dog">German Shepherd Dog</option><option value="german-shorthaired-pointer">German Shorthaired Pointer</option><option value="german-spitz">German Spitz</option><option value="german-wirehaired-pointer">German Wirehaired Pointer</option><option value="giant-schnauzer">Giant Schnauzer</option><option value="glen-of-imaal-terrier">Glen of Imaal Terrier</option><option value="golden-retriever">Golden Retriever</option><option value="gordon-setter">Gordon Setter</option><option value="great-dane">Great Dane</option><option value="great-pyrenees">Great Pyrenees</option><option value="greater-swiss-mountain-dog">Greater Swiss Mountain Dog</option><option value="greyhound">Greyhound</option><option value="halden-hound-haldenstrover">Halden Hound (Haldenstrover)</option><option value="harrier">Harrier</option><option value="havanese">Havanese</option><option value="hollandse-tulphond">Hollandse Tulphond</option><option value="hound">Hound</option><option value="hovawart">Hovawart</option><option value="husky">Husky</option><option value="ibizan-hound">Ibizan Hound</option><option value="illyrian-sheepdog">Illyrian Sheepdog</option><option value="irish-setter">Irish Setter</option><option value="irish-terrier">Irish Terrier</option><option value="irish-water-spaniel">Irish Water Spaniel</option><option value="irish-wolfhound">Irish Wolfhound</option><option value="italian-greyhound">Italian Greyhound</option><option value="italian-mastiff">Italian Mastiff</option><option value="italian-spinone">Italian Spinone</option><option value="jack-russell-terrier">Jack Russell Terrier</option><option value="jack-russell-terrier-parson-russell-terrier">Jack Russell Terrier (Parson Russell Terrier)</option><option value="japanese-chin">Japanese Chin</option><option value="jindo-korean">Jindo (Korean)</option><option value="kai-dog">Kai Dog</option><option value="karelian-bear-dog">Karelian Bear Dog</option><option value="keeshond">Keeshond</option><option value="kerry-blue-terrier">Kerry Blue Terrier</option><option value="kishu">Kishu</option><option value="klee-kai">Klee Kai</option><option value="komondor">Komondor</option><option value="kuvasz">Kuvasz</option><option value="kyi-leo">Kyi Leo</option><option value="labrador-retriever">Labrador Retriever</option><option value="lakeland-terrier">Lakeland Terrier</option><option value="lancashire-heeler">Lancashire Heeler</option><option value="leonberger">Leonberger</option><option value="lhasa-apso">Lhasa Apso</option><option value="lwchen">Löwchen</option><option value="maltese">Maltese</option><option value="manchester-terrier">Manchester Terrier</option><option value="maremma-sheepdog">Maremma Sheepdog</option><option value="markiesje">Markiesje</option><option value="mastiff">Mastiff</option><option value="mcnab">McNab</option><option value="mexican-hairless">Mexican Hairless</option><option value="miniature-bull-terrier">Miniature Bull Terrier</option><option value="miniature-pinscher">Miniature Pinscher</option><option value="miniature-schnauzer">Miniature Schnauzer</option><option value="mixed">Mixed</option><option value="mountain-cur">Mountain Cur</option><option value="mountain-dog">Mountain Dog</option><option value="munsterlander">Munsterlander</option><option value="mutt">Mutt</option><option value="neapolitan-mastiff">Neapolitan Mastiff</option><option value="new-guinea-singing-dog">New Guinea Singing Dog</option><option value="newfoundland-dog">Newfoundland Dog</option><option value="norfolk-terrier">Norfolk Terrier</option><option value="norwegian-buhund">Norwegian Buhund</option><option value="norwegian-elkhound">Norwegian Elkhound</option><option value="norwegian-lundehund">Norwegian Lundehund</option><option value="norwich-terrier">Norwich Terrier</option><option value="nova-scotia-ducktolling-retriever">Nova Scotia Duck-Tolling Retriever</option><option value="old-english-sheepdog">Old English Sheepdog</option><option value="otterhound">Otterhound</option><option value="papillon">Papillon</option><option value="parson-russell-terrier">Parson Russell Terrier</option><option value="patterdale-terrier-fell-terrier">Patterdale Terrier (Fell Terrier)</option><option value="pekingese">Pekingese</option><option value="pembroke-welsh-corgi">Pembroke Welsh Corgi</option><option value="peruvian-inca-orchid">Peruvian Inca Orchid</option><option value="petit-basset-griffon-vendeen">Petit Basset Griffon Vendeen</option><option value="pharaoh-hound">Pharaoh Hound</option><option value="picardy-shepherd">Picardy Shepherd</option><option value="pit-bull-terrier">Pit Bull Terrier</option><option value="plott-hound">Plott Hound</option><option value="podengo-portugueso">Podengo Portugueso</option><option value="pointer">Pointer</option><option value="polish-lowland-sheepdog">Polish Lowland Sheepdog</option><option value="pomeranian">Pomeranian</option><option value="poodle-miniature">Poodle (Miniature)</option><option value="poodle-standard">Poodle (Standard)</option><option value="poodle-tcup">Poodle (T-Cup)</option><option value="poodle-toy">Poodle (Toy)</option><option value="poodle-unknown-type">Poodle (unknown type)</option><option value="portuguese-water-dog">Portuguese Water Dog</option><option value="presa-canario">Presa Canario</option><option value="pug">Pug</option><option value="puli">Puli</option><option value="pumi">Pumi</option><option value="queensland-heeler">Queensland Heeler</option><option value="rat-terrier">Rat Terrier</option><option value="red-heeler">Red Heeler</option><option value="redbone-coonhound">Redbone Coonhound</option><option value="retriever">Retriever</option><option value="rhodesian-ridgeback">Rhodesian Ridgeback</option><option value="rottweiler">Rottweiler</option><option value="russian-wolfhound">Russian Wolfhound</option><option value="saarlooswolfhond">Saarlooswolfhond</option><option value="saint-bernard">Saint Bernard</option><option value="saluki">Saluki</option><option value="saluki-greyhound">Saluki Greyhound</option><option value="samoyed">Samoyed</option><option value="schiller-hound">Schiller Hound</option><option value="schipperke">Schipperke</option><option value="schnauzer">Schnauzer</option><option value="scottish-deerhound">Scottish Deerhound</option><option value="scottish-terrier-scottie">Scottish Terrier Scottie</option><option value="sealyham-terrier">Sealyham Terrier</option><option value="setter">Setter</option><option value="shar-pei">Shar Pei</option><option value="sheep-dog">Sheep Dog</option><option value="shepherd">Shepherd</option><option value="shetland-sheepdog-sheltie">Shetland Sheepdog Sheltie</option><option value="shiba-inu">Shiba Inu</option><option value="shih-tzu">Shih Tzu</option><option value="siberian-husky">Siberian Husky</option><option value="silky-terrier">Silky Terrier</option><option value="skye-terrier">Skye Terrier</option><option value="sloughi">Sloughi</option><option value="smooth-fox-terrier">Smooth Fox Terrier</option><option value="softcoated-wheaten-terrier">Soft-Coated Wheaten Terrier</option><option value="south-russian-ovcharka">South Russian Ovcharka</option><option value="spaniel">Spaniel</option><option value="spanish-mastiff">Spanish Mastiff</option><option value="spinone-italiano">Spinone Italiano</option><option value="spitz">Spitz</option><option value="springer-spaniel">Springer Spaniel</option><option value="staffordshire-bull-terrier">Staffordshire Bull Terrier</option><option value="sussex-spaniel">Sussex Spaniel</option><option value="swedish-vallhund">Swedish Vallhund</option><option value="tamaskan">Tamaskan</option><option value="terrier">Terrier</option><option value="thai-ridgeback">Thai Ridgeback</option><option value="tibetan-mastiff">Tibetan Mastiff</option><option value="tibetan-spaniel">Tibetan Spaniel</option><option value="tibetan-terrier">Tibetan Terrier</option><option value="tosa-inu">Tosa Inu</option><option value="toy-fox-terrier">Toy Fox Terrier</option><option value="toy-terrier">Toy Terrier</option><option value="treeing-walker-coonhound">Treeing Walker Coonhound</option><option value="unknown-dog">Unknown</option><option value="vizsla">Vizsla</option><option value="weimaraner">Weimaraner</option><option value="welsh-corgi">Welsh Corgi</option><option value="welsh-springer-spaniel">Welsh Springer Spaniel</option><option value="welsh-terrier">Welsh Terrier</option><option value="west-highland-white-terrier-westie">West Highland White Terrier Westie</option><option value="wheaten-terrier">Wheaten Terrier</option><option value="whippet">Whippet</option><option value="white-german-shepherd">White German Shepherd</option><option value="white-swiss-shepherd-dog-swiss-berger">White Swiss Shepherd Dog (Swiss Berger)</option><option value="wirehaired-pointing-griffon">Wire-haired Pointing Griffon</option><option value="wirehaired-fox-terrier">Wirehaired Fox Terrier</option><option value="wolf-dog">Wolf Dog</option><option value="xoloitzcuintlemexican-hairless">Xoloitzcuintle/Mexican Hairless</option><option value="yellow-labrador-retriever">Yellow Labrador Retriever</option><option value="yorkshire-terrier-yorkie">Yorkshire Terrier Yorkie</option>
    `;
  } else if (species == "exotic") {
    options = `
    <option selected="selected" value="default_option">All</option><option value="cheetah">Cheetah</option><option value="coyote">Coyote</option><option value="donkey">Donkey</option><option value="elephant">Elephant</option><option value="ferret">Ferret</option><option value="flamingo">Flamingo</option><option value="fox">Fox</option><option value="manatee">Manatee</option><option value="monkey">Monkey</option><option value="panda">Panda</option><option value="penguin">Penguin</option><option value="porcupine">Porcupine</option><option value="rabbit">Rabbit</option><option value="raccoon">Raccoon</option><option value="red-panda">Red Panda</option><option value="rhino">Rhino</option><option value="sea-lion">Sea Lion</option><option value="seal">Seal</option><option value="sloth">Sloth</option><option value="tiger">Tiger</option><option value="turtle">Turtle</option><option value="zebra">Zebra</option>
    `;
  } else if (species == "farm") {
    options = `
    <option selected="selected" value="default_option">All</option>
    <option value="cattle">Cattle</option>
    <option value="pig">Pig</option>
    <option value="goat">Goat</option>
    <option value="sheep">Sheep</option>
    <option value="chicken">Chicken</option>
    <option value="duck">Duck</option>
    `;
  } else if (species == "horse") {
    options = `
    <option selected="selected" value="default_option">All</option><option value="akhalteke">Akhal-Teke</option><option value="american-saddlebred">American Saddlebred</option><option value="andalusian">Andalusian</option><option value="angloarab">Anglo-Arab</option><option value="appaloosa">Appaloosa</option><option value="arabian">Arabian</option><option value="bashkir-curly">Bashkir Curly</option><option value="belgian">Belgian</option><option value="cleveland-bay">Cleveland Bay</option><option value="clydesdale">Clydesdale</option><option value="curly-horse">Curly Horse</option><option value="donkeymule">Donkey/Mule</option><option value="draft">Draft</option><option value="friesian">Friesian</option><option value="gaited">Gaited</option><option value="gelderlander">Gelderlander</option><option value="grade">Grade</option><option value="gypsy-vanner">Gypsy Vanner</option><option value="hanoverian">Hanoverian</option><option value="holsteiner">Holsteiner</option><option value="horse">Horse</option><option value="lipizzano">Lipizzano</option><option value="lusitano">Lusitano</option><option value="miniature-horse">Miniature Horse</option><option value="missouri-foxtrotter">Missouri Foxtrotter</option><option value="morgan">Morgan</option><option value="mustang">Mustang</option><option value="norwegian-fjord">Norwegian Fjord</option><option value="oldenburg">Oldenburg</option><option value="paintpinto">Paint/Pinto</option><option value="palomino">Palomino</option><option value="paso-fino">Paso Fino</option><option value="percheron">Percheron</option><option value="peruvian-paso">Peruvian Paso</option><option value="pony">Pony</option><option value="quarterhorse">Quarterhorse</option><option value="rocky-mountain">Rocky Mountain</option><option value="saddlebred">Saddlebred</option><option value="selle-francais">Selle Francais</option><option value="shetland-pony">Shetland Pony</option><option value="shire">Shire</option><option value="standardbred">Standardbred</option><option value="suffolk">Suffolk</option><option value="tennessee-walker">Tennessee Walker</option><option value="thoroughbred">Thoroughbred</option><option value="warmblood">Warmblood</option>
    `;
  } else if (species == "other") {
    options = `
    <option selected="selected" value="default_option">All</option>
    `;
  } else if (species == "unknown") {
    options = `
    <option selected="selected" value="default_option">All</option>
    `;
  }
  if (typeof species !== "string") {
    throw new Error("Species must be a string.");
  }
  $("#ssap-breed").html(
    `<select class="ssap-non-profit-page-select" id="ssap-breed">${options}</select>`
  );
}

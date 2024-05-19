//[Javascript]



$(function () {
    "use strict";   
		
	  $('#mainTable').editableTableWidget().numericInputExample().find('td:first').focus();
      $('#example1').editableTableWidget().numericInputExample().find('td:first').focus();
      
      $('#example1').editableTableWidget().find('td').on('validate', function(evt, newValue) {
        // 여기에 한글 입력을 허용하도록 유효성 검사 로직을 조정합니다.
        // 예: return true; // 모든 입력 허용

        return true;
    });
  }); // End of use strict
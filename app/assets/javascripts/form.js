jQuery(document).ready(function(){

	 jQuery(".form-edit").bootstrapValidator({
	        fields: {
	            'category[name]': {
	                validators: {
	                    notEmpty: {
	                        message: 'You must provide a Category Name.'
	                    }
	                }
	            },
			 	'garnish[name]': {
	                validators: {
	                    notEmpty: {
	                        message: 'You must provide a Garnish Name.'
	                    }
	                }
	            },
				'glass[name]': {
	                validators: {
	                    notEmpty: {
	                        message: 'You must provide a Glass Name.'
	                    }
	                }
	            },
	        }
	    })
	    .on('error.form.bv', function(e) {
	        alert(e)
	    });


 	jQuery(".form-edit-ingredient").bootstrapValidator({
        fields: {
            'ingredient[name]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Ingredient Name.'
                    }
                }
            },
		 	'ingredient[optionalassetname]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Optional As Set Name.'
                    }
                }
            },
            'ingredient[type]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Type.'
                    }
                }
            },
			'ingredient[cabinet]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Cabinet.'
                    },
                    integer: {
                        message: 'The value is not an integer',
                    }
                }
            },
            'ingredient[shoppingcart]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Shooping Cart.'
                    },
                    integer: {
                        message: 'The value is not an integer',
                    }
                }
            },
            'ingredient[scratchedoffshoppingcart]': {
                validators: {
                    notEmpty: {
                        message: 'You must provide a Scratched Off Shooping Cart.'
                    },
                    integer: {
                        message: 'The value is not an integer',
                    }
                }
            }
            
        }
    })
    .on('error.form.bv', function(e) {
        alert(e)
    });

	jQuery(".form-edit-recipe").bootstrapValidator({
	        fields: {
	            'recipe[name]': {
	                validators: {
	                    notEmpty: {
	                        message: 'You must provide a Recipe Name.'
	                    }
	                }
	            },
			 	'recipe[instructions]': {
	                validators: {
	                    notEmpty: {
	                        message: 'You must provide an Instructions.'
	                    }
	                }
	            },
				'recipe[alcoholic]': {
	                validators: {
	                    integer: {
                        	message: 'The value is not an integer',
                    	}
	                }
	            },
				'recipe[drinkid]': {
	                validators: {
	                    integer: {
                        	message: 'The value is not an integer',
                    	}
	                }
	            },
	            'recipe[edited]': {
	                validators: {
	                    integer: {
                        	message: 'The value is not an integer',
                    	}
	                }
	            },
	           	'recipe[favorite]': {
	                validators: {
	                    integer: {
                        	message: 'The value is not an integer',
                    	}
	                }
	            },
	           	'recipe[issuggested]': {
	                validators: {
	                    integer: {
                        	message: 'The value is not an integer',
                    	}
	                }
	            },

	        }
	    })
	    .on('error.form.bv', function(e) {
	        alert(e)
	    });



	
});
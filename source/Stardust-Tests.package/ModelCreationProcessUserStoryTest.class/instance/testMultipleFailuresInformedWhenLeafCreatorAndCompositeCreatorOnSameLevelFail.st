tests
testMultipleFailuresInformedWhenLeafCreatorAndCompositeCreatorOnSameLevelFail

	| inputView numberCodec discountView discountPicker productCreator supervisor |

	inputView := TextInputViewExample new.
	numberCodec :=
		TextCodec
			workingWith: (ContainerController named: 'text' controlling: inputView)
			parsingWith: MCPNumberParser new
			formattingWith: MCPNullFormatter new.
	discountView := SingleSelectionViewExample new.
	discountPicker := SingleModelPicker2 named: 'selection' obtainingSelectionFrom: discountView.
	productCreator :=
		(GenericModelCreatorBuilder
			named: 'product'
			building: MCPProduct
			accessedUsing: #(leftOperand rightOperand))
				of: numberCodec
				and: discountPicker.
	supervisor :=
		ModelCreationSupervisor
			supervising: productCreator
			showingErrorsAccordingTo: SupervisorStrategy displayingMultipleErrors.
	discountView allowAnyOf: self selectableDiscounts.
	inputView changeContentsTo: 'ABC'.
	self
		should: [supervisor model]
		raise: ModelCreationFailed
		withDescription: (
			self format: (
				SortedCollection
					with: #'text: ABC no representa un n˙mero'
					with: #'selection: Se debe seleccionar un elemento v·lido'))
#tag Module
Protected Module SegmentedControlExtensionsXC
	#tag Method, Flags = &h0, Description = 43616C6C2066726F6D20694F53566965772E4163746976617465206576656E742E2041646A757374732074686520666F6E742073697A65206163636F7264696E6720746F20617661696C61626C65207769647468
		Sub AdjustFontSizeToFitWidthXC(extends seg As iOSSegmentedControl)
		  //Requires UIKit
		  
		  #If ExtensionsXC.kUseUIKit
		    
		    
		    
		    Dim subViews As Foundation.NSArray
		    
		    Declare Function getSubviews Lib "UIKit.framework" selector "subviews" (id As ptr) As ptr
		    Declare Function isKindOfClass Lib "UIKit.framework" selector "isKindOfClass:" (obj_id As ptr, cls As ptr) As Boolean
		    Declare Sub setAdjustsFontSizeToFitWidth Lib "UIKit.framework" selector "setAdjustsFontSizeToFitWidth:" (id As ptr, value As Boolean)
		    
		    subViews = New Foundation.NSArray(getSubviews(seg.Handle))
		    
		    
		    For i As Integer = 0 To subViews.Count-1
		      
		      Dim view As ptr = subViews.Value(i)
		      
		      Dim subSubViews As Foundation.NSArray
		      subSubViews = New Foundation.NSArray(getSubviews(view))
		      
		      For j As Integer = 0 To subSubViews.Count-1
		        
		        Dim view2 As ptr = subSubViews.Value(j)
		        
		        If isKindOfClass(view2, Foundation.NSClassFromString("UILabel")) Then
		          
		          setAdjustsFontSizeToFitWidth(view2, True)
		          
		        End If
		      Next
		    Next
		    
		    
		  #EndIf
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImageWithColor(c As UIKit.UIColor) As ptr
		  // create a 1x1 image with this color
		  
		  Declare Sub UIGraphicsBeginImageContext Lib "UIKit.framework" (mSize As ExtensionsXC.xcCGSize)
		  Declare Function UIGraphicsGetCurrentContext Lib "UIKit.framework"  As ptr
		  Declare Sub CGContextSetFillColorWithColor Lib "CoreGraphics.framework" (context As ptr, Color As ptr)
		  Declare Sub CGContextFillRect Lib "CoreGraphics.framework" (context As ptr, rect As ExtensionsXC.xcCGRect)
		  Declare Function UIGraphicsGetImageFromCurrentImageContext Lib "UIKit.framework"  As ptr
		  Declare Sub UIGraphicsEndImageContext Lib "UIKit.framework" 
		  
		  
		  
		  Dim rect As ExtensionsXC.xcCGRect
		  Dim pt As ExtensionsXC.xcCGPoint
		  Dim sz As ExtensionsXC.xcCGSize
		  sz.width = 1.0
		  sz.height = 1.0
		  
		  rect.origin = pt
		  rect.rsize = sz
		  
		  UIGraphicsBeginImageContext(rect.rsize)
		  
		  Dim context As ptr = UIGraphicsGetCurrentContext
		  
		  
		  
		  CGContextSetFillColorWithColor(context, c.CGColor)
		  CGContextFillRect(context, rect)
		  
		  Dim newUIImage As Ptr = UIGraphicsGetImageFromCurrentImageContext
		  UIGraphicsEndImageContext
		  
		  Return newUIImage
		  
		  
		  'Private func imageWithColor(color: UIColor) -> UIImage {
		  'let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
		  'UIGraphicsBeginImageContext(rect.size)
		  'let context = UIGraphicsGetCurrentContext
		  'CGContextSetFillColorWithColor(context, Color.CGColor);
		  'CGContextFillRect(context, rect);
		  'let image = UIGraphicsGetImageFromCurrentImageContext;
		  'UIGraphicsEndImageContext;
		  'Return image
		  '}
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetNormalColorXC(extends seg As iOSSegmentedControl, c As color)
		  
		  Declare Sub setBackgroundImage_ Lib "UIKit.framework" selector "setBackgroundImage:forState:barMetrics:" (obj_id As ptr, image As ptr, state As UIControlState, barMetrics As Integer)
		  setBackgroundImage_(seg.Handle, imageWithColor(new UIColor(c)), UIControlState.Normal, 0)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRemoveBordersXC(extends seg As iOSSegmentedControl)
		  
		  
		  
		  Declare Sub setDividerImage Lib "UIKit.framework" selector "setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:" _
		  (obj_id As ptr, image As ptr, leftSegmentState As UIControlState, rightSegmentState As UIControlState, barMetrics As Integer)
		  
		  setDividerImage(seg.Handle, ImageWithColor(UIColor.ClearColor), UIControlState.Normal, UIControlState.Normal, 0)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetSelectedColorXC(extends seg As iOSSegmentedControl, c as color)
		  
		  Declare Sub setBackgroundImage_ Lib "UIKit.framework" selector "setBackgroundImage:forState:barMetrics:" (obj_id As ptr, image As ptr, state As UIControlState, barMetrics As Integer)
		  
		  setBackgroundImage_(seg.Handle, imageWithColor(New UIColor(c)), UIControlState.Selected, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTextColorXC(extends seg As iOSSegmentedControl, c As color, state As SegmentedControlExtensionsXC.UIControlState)
		  #If ExtensionsXC.kUseUIKit
		    
		    Dim constStr As Text = Foundation.StringConstant("UIKit.framework", "NSForegroundColorAttributeName")
		    
		    Dim constPtr As new NSString(constStr)
		    
		    Dim nsDic As Foundation.NSDictionary
		    
		    nsDic = Foundation.NSDictionary.CreateFromObject(constPtr, New UIColor(c))
		    
		    
		    Declare Sub setTitleTextAttributes Lib "UIKit.framework" selector "setTitleTextAttributes:forState:" _
		    (obj_id As ptr, att As ptr, state As UIControlState)
		    
		    setTitleTextAttributes(seg.Handle, nsDic, state)
		    
		  #else
		  	

		    Declare Function NSClassFromString Lib "Foundation.framework" (className As CFStringRef) As Ptr
		    declare function stringWithString lib "Foundation.framework" selector "stringWithString:" (class_id as Ptr, aString as CFStringRef) as Ptr
		    dim stringRef as Ptr = stringWithString(NSClassFromString("NSString"), "NSColor")

		    //Creating dictionary ref
		    declare function dictionaryWithObject lib "Foundation.framework" selector "dictionaryWithObject:forKey:" _
		      (class_id as Ptr, anObject as Ptr, key as Ptr) as Ptr


		    dim dictPtr as Ptr = dictionaryWithObject(NSClassFromString("NSDictionary"), New UIColor(c), stringRef) 


		    //Setting text attributes
		    Declare Sub setTitleTextAttributes Lib "UIKit.framework" selector "setTitleTextAttributes:forState:" _
		      (obj_id As ptr, att As ptr, state As UIControlState)

		    setTitleTextAttributes(seg.Handle, dictPtr, state)

		    
		  #EndIf
		End Sub
	#tag EndMethod


	#tag Enum, Name = UIControlState, Type = Integer, Flags = &h1
		Normal = 0
		  Highlighted = 1
		  Disabled = 2
		Selected = 4
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule

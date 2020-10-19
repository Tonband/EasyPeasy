// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if swift(>=4.2) && (os(iOS) || os(tvOS))
    import UIKit
    typealias LayoutConstraintAttribute = NSLayoutConstraint.Attribute
#elseif os(iOS) || os(tvOS)
    import UIKit
    typealias LayoutConstraintAttribute = NSLayoutAttribute
#elseif os(OSX) && swift(>=4.0)
    import AppKit
    typealias LayoutConstraintAttribute = NSLayoutConstraint.Attribute
#elseif os(OSX)
    import AppKit
    typealias LayoutConstraintAttribute = NSLayoutAttribute
#endif

/**
    An enum representation of the different attribute
    classes available
 */
public enum ReferenceAttribute {
    
    // Dimesion attributes
    case width
    case height
    
    // Position attributes
    case left
    case right
    case top
    case bottom
    case leading
    case trailing
    case centerX
    case centerY
    case firstBaseline
    case lastBaseline
#if os(iOS) || os(tvOS)
    case leftMargin
    case rightMargin
    case topMargin
    case bottomMargin
    case leadingMargin
    case trailingMargin
    case centerXWithinMargins
    case centerYWithinMargins
#endif
    
    /// Reference attribute opposite to the current one
    /// for those that have and need an opposite
    var opposite: ReferenceAttribute {
        switch self {
        case .left: return .right
        case .right: return .left
        case .top: return .bottom
        case .bottom: return .top
        case .leading: return .trailing
        case .trailing: return .leading
        #if os(iOS) || os(tvOS)
        case .leftMargin: return .rightMargin
        case .rightMargin: return .leftMargin
        case .topMargin: return .bottomMargin
        case .bottomMargin: return .topMargin
        case .leadingMargin: return .trailingMargin
        case .trailingMargin: return .leadingMargin
        case .centerXWithinMargins, .centerYWithinMargins:
            return self
        #endif
        case .width, .height, .centerX, .centerY, .firstBaseline, .lastBaseline:
            return self
        }
    }
    
    /// AutoLayout attribute equivalent of the current reference
    /// attribute
    var layoutAttribute: LayoutConstraintAttribute {
        switch self {
        case .width: return .width
        case .height: return .height
        case .left: return .left
        case .right: return .right
        case .top: return .top
        case .bottom:return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        case .centerY: return .centerY
        case .lastBaseline: return .lastBaseline
        case .firstBaseline:
            #if os(iOS) || os(tvOS)
            return .firstBaseline
            #else
            if #available(OSX 10.11, *) {
                return .firstBaseline
            } else {
                return .lastBaseline
            }
            #endif
        #if os(iOS) || os(tvOS)
        case .leftMargin: return .leftMargin
        case .rightMargin: return .rightMargin
        case .topMargin: return .topMargin
        case .bottomMargin: return .bottomMargin
        case .leadingMargin: return .leadingMargin
        case .trailingMargin: return .trailingMargin
        case .centerXWithinMargins: return .centerXWithinMargins
        case .centerYWithinMargins: return .centerYWithinMargins
        #endif
        }
    }
    
    /// Property that determines whether the constant of 
    /// the `Attribute` should be multiplied by `-1`. This
    /// is usually done for right hand `PositionAttribute`
    /// objects
    var shouldInvertConstant: Bool {
        switch self {
        case .width, .height, .centerX, .centerY:           return false
        case .left, .leading, .top, .firstBaseline:         return false
        case .right, .trailing, .bottom, .lastBaseline:     return true
        #if os(iOS) || os(tvOS)
        case .centerXWithinMargins, .centerYWithinMargins:  return false
        case .leftMargin, .leadingMargin, .topMargin:       return false
        case .rightMargin, .trailingMargin, .bottomMargin:  return true
        #endif
        }
    }
    
}

    
/**
    Extends `ReferenceAttribute` to ease the creation of
    an `Attribute` signature
 */
extension ReferenceAttribute {
    /// Signature of a `ReferenceAttribute`. Two possible values
    /// depending on the Axis the `ReferenceAttribute` applies
    var signatureString: String {
        switch self {
        case .left, .leading, .right, .trailing, .centerX, .width:
            return "h_"
        case .top, .firstBaseline, .bottom, .lastBaseline, .centerY, .height:
            return "v_"
        #if os(iOS) || os(tvOS)
        case .leftMargin, .leadingMargin, .rightMargin, .trailingMargin, .centerXWithinMargins:
            return "h_"
        case .topMargin, .bottomMargin, .centerYWithinMargins:
            return "v_"
        #endif
        }
    }
    
}

// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

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
    case leftMargin
    case rightMargin
    case topMargin
    case bottomMargin
    case leadingMargin
    case trailingMargin
    case centerXWithinMargins
    case centerYWithinMargins
    
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
        case .leftMargin: return .rightMargin
        case .rightMargin: return .leftMargin
        case .topMargin: return .bottomMargin
        case .bottomMargin: return .topMargin
        case .leadingMargin: return .trailingMargin
        case .trailingMargin: return .leadingMargin
        case .centerXWithinMargins, .centerYWithinMargins:
            return self
        case .width, .height, .centerX, .centerY, .firstBaseline, .lastBaseline:
            return self
        }
    }
    
    /// AutoLayout attribute equivalent of the current reference
    /// attribute
    var layoutAttribute: NSLayoutConstraint.Attribute {
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
        case .firstBaseline: return .firstBaseline
        case .leftMargin: return .leftMargin
        case .rightMargin: return .rightMargin
        case .topMargin: return .topMargin
        case .bottomMargin: return .bottomMargin
        case .leadingMargin: return .leadingMargin
        case .trailingMargin: return .trailingMargin
        case .centerXWithinMargins: return .centerXWithinMargins
        case .centerYWithinMargins: return .centerYWithinMargins
        }
    }
    
    /// Property that determines whether the constant of 
    /// the `Attribute` should be multiplied by `-1`. This
    /// is usually done for right hand `PositionAttribute`
    /// objects
    var shouldInvertConstant: Bool {
        switch self {
        case .width, .height, .centerX, .centerY, .centerXWithinMargins, .centerYWithinMargins:
            return false
        case .left, .leading, .top, .firstBaseline, .leftMargin, .leadingMargin, .topMargin:
            return false
        case .right, .trailing, .bottom, .lastBaseline, .rightMargin, .trailingMargin, .bottomMargin:
            return true
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
        case .left, .leftMargin, .leading, .leadingMargin, .right, .rightMargin,
             .trailing, .trailingMargin, .centerX, .centerXWithinMargins, .width:
            return "h_"
        case .top, .topMargin, .firstBaseline, .bottom, .bottomMargin, .lastBaseline,
             .centerY, .centerYWithinMargins, .height:
            return "v_"
        }
    }
    
}

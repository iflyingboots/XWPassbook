# XWPassbook

A parody of Passbook in iOS.

![Demo](https://github.com/sutar/XWPassbook/raw/master/PassbookDemo.gif?raw=true)

## Installation
Copy `XWPassbook` folder to your project.

## Usage
First, import the header file: `#import "XWPassbook.h"`

Then create some `XWPassbookPage` instances and do whatever you want with these pages. For instance, you can configure the background color (I've prepared a gloss effect for you :smirk: ).

```objc
XWPassbookPage *passbookPage1 = [[XWPassbookPage alloc] init];
passbookPage1.pageBackgroundColor = [UIColor colorWithRed:200.0/255.0 green:22.0/255.0 blue:120.0/255.0 alpha:1.0];
    
XWPassbookPage *passbookPage2 = [[XWPassbookPage alloc] init];
passbookPage2.pageBackgroundColor = [UIColor colorWithRed:2.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];

XWPassbookPage *passbookPage3 = [[XWPassbookPage alloc] init];
passbookPage3.pageBackgroundColor = [UIColor colorWithRed:222.0/255.0 green:992.0/255.0 blue:10.0/255.0 alpha:1.0];
    
XWPassbookPage *passbookPage4 = [[XWPassbookPage alloc] init];
passbookPage4.pageBackgroundColor = [UIColor colorWithRed:20.0/255.0 green:99.0/255.0 blue:120.0/255.0 alpha:1.0];

```

And set up the `XWPassbook` instance, adding the pages:

```objc
XWPassbook *passbook = [[XWPassbook alloc]  initWithFrame:self.view.bounds];
[passbook addPage:passbookPage1];
[passbook addPage:passbookPage2];
[passbook addPage:passbookPage3];
[passbook addPage:passbookPage4];

[self.view addSubview:passbook];
```

That's all you need to do, voila.

## Demo
Kindly find and run `XWPassbookDemo.xcodeproj` project.

## License
MIT license.

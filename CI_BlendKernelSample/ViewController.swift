import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // get source image
        let inputUiImage = UIImage(named: "kerokero")!      // get the image in assets.
        let inputCiImage = CIImage(image: inputUiImage)!    // convert to CIImage
        let inputUiImageBg = UIImage(named: "colorBar")!        // get the image in assets.
        let inputCiImageBg = CIImage(image: inputUiImageBg)!    // convert to CIImage



        // filter
        let filter = MyFilter()
        filter.inputImage = inputCiImage
        filter.inputImageBg = inputCiImageBg
        let outputCiImage = filter.outputImage!


        // view
        let outputUiImage = UIImage(ciImage: outputCiImage)
        imageView.image = outputUiImage

    }

}

class MyFilter: CIFilter {

    private let kernel: CIBlendKernel

    var inputImage: CIImage?
    var inputImageBg: CIImage?

    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIBlendKernel(functionName: "blend", fromMetalLibraryData: data)
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage : CIImage? {
        guard let inputImage = inputImage else { return nil }
        guard let inputImageBg = inputImageBg else { return nil }
        return kernel.apply(
                foreground: inputImage,
                background: inputImageBg
            )

    }
}

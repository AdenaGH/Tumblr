//
//  PhotosViewController.m
//  Tumblr
//
//  Created by Adena Rowana Ninvalle on 6/24/21.
//

#import "PhotosViewController.h"
#import "PhotoCellTableViewCell.h"

@interface PhotosViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PhotosViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.rowHeight = 118;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                // TODO: Get the posts and store in posts property
                // TODO: Reload the table view
                NSDictionary *responseDict = dataDictionary[@"response"];
                self.posts = responseDict[@"posts"];
                [self.tableView reloadData];
                NSLog(@"reloading data");
            }
        }];
    [task resume];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell" ];
    //cell.textLabel.text = [NSString stringWithFormat:@"This is row %ld", (long)indexPath.row];
    NSDictionary *post = self.posts[indexPath.row];
    NSArray *photos = post[@"photos"];
    if (photos) {
        // 1. Get the first photo in the photos array
        NSDictionary *photo = photos[0];

        // 2. Get the original size dictionary from the photo
        NSDictionary *originalSize =  photo[@"original_size"];

        // 3. Get the url string from the original size dictionary
        NSString *urlString = originalSize[@"url"];

        // 4. Create a URL using the urlString
        NSURL *url = [NSURL URLWithString:urlString];
        
        // Download the image
        [cell.photoView setImageWithURL:url];
    } else {
        NSLog(@"No photos");
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

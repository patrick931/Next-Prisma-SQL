BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Category] (
    [categoryId] INT NOT NULL IDENTITY(1,1),
    [categoryName] VARCHAR(50) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Category_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Category_pkey] PRIMARY KEY ([categoryId]),
    CONSTRAINT [Category_categoryName_key] UNIQUE ([categoryName])
);

-- CreateTable
CREATE TABLE [dbo].[ProductType] (
    [productTypeId] INT NOT NULL IDENTITY(1,1),
    [productTypeName] VARCHAR(50) NOT NULL,
    [categoryId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [ProductType_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [ProductType_pkey] PRIMARY KEY ([productTypeId]),
    CONSTRAINT [ProductType_productTypeName_key] UNIQUE ([productTypeName])
);

-- CreateTable
CREATE TABLE [dbo].[Product] (
    [productId] INT NOT NULL IDENTITY(1,1),
    [productSKU] VARCHAR(50) NOT NULL,
    [ProductName] VARCHAR(255) NOT NULL,
    [buyingPrice] DECIMAL(9,2) NOT NULL,
    [sellingPrice] DECIMAL(9,2) NOT NULL,
    [discountId] INT,
    [productWeight] DECIMAL(9,2),
    [imageOneUrl] NVARCHAR(1000),
    [imageTwoUrl] NVARCHAR(1000),
    [imageThreeUrl] NVARCHAR(1000),
    [isActive] BIT NOT NULL CONSTRAINT [Product_isActive_df] DEFAULT 0,
    [productDescription] VARCHAR(255),
    [productTypeId] INT NOT NULL,
    [taxClassId] INT NOT NULL,
    [unitOfMeasureId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Product_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [Product_pkey] PRIMARY KEY ([productId]),
    CONSTRAINT [Product_productSKU_key] UNIQUE ([productSKU]),
    CONSTRAINT [Product_ProductName_key] UNIQUE ([ProductName])
);

-- CreateTable
CREATE TABLE [dbo].[Discount] (
    [discountId] INT NOT NULL IDENTITY(1,1),
    [dicountName] VARCHAR(50) NOT NULL,
    [discountDescription] VARCHAR(255),
    [dicountPercent] DECIMAL(9,2) NOT NULL,
    [isActive] BIT NOT NULL CONSTRAINT [Discount_isActive_df] DEFAULT 0,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Discount_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [Discount_pkey] PRIMARY KEY ([discountId]),
    CONSTRAINT [Discount_dicountName_key] UNIQUE ([dicountName])
);

-- CreateTable
CREATE TABLE [dbo].[UnitOfMeasureType] (
    [unitOfMeasureTypeId] INT NOT NULL IDENTITY(1,1),
    [unitOfMeasuretypeName] VARCHAR(50) NOT NULL,
    [isActive] BIT NOT NULL CONSTRAINT [UnitOfMeasureType_isActive_df] DEFAULT 0,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [UnitOfMeasureType_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [UnitOfMeasureType_pkey] PRIMARY KEY ([unitOfMeasureTypeId]),
    CONSTRAINT [UnitOfMeasureType_unitOfMeasuretypeName_key] UNIQUE ([unitOfMeasuretypeName])
);

-- CreateTable
CREATE TABLE [dbo].[UnitOfMeasure] (
    [unitOfMeasureId] INT NOT NULL IDENTITY(1,1),
    [unitOfMeasureName] VARCHAR(50) NOT NULL,
    [isActive] BIT NOT NULL CONSTRAINT [UnitOfMeasure_isActive_df] DEFAULT 0,
    [unitOfMeasureTypeId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [UnitOfMeasure_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [UnitOfMeasure_pkey] PRIMARY KEY ([unitOfMeasureId]),
    CONSTRAINT [UnitOfMeasure_unitOfMeasureName_key] UNIQUE ([unitOfMeasureName])
);

-- CreateTable
CREATE TABLE [dbo].[ProductInventory] (
    [productInventoryId] INT NOT NULL IDENTITY(1,1),
    [quantity] DECIMAL(10,2) NOT NULL,
    [productId] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [ProductInventory_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [ProductInventory_pkey] PRIMARY KEY ([productInventoryId])
);

-- CreateTable
CREATE TABLE [dbo].[TaxClass] (
    [taxClassId] INT NOT NULL IDENTITY(1,1),
    [taxClassName] VARCHAR(50) NOT NULL,
    [taxRate] DECIMAL(2,2) NOT NULL,
    [isActive] BIT NOT NULL CONSTRAINT [TaxClass_isActive_df] DEFAULT 0,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [TaxClass_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [TaxClass_pkey] PRIMARY KEY ([taxClassId]),
    CONSTRAINT [TaxClass_taxClassName_key] UNIQUE ([taxClassName])
);

-- CreateTable
CREATE TABLE [dbo].[OrderItems] (
    [orderId] INT NOT NULL IDENTITY(1,1),
    [productId] INT NOT NULL,
    [quantity] DECIMAL(10,2) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [OrderItems_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [OrderItems_pkey] PRIMARY KEY ([orderId])
);

-- CreateTable
CREATE TABLE [dbo].[User] (
    [userId] NVARCHAR(1000) NOT NULL,
    [firstName] VARCHAR(250) NOT NULL,
    [lastName] VARCHAR(250) NOT NULL,
    [email] VARCHAR(250) NOT NULL,
    [phone] VARCHAR(250) NOT NULL,
    [password] VARCHAR(250) NOT NULL,
    [emailConfirmed] BIT NOT NULL CONSTRAINT [User_emailConfirmed_df] DEFAULT 0,
    [isActive] BIT NOT NULL CONSTRAINT [User_isActive_df] DEFAULT 1,
    [isAdmin] BIT NOT NULL CONSTRAINT [User_isAdmin_df] DEFAULT 0,
    [registeredAt] DATETIME2 NOT NULL CONSTRAINT [User_registeredAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [User_pkey] PRIMARY KEY ([userId]),
    CONSTRAINT [User_email_key] UNIQUE ([email]),
    CONSTRAINT [User_phone_key] UNIQUE ([phone])
);

-- CreateTable
CREATE TABLE [dbo].[Profile] (
    [profileId] NVARCHAR(1000) NOT NULL,
    [bio] VARCHAR(250),
    [imageUrl] VARCHAR(250),
    [userId] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Profile_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [Profile_pkey] PRIMARY KEY ([profileId]),
    CONSTRAINT [Profile_userId_key] UNIQUE ([userId])
);

-- AddForeignKey
ALTER TABLE [dbo].[ProductType] ADD CONSTRAINT [ProductType_categoryId_fkey] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([categoryId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_productTypeId_fkey] FOREIGN KEY ([productTypeId]) REFERENCES [dbo].[ProductType]([productTypeId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_discountId_fkey] FOREIGN KEY ([discountId]) REFERENCES [dbo].[Discount]([discountId]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_unitOfMeasureId_fkey] FOREIGN KEY ([unitOfMeasureId]) REFERENCES [dbo].[UnitOfMeasure]([unitOfMeasureId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [Product_taxClassId_fkey] FOREIGN KEY ([taxClassId]) REFERENCES [dbo].[TaxClass]([taxClassId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[UnitOfMeasure] ADD CONSTRAINT [UnitOfMeasure_unitOfMeasureTypeId_fkey] FOREIGN KEY ([unitOfMeasureTypeId]) REFERENCES [dbo].[UnitOfMeasureType]([unitOfMeasureTypeId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ProductInventory] ADD CONSTRAINT [ProductInventory_productId_fkey] FOREIGN KEY ([productId]) REFERENCES [dbo].[Product]([productId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[OrderItems] ADD CONSTRAINT [OrderItems_productId_fkey] FOREIGN KEY ([productId]) REFERENCES [dbo].[Product]([productId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Profile] ADD CONSTRAINT [Profile_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[User]([userId]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
